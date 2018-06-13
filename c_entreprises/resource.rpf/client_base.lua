local current_jobid = 0
local current_leader = false
local doing_recolt = false
local doing_traitement = false
local doing_vente = false
local total_vente = 0
local autorisation = false
local check_jobcar = true
local reloading = false
local blips_temp = {}
local DEBUG = false
local PlayerId = 0
AddEventHandler('playerSpawned', function()
    Initialisation_Systeme_Metiers()
    Initialisation_PoPole_Emploi()
	TriggerServerEvent('entreprises:getUser')
end)

-- DEBUG
--[[
Citizen.CreateThread(function()
    DEBUG = true
    Initialisation_Systeme_Metiers()
    Initialisation_PoPole_Emploi()
end)
]]--
--

function Initialisation_Systeme_Metiers()
    Citizen.CreateThread(function()
        reloading = true
        Citizen.Wait(1000)
        CheckCurrentJob()
        Citizen.Wait(2000)
        RemoveOldBlips()
        Citizen.Wait(1000)
        DrawBlips()
        Citizen.Wait(1000)
        reloading = false
        Citizen.Wait(1000)
        while not reloading do
            Citizen.Wait(1)
            InitMarker()
            GetPedDistanceFromJobPoint()
        end
    end)
end

function Initialisation_PoPole_Emploi()
    -- POLE EMPLOI
    for e = 1, #pole_emploi do
        pole_emploi[e].blip = AddBlipForCoord(pole_emploi[e].x, pole_emploi[e].y, pole_emploi[e].z)
        SetBlipSprite(pole_emploi[e].blip, pole_emploi[e].id)
        SetBlipAsShortRange(pole_emploi[e].blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(pole_emploi[e].nom)
        EndTextCommandSetBlipName(pole_emploi[e].blip)
    end
end

function CheckCurrentJob()
    TriggerServerEvent("entreprises:CheckMyJobAndLead")
end

function RemoveOldBlips()
    --print(blips_temp)
    if(blips_temp ~= nil) then
        for k, v in pairs(blips_temp) do
            RemoveBlip(v.blip)
        end
    end
end

function DrawBlips()
    --
    for _, item in pairs(entreprises) do
        if (not item.loop_ignore) and (current_jobid == item.jobid) then
            -- ENTREPRISE

            item.blip = AddBlipForCoord(item.entreprise.x, item.entreprise.y, item.entreprise.z)
            SetBlipSprite(item.blip, item.entreprise.id)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.entreprise.nom)
            EndTextCommandSetBlipName(item.blip)
            --
            table.insert(blips_temp, {blip = item.blip})

            -- GARAGE
            item.blip = AddBlipForCoord(item.garage.x, item.garage.y, item.garage.z)
            SetBlipSprite(item.blip, item.garage.id)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.garage.nom)
            EndTextCommandSetBlipName(item.blip)
            --
            table.insert(blips_temp, {blip = item.blip})

            -- RECOLTE
            for e = 1, #item.recolte do
                item.blip = AddBlipForCoord(item.recolte[e].x, item.recolte[e].y, item.recolte[e].z)
                SetBlipSprite(item.blip, item.recolte[e].id)
                SetBlipAsShortRange(item.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(e .. " - " ..item.recolte[e].nom)
                EndTextCommandSetBlipName(item.blip)
                table.insert(blips_temp, {blip = item.blip})
            end
            --
            -- TRAITEMENT
            for e = 1, #item.traitement do
                item.blip = AddBlipForCoord(item.traitement[e].x, item.traitement[e].y, item.traitement[e].z)
                SetBlipSprite(item.blip, item.traitement[e].id)
                SetBlipAsShortRange(item.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(e .. " - " .. item.traitement[e].nom)
                EndTextCommandSetBlipName(item.blip)
                table.insert(blips_temp, {blip = item.blip})
            end
            -- VENTE
            for e = 1, #item.vente do
                item.blip = AddBlipForCoord(item.vente[e].x, item.vente[e].y, item.vente[e].z)
                SetBlipSprite(item.blip, item.vente[e].id)
                SetBlipAsShortRange(item.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(e .. " - " .. item.vente[e].nom)
                EndTextCommandSetBlipName(item.blip)
                table.insert(blips_temp, {blip = item.blip})
            end
        end
    end
end

function InitMarker()
    for _, v in pairs(entreprises) do
        if (not v.loop_ignore) and (current_jobid == v.jobid) then
            if(current_leader) then -- Vérifie si le joueur est le patron
                DrawMarker(1, v.coffre.x, v.coffre.y, v.coffre.z, 0, 0, 0, 0, 0, 0, v.coffre.CircleDiameter, v.coffre.CircleDiameter, 0.5, 255, 255, 255, 200, v.coffre.CircleBounce, 0, 2, 0, 0, 0, 0) -- COFFRE
            end
            DrawMarker(1, v.entreprise.x, v.entreprise.y, v.entreprise.z, 0, 0, 0, 0, 0, 0, v.entreprise.CircleDiameter, v.entreprise.CircleDiameter, 0.5, 255, 255, 255, 200, v.entreprise.CircleBounce, 0, 2, 0, 0, 0, 0) -- ENTREPRISE
            if(_G[v.check_service]() or DEBUG) then -- Vérifie si le joueur est en service
                DrawMarker(1, v.garage.x, v.garage.y, v.garage.z, 0, 0, 0, 0, 0, 0, v.garage.CircleDiameter, v.garage.CircleDiameter, 0.5, 55, 25, 155, 200, v.garage.CircleBounce, 0, 2, 0, 0, 0, 0) -- GARAGE
                for e = 1, #v.recolte do
                    DrawMarker(1, v.recolte[e].x, v.recolte[e].y, v.recolte[e].z, 0, 0, 0, 0, 0, 0, v.recolte[e].CircleDiameter, v.recolte[e].CircleDiameter, 0.5, 155, 205, 125, 200, v.recolte[e].CircleBounce, 0, 2, 0, 0, 0, 0) -- RECOLTE
                end
                for e = 1, #v.traitement do
                    DrawMarker(1, v.traitement[e].x, v.traitement[e].y, v.traitement[e].z, 0, 0, 0, 0, 0, 0, v.traitement[e].CircleDiameter, v.traitement[e].CircleDiameter, 0.5, 155, 205, 125, 200, v.traitement[e].CircleBounce, 0, 2, 0, 0, 0, 0) -- TRAITEMENT
                end
                for e = 1, #v.vente do
                    DrawMarker(1, v.vente[e].x, v.vente[e].y, v.vente[e].z, 0, 0, 0, 0, 0, 0, v.vente[e].CircleDiameter, v.vente[e].CircleDiameter, 0.5, 155, 205, 125, 200, v.vente[e].CircleBounce, 0, 2, 0, 0, 0, 0) -- VENTE
                end
            end
            
        end
    end
end

function CheckPedCarForJob(vehicules)
    if check_jobcar then
        check_jobcar = not check_jobcar
        Citizen.CreateThread(function()
            if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
                autorisation = false
                for _, v in pairs(vehicules) do
                    if(IsPedInModel(GetPlayerPed(-1), GetHashKey(v.model))) then
                        autorisation = true
                        break
                    end
                end
            end
            Citizen.Wait(5000)
            check_jobcar = true
        end)
    end
end

function GetPedDistanceFromJobPoint()
    local ped = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(ped, true)
    for e = 1, #pole_emploi do
        if (GetDistanceBetweenCoords(playerPos, pole_emploi[e].x, pole_emploi[e].y, pole_emploi[e].z, true) < 15) then
            DrawMarker(1, pole_emploi[e].x, pole_emploi[e].y, pole_emploi[e].z, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 0.5, 255, 255, 255, 200, 1, 0, 2, 0, 0, 0, 0)
            -- DrawText3D(pole_emploi[e].x, pole_emploi[e].y, pole_emploi[e].z + 1, pole_emploi[e].nom)
            if (GetDistanceBetweenCoords(playerPos, pole_emploi[e].x, pole_emploi[e].y, pole_emploi[e].z, true) < 3.0) then
                if (Menu.hidden) then
                    DisplayHelpText('Appuyez sur ~INPUT_CONTEXT~ pour rechercher un emploi', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                end
                if (IsControlJustPressed(1, 51)) then
                    PoleMainMenu()
                    Menu.hidden = false
                end
                Menu.renderGUI(options)
            end
        end
    end
    for _, v in pairs(entreprises) do
        if (not v.loop_ignore) and (current_jobid == v.jobid) then
            -- COFFRES
            if(current_leader and (v.coffre.x ~= nil)) then -- Vérifie si le joueur est le patron
                if GetDistanceBetweenCoords(playerPos, v.coffre.x, v.coffre.y, v.coffre.z, true) < v.coffre.distDraw then
                    -- DrawText3D(v.coffre.x, v.coffre.y, v.coffre.z + 1, "Coffre " .. v.nom)
                end
                if GetDistanceBetweenCoords(playerPos, v.coffre.x, v.coffre.y, v.coffre.z, true) < v.coffre.distActivate then
                    DisplayHelpText('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir gérer votre entreprise', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                    if (IsControlJustPressed(1, 51)) then
                        CoffreMainmenu(v.jobid, v.metier)
                        Menu.hidden = false
                    end
                    Menu.renderGUI(options)
                end
            end
            --
            -- ENTREPRISE
            if(v.entreprise.x ~= nil) then
               -- if GetDistanceBetweenCoords(playerPos, v.entreprise.x, v.entreprise.y, v.entreprise.z, true) < v.entreprise.distDraw then
              --      DrawText3D(v.entreprise.x, v.entreprise.y, v.entreprise.z + 1, "["..v.nom.."] " .. v.entreprise.nom)
              --  end
                if GetDistanceBetweenCoords(playerPos, v.entreprise.x, v.entreprise.y, v.entreprise.z, true) < v.entreprise.distActivate then
                    DisplayHelpText('Appuyez sur ~INPUT_CONTEXT~ pour prendre votre service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                    if (IsControlJustPressed(1, 51)) then
                        DisplayHelpText('Changement de tenue en cours ...', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                        Citizen.Wait(2000)
                        _G[v.entreprise.fonction]()
                        Citizen.Wait(2000)
                    end
                end
            end
            --
            if(_G[v.check_service]() or DEBUG) then -- Vérifie si le joueur est en service
                -- GARAGE
                if(v.garage.z ~= nil) then
                    if GetDistanceBetweenCoords(playerPos, v.garage.x, v.garage.y, v.garage.z, true) < v.garage.distDraw then
                        -- DrawText3D(v.garage.x, v.garage.y, v.garage.z + 1, "["..v.nom.."] " .. v.garage.nom)
                    end
                    if GetDistanceBetweenCoords(playerPos, v.garage.x, v.garage.y, v.garage.z, true) < v.garage.distActivate then
                        DisplayHelpText('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le Garage de votre entreprise', 4, 4, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                        if (IsControlJustPressed(1, 51)) then
                            DisplayHelpText('Ouverture du Garage ...', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                            _G[v.garage.fonction](v.garage.x, v.garage.y, v.garage.z, v.vehicules, PlayerId)
                            Menu.hidden = false
                            Citizen.Wait(2000)
                        end
                        Menu.renderGUI(options)
                    end
                end
                --
                -- RECOLTE
                for e = 1, #v.recolte do
                    if(v.recolte[e].x ~= nil) then
                        if GetDistanceBetweenCoords(playerPos, v.recolte[e].x, v.recolte[e].y, v.recolte[e].z, true) < v.recolte[e].distDraw then
                            -- DrawText3D(v.recolte[e].x, v.recolte[e].y, v.recolte[e].z + 1, "["..v.nom.."] " .. v.recolte[e].nom)
                            CheckPedCarForJob(v.vehicules)
                        end
                        if (GetDistanceBetweenCoords(playerPos, v.recolte[e].x, v.recolte[e].y, v.recolte[e].z, true) < v.recolte[e].distActivate) and not doing_recolt then
                            if(v.recolte[e].forcecar and autorisation) or (not v.recolte[e].forcecar) then
                                if (not IsPedInAnyVehicle(ped, false)) or (not v.recolte[e].forcepedincar) then
                                    if v.recolte[e].fonction == nil then
                                        doing_recolt = true
                                        GetRecolte(v.recolte[e].giveItem, v.recolte[e].maxQuantity)
                                    else
                                        _G[v.recolte[e].fonction](v.recolte[e].x, v.recolte[e].y, v.recolte[e].z, v.recolte[e].giveItem, v.recolte[e].maxQuantity, v.vehicules)
                                        -- (Coordx,Coordy,Coordz,Item_Gived,Max_Quantity,Vehicules)
                                    end
                                else
                                    DisplayHelpText('Tu ne peux pas faire ça si tu n\'es pas en dehors d\'un véhicule !', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                                end
                            end
                        end
                    end
                end
                --
                -- TRAITEMENT
                for e = 1, #v.traitement do
                    if(v.traitement[e].x ~= nil) then
                        if GetDistanceBetweenCoords(playerPos, v.traitement[e].x, v.traitement[e].y, v.traitement[e].z, true) < v.traitement[e].distDraw then
                            -- DrawText3D(v.traitement[e].x, v.traitement[e].y, v.traitement[e].z + 1, "["..v.nom.."] " .. v.traitement[e].nom)
                            CheckPedCarForJob(v.vehicules)
                        end
                        if (GetDistanceBetweenCoords(playerPos, v.traitement[e].x, v.traitement[e].y, v.traitement[e].z, true) < v.traitement[e].distActivate) and not doing_traitement then
                            if(v.traitement[e].forcecar and autorisation) or (not v.traitement[e].forcecar) then
                                if (not IsPedInAnyVehicle(ped, false)) or (not v.traitement[e].forcepedincar) then
                                    if v.traitement[e].fonction == nil then
                                        doing_traitement = true
                                        total_vente = 0
                                        --DisplayHelpText('Traitement en cours...', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                                        --
                                        local used_item_maxquantity = 0
                                        for f = 1, #v.recolte do
                                            if (v.recolte[f].giveItem == v.traitement[e].requireItem) then
                                                used_item_maxquantity = v.recolte[f].maxQuantity
                                                
                                            end
                                        end
                                        --
                                        SetTraitement(v.traitement[e].requireItem, v.traitement[e].giveItem, v.traitement[e].maxQuantity, used_item_maxquantity)
                                    else
                                        _G[v.traitement[e].fonction](v.traitement[e].x, v.traitement[e].y, v.traitement[e].z, v.traitement[e].requireItem, v.traitement[e].giveItem, v.traitement[e].maxQuantity, v.vehicules)
                                        -- (Coordx,Coordy,Coordz,Item_Required,Item_Gived,Max_Quantity,Vehicules)
                                    end
                                else
                                    DisplayHelpText('Tu ne peux pas faire ça si tu n\'es pas en dehors d\'un véhicule !', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                                end
                            end
                        end
                    end
                end
                --
                -- VENTE
                for e = 1, #v.vente do
                    if(v.vente[e].x ~= nil) then
                        if GetDistanceBetweenCoords(playerPos, v.vente[e].x, v.vente[e].y, v.vente[e].z, true) < v.vente[e].distDraw then
                            -- DrawText3D(v.vente[e].x, v.vente[e].y, v.vente[e].z + 1, "["..v.nom.."] " .. v.vente[e].nom)
                            CheckPedCarForJob(v.vehicules)
                        end
                        if (GetDistanceBetweenCoords(playerPos, v.vente[e].x, v.vente[e].y, v.vente[e].z, true) < v.vente[e].distActivate) and not doing_vente then
                            if(v.vente[e].forcecar and autorisation) or (not v.vente[e].forcecar) then
                                if (not IsPedInAnyVehicle(ped, false)) or (not v.vente[e].forcepedincar) then
                                    if v.vente[e].fonction == nil then
                                        doing_vente = true
                                        --DisplayHelpText('Vente en cours...', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                                        --
                                        local used_item_maxquantity = 0
                                        for f = 1, #v.traitement do
                                            if (v.traitement[f].giveItem == v.vente[e].requireItem) then
                                                used_item_maxquantity = v.traitement[f].maxQuantity
                                                
                                            end
                                        end
                                        --
                                        SetVente(v.vente[e].requireItem, used_item_maxquantity, v.vente[e].minprice, v.vente[e].maxprice, v.metier_prive)
                                    else
                                        _G[v.vente[e].fonction](v.vente[e].x, v.vente[e].y, v.vente[e].z, v.vente[e].requireItem, v.vente[e].minprice, v.vente[e].maxprice, v.vehicules)
                                        -- (Coordx,Coordy,Coordz,Item_Required,MinPrice,MaxPrice,Vehicules)
                                    end
                                else
                                    DisplayHelpText('Tu ne peux pas faire ça si tu n\'es pas en dehors d\'un véhicule !', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                                end
                            end
                        end
                    end
                end
                --
            end
            
        end
    end
end

function SetVente(item_used, max_quantity_used, sell_minprice, sell_maxprice, isPrivate)
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        if(exports["vdk_inventory"]:getQuantity(item_used) > max_quantity_used) and (max_quantity_used > 0) then
            DisplayHelpText('Vous avez trop de ressources sur vous, vous avez fait quelque chose de mal...', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
            Citizen.Wait(4000)
            doing_vente = false
        else
            if(math.floor(exports["vdk_inventory"]:getQuantity(item_used)) >= 1) then
                DisplayMuteText('Vente en cours...')
                TriggerEvent('player:looseItem', item_used, 1)
                --
                local vente_unite = math.random(sell_minprice, sell_maxprice)
                total_vente = total_vente + vente_unite
                if total_vente > 2500 then
                    TriggerServerEvent('entreprises:sellpartage', total_vente)
                    --[[
                    SetNotificationTextEntry('STRING')
                    AddTextEntry('PSF_DICK', 'Paiement final effectué !')
                    AddTextComponentSubstringPlayerName(tostring(total_vente) .. '/2500~g~$')
                    local calc_unit_percent = math.floor((total_vente * 100) / 2500)
                    Citizen.InvokeNative(0x2B7E9A4EAAA93C89, 'PSF_DICK', 23, 100, calc_unit_percent, 40, "CHAR_BANK_MAZE", "CHAR_BANK_MAZE")
                    DrawNotification(false, false)
                    --]]
                    total_vente = 0
                end
                --
                Citizen.Wait(2000)
                --[[
                SetNotificationTextEntry('STRING')
                AddTextEntry('PSF_DICK', 'Paiement en attente...')
                AddTextComponentSubstringPlayerName(tostring(total_vente) .. '/2500~g~$')
                local calc_unit_percent = math.floor((total_vente * 100) / 2500)
                Citizen.InvokeNative(0x2B7E9A4EAAA93C89, 'PSF_DICK', 23, 100, calc_unit_percent, 40, "CHAR_BANK_MAZE", "CHAR_BANK_MAZE")
                DrawNotification(false, false)
                --]]
                DisplayMuteText('Ressource vendue ' .. vente_unite .. '~g~$')
                Citizen.Wait(2000)
                doing_vente = false
            else
                DisplayHelpText('Vous ne pouvez pas vendre car vous n\'avez pas assez de ressources !', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                --
                if total_vente > 0 then
                    TriggerServerEvent('entreprises:sellpartage', total_vente)
                    --[[
                    SetNotificationTextEntry('STRING')
                    AddTextEntry('PSF_DICK', 'Paiement final effectué !')
                    AddTextComponentSubstringPlayerName(tostring(total_vente) .. '/2500~g~$')
                    local calc_unit_percent = math.floor((total_vente * 100) / 2500)
                    Citizen.InvokeNative(0x2B7E9A4EAAA93C89, 'PSF_DICK', 23, 100, calc_unit_percent, 40, "CHAR_BANK_MAZE", "CHAR_BANK_MAZE")
                    DrawNotification(false, false)
                    --]]
                    total_vente = 0
                end
                --
                Citizen.Wait(4000)
                doing_vente = false
            end
        end
    end)
end

function SetTraitement(item_used, item_gived, max_quantity_gived, max_quantity_used)
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        if(exports["vdk_inventory"]:notFull() == true) then
            if(exports["vdk_inventory"]:getQuantity(item_used) > 0) then
                if(exports["vdk_inventory"]:getQuantity(item_used) > max_quantity_used) and (max_quantity_used > 0) then
                    DisplayHelpText('Vous avez trop de ressources sur vous, vous avez fait quelque chose de mal...', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                    Citizen.Wait(4000)
                    doing_traitement = false
                else
                    if(exports["vdk_inventory"]:getQuantity(item_gived) < max_quantity_gived) then
                        DisplayMuteText('Ressource en cours de traitement...')
                        Citizen.Wait(2000)
                        DisplayMuteText('Ressource traitée !')
                        TriggerEvent('player:receiveItem', item_gived, 1)
                        TriggerEvent('player:looseItem', item_used, 1)
                        Citizen.Wait(2000)
                        doing_traitement = false
                    else
                        DisplayHelpText('Vous ne pouvez pas traiter plus ! (quantité de ressource maximale autorisée)', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                        Citizen.Wait(4000)
                        doing_traitement = false
                    end
                end
            else
                DisplayHelpText('Vous n\'avez plus assez de ressource pour traiter ici !', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                Citizen.Wait(4000)
                doing_traitement = false
            end
        else
            DisplayHelpText('Inventaire plein', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
            Citizen.Wait(4000)
            doing_traitement = false
        end
    end)
end

function GetRecolte(item_id, max_quantity)
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        if(exports["vdk_inventory"]:notFull() == true) then
            if(exports["vdk_inventory"]:getQuantity(item_id) < max_quantity) then
                DisplayMuteText('Récolte en cours...')
                Citizen.Wait(2000)
                DisplayMuteText('Ressource Récoltée !')
                TriggerEvent('player:receiveItem', item_id, 1)
                Citizen.Wait(2000)
                doing_recolt = false
            else
                DisplayHelpText('Vous ne pouvez pas récolter plus ! (quantité de ressource maximale autorisée)', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                Citizen.Wait(4000)
                doing_recolt = false
            end
        else
            DisplayHelpText('Inventaire plein', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
            Citizen.Wait(4000)
            doing_recolt = false
        end
    end)
end

--]]

RegisterNetEvent('entreprises:ReceiveJobAndLead')
AddEventHandler('entreprises:ReceiveJobAndLead', function(jobID, Leader)
    if(jobID ~= nil and Leader ~= nil) then
        current_jobid = jobID
        --
        if(jobID == 25) then
            SetConcessServices()
        elseif(jobID == 23 and Leader == 1) then
            SetServiceGouvernement()
        elseif(jobID == 16 and Leader == 1) then
            SetServiceMecanicien()
        elseif(jobID == 15 and Leader == 1) then
            SetServiceLses()
        elseif(jobID == 2 and Leader == 1) then
            SetServiceLspd()
        elseif(jobID == 17 and Leader == 1) then
            SetServiceTaxi()
        end
        --
        if(Leader == 1) then
            current_leader = true
        else
            current_leader = false
        end
        --
    end
end)
RegisterNetEvent('entreprises:ReturnPlayerId')
AddEventHandler('entreprises:ReturnPlayerId', function(ID)
    PlayerId=ID
  
end)

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    
    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(1)
        SetTextProportional(1)
        --SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function DisplayMuteText(str)
    local DrawMuteTextCountDown = true
    Citizen.CreateThread(function()
        while DrawMuteTextCountDown do
            Citizen.Wait(2000)
            DrawMuteTextCountDown = false
        end
    end)
    Citizen.CreateThread(function()
        while DrawMuteTextCountDown do
            Citizen.Wait(1)
            SetTextFont(1)
            SetTextProportional(1)
            SetTextScale(0.0, 0.45)
            SetTextDropshadow(1, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)

            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(str)
            DrawText(0.220, 0.855)
        end
    end)
end

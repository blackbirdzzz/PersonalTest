local isInServiceLivreur = false
--##########################################################################################
--##########################################################################################
--##########################################################################################
---
local vehiculeChargeur = nil
local cargaisonChargeur = nil
local cargaisonAttachedToChargeur = false
local vehiculeLivreur = nil
local cargaisonLivreur = nil
local cargaisonAttachedToLivreur = false
local cargaisonLivreurBlip = nil
local vehiculeLivreurDetection = nil
---
local cargaison = {x = -378.84, y = -2672.63, z = 5.09}
local spawn_forklift = {x = -403.43, y = -2681.72, z = 5.00}
local chargement_cargaison = {}

function SpawnCargaisonLivreur()
    DisplayHelpText("Appuyez sur 'Utiliser / E' pour commander la ~g~cargaison~s~", 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
    if IsControlJustPressed(1, 51) then
        local obj = GetHashKey('prop_air_cargo_04c')
        RequestModel(obj)
        while not HasModelLoaded(obj) do
            Wait(1)
        end
        local cargaisonTemp = GetClosestObjectOfType(cargaison.x, cargaison.y, cargaison.z, 3.000, obj, 0, 1, 1)
        if DoesEntityExist(cargaisonTemp) then
            local ObjectId = NetworkGetNetworkIdFromEntity(cargaisonTemp)
            NetworkRequestControlOfNetworkId(ObjectId)
            DeleteObject(cargaisonTemp)
            -- livreur_blips["Contener"].x = livreur_blips["Contener"].x + 5.0
            Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(cargaisonTemp))
            DisplayHelpText("Une ~g~cargaison~s~ est déjà sur place", 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
            Citizen.Wait(2000)
        else
            if DoesEntityExist(cargaisonLivreur) then
                -- local ObjectId = NetworkGetNetworkIdFromEntity(cargaisonLivreur)
                -- NetworkRequestControlOfNetworkId(ObjectId)
                DeleteObject(cargaisonLivreur)
                DisplayHelpText("La ~g~cargaison~s~ est supprimée", 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                Citizen.Wait(2000)
            end
            if DoesEntityExist(cargaisonChargeur) then
                -- local ObjectId = NetworkGetNetworkIdFromEntity(cargaisonChargeur)
                -- NetworkRequestControlOfNetworkId(ObjectId)
                DeleteObject(cargaisonChargeur)

                DisplayHelpText("La ~g~cargaison~s~ est supprimée", 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
                Citizen.Wait(2000)
            end
            cargaisonLivreur = nil
            cargaisonAttachedToLivreur = false
            cargaisonChargeur = nil
            cargaisonAttachedToChargeur = false
            cargaisonLivreur = CreateObjectNoOffset("prop_air_cargo_04c", cargaison.x, cargaison.y, cargaison.z, true, true, true)
            local ObjectId = NetworkGetNetworkIdFromEntity(cargaisonLivreur)
            PlaceObjectOnGroundProperly(cargaisonLivreur)
            SetEntityRotation(cargaisonLivreur, 0.0, 0.0, 45.0, 0, true)
            cargaisonLivreurBlip = AddBlipForEntity(cargaisonLivreur)
            SetBlipSprite(cargaisonLivreurBlip, 351)
            SetBlipAsShortRange(cargaisonLivreurBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cargaison")
            EndTextCommandSetBlipName(cargaisonLivreurBlip)
            SetNetworkIdExistsOnAllMachines(ObjectId, true)
            SetNetworkIdCanMigrate(ObjectId, true)
            SetEntityInvincible(cargaisonLivreur, false)
            SetEntityDynamic(cargaisonLivreur, true)
            DisplayHelpText("La ~g~cargaison~s~ est livrée (la malette sur la carte)", 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
            Citizen.Wait(2000)
            -- SPAWN FORKLIFT
            local ForkDetected = GetClosestVehicle(spawn_forklift.x, spawn_forklift.y, spawn_forklift.z, 6.0, 0, 70)
            if not DoesEntityExist(ForkDetected) then
                local myPed = GetPlayerPed(-1)
                local vehicle = GetHashKey('forklift')
                RequestModel(vehicle)
                while not HasModelLoaded(vehicle) do
                    Wait(1)
                end
                local existingVeh = CreateVehicle(vehicle, spawn_forklift.x, spawn_forklift.y, spawn_forklift.z, 90.0, true, false)
                SetVehicleHasBeenOwnedByPlayer(existingVeh, true)
                local id = NetworkGetNetworkIdFromEntity(existingVeh)
                SetNetworkIdCanMigrate(id, true)
                SetEntityInvincible(existingVeh, false)
                SetVehicleOnGroundProperly(existingVeh)
                SetEntityAsMissionEntity(existingVeh, true, true)
                SetVehicleFuelLevel(existingVeh, 100)
                local plate = GetVehicleNumberPlateText(existingVeh)
            end
            --
            Citizen.CreateThread(function()
                while DoesEntityExist(cargaisonLivreur) do
                    Citizen.Wait(1)
                    attacheCargaison()
                end
            end)
        end
    end
end

function attacheCargaison()
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), cargaison.x, cargaison.y, cargaison.z, true) <= 5) then
        if (IsPedInModel(GetPlayerPed(-1), GetHashKey("forklift"))) then 
            local vehicleToAttach = GetVehiclePedIsIn(GetPlayerPed(-1), true)
            -- local VehiculeId = NetworkGetNetworkIdFromEntity(vehicleToAttach)
            -- NetworkRequestControlOfNetworkId(VehiculeId)
            local obj = GetHashKey('prop_air_cargo_04c')
            RequestModel(obj)
            while not HasModelLoaded(obj) do
                Wait(1)
            end
            local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
            local cargaisonTemp = GetClosestObjectOfType(cargaison.x, cargaison.y, cargaison.z, 3.000, obj, 0, 1, 1)
            if DoesEntityExist(cargaisonTemp) then
                ClearPrints()
                SetTextEntry_2("STRING")
                AddTextComponentString("Appuyez sur 'Utiliser / E' pour charger la ~g~cargaison~s~")
                DrawSubtitleTimed(2000, 1)
                if IsControlJustPressed(1, 51) then
                    -- local ObjectId = NetworkGetNetworkIdFromEntity(cargaisonTemp)
                    -- if NetworkDoesNetworkIdExist(ObjectId) then
                    -- if NetworkHasControlOfNetworkId(ObjectId) then
                    -- NetworkRequestControlOfNetworkId(ObjectId)
                    -- end
                    -- end
                    -- cargaisonChargeur = NetworkGetEntityFromNetworkId(ObjectId)
                    cargaisonChargeur = cargaisonTemp
                    AttachEntityToEntity(cargaisonChargeur, vehicleToAttach, 5, 0.3, 0.8, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 5, true)
                    -- AttachEntityToEntity(cargaisonChargeur, vehicleToAttach, 15, 0.0, 2.0, -1.7, 0.0, 0.0, 0.0, false, false, false, false, 20, true)--handler
                    cargaisonAttachedToChargeur = not cargaisonAttachedToChargeur
                end

                Citizen.CreateThread(function()
                    while DoesEntityExist(cargaisonChargeur) do
                        Citizen.Wait(1)
                        switchVehiculeCargaison()
                    end
                end)
            else
                ClearPrints()
                SetTextEntry_2("STRING")
                AddTextComponentString("Aucune ~g~cargaison~s~ a charger.")
                DrawSubtitleTimed(2000, 1)
            end
        else
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("Vous n'avez pas le bon vehicule.")
            DrawSubtitleTimed(2000, 1)
        end
    end
end

function switchVehiculeCargaison()
    local flatmodel = GetHashKey('flatbed')
    if(GetDistanceBetweenCoords(GetEntityCoords(vehiculeLivreurDetection), GetEntityCoords(cargaisonChargeur), true) <= 2) then
        if (IsPedInModel(GetPlayerPed(-1), GetHashKey("forklift")))then
            if IsEntityAttachedToEntity(cargaisonChargeur, vehiculeLivreurDetection) then
                ClearPrints()
                SetTextEntry_2("STRING")
                AddTextComponentString("Vehicule Chargé.")
                DrawSubtitleTimed(2000, 1)
            else
                ClearPrints()
                SetTextEntry_2("STRING")
                AddTextComponentString("Appuyez sur 'Utiliser / E' pour décharger la ~g~cargaison~s~")
                DrawSubtitleTimed(2000, 1)
                if IsControlJustPressed(1, 51) then
                    DetachEntity(cargaisonChargeur, true, true)
                    AttachEntityToEntity(cargaisonChargeur, vehiculeLivreurDetection, 15, 0.0, -3.7, -1.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                    cargaisonAttachedToChargeur = not cargaisonAttachedToChargeur
                    cargaisonAttachedToLivreur = not cargaisonAttachedToLivreur
                    cargaisonChargeur = nil
                end
            end
        else
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("Aucun vehicule pour décharger.")
            DrawSubtitleTimed(2000, 1)
        end
    end
end

function VenteCargaisonLivreur(_, _, _, _, MinPrice, MaxPrice, _)
    if(cargaisonLivreur ~= nil) and (IsPedInModel(GetPlayerPed(-1), GetHashKey("flatbed"))) then
        SetTextEntry_2("STRING")
        AddTextComponentString("Appuyez sur 'Utiliser / E' pour livrer votre ~g~cargaison~s~.")
        DrawSubtitleTimed(2000, 1)
        if IsControlJustPressed(1, 51) then
            DeleteObject(cargaisonLivreur)
            cargaisonLivreur = nil
            cargaisonAttachedToLivreur = not cargaisonAttachedToLivreur
            local salaire = math.random(MinPrice, MaxPrice)
            --TriggerServerEvent('mission:completed', salaire)
            TriggerServerEvent('entreprises:sellpartage', salaire)
        end
    end
end
--##########################################################################################
--##########################################################################################
--##########################################################################################
function isInServiceLivreurBool()
    return isInServiceLivreur
end

function GetServiceLivreur()
    local playerPed = GetPlayerPed(-1)
    if isInServiceLivreur then
        DisplayHelpText('Fin du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        TriggerServerEvent("skin_customization:SpawnPlayer")
        isInServiceLivreur = not isInServiceLivreur
    else
        DisplayHelpText('Début du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        --
        GetSkinLivreur()
        --
        isInServiceLivreur = true
    end
end

function GetSkinLivreur()
    local hashSkin = GetHashKey("mp_m_freemode_01")
    Citizen.CreateThread(function()
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 11, 41, 1, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2) -- under coat 73 ?
            SetPedComponentVariation(GetPlayerPed(-1), 4, 9, 6, 2) -- Pantalon
            SetPedComponentVariation(GetPlayerPed(-1), 6, 12, 6, 2) -- chaussures
            --SetPedComponentVariation(GetPlayerPed(-1), 3, 67, 0, 2)   -- mains/gants/bras etc. ... (shirt)
            SetPedComponentVariation(GetPlayerPed(-1), 3, 64, 0, 2)
        else
            SetPedComponentVariation(GetPlayerPed(-1), 11, 86, 0, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 0, 2) -- under coat 73 ?
            SetPedComponentVariation(GetPlayerPed(-1), 4, 25, 1, 2) -- Pantalon
            SetPedComponentVariation(GetPlayerPed(-1), 6, 10, 3, 2) -- chaussures
            SetPedComponentVariation(GetPlayerPed(-1), 3, 114, 0, 2) -- mains/gants/bras etc. ... (shirt)
        end
    end)
end

function GetVehicleLivreur(x, y, z, vehicules,PlayerId)
    ClearMenu()
    options.menu_title = "Livreurs"
    options.menu_subtitle = "Vehicules"
    Menu.selection = 1
    for k, v in pairs(vehicules) do
        if(v.vehid ~= 2) then
            Menu.addButton(v.nom, "LivreurSpawnCar", {model = v.model, coordx = x, coordy = y, coordz = z,id=PlayerId})
        end
    end
end

function LivreurSpawnCar(result)
    local vehiculeDetected = GetClosestVehicle(result.coordx, result.coordy, result.coordz, 6.0, 0, 70)
    if not DoesEntityExist(vehiculeDetected) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local myPed = GetPlayerPed(-1)
        local vehicle = GetHashKey(result.model)
		local id=result.id
		local plateNb = math.random(10000000, 90000000)
		local Prefix= "LIVR"
		if id < 10 then 
			plateNb = (Prefix.." 00"..id)
		elseif id < 100 then 
			plateNb = (Prefix.." 0"..id)
		elseif id < 1000 then 
			plateNb = (Prefix.." "..id)
		elseif id < 10000  then
			plateNb = (Prefix..id)
		end
        RequestModel(vehicle)
        while not HasModelLoaded(vehicle) do
            Wait(1)
        end
        local existingVeh = CreateVehicle(vehicle, result.coordx, result.coordy, result.coordz, 90.0, true, false)
		SetVehicleNumberPlateText(existingVeh,plateNb)
        SetVehicleHasBeenOwnedByPlayer(existingVeh, true)
        local id = NetworkGetNetworkIdFromEntity(existingVeh)
        SetNetworkIdCanMigrate(id, true)
        SetEntityInvincible(existingVeh, false)
        SetVehicleOnGroundProperly(existingVeh)
        SetEntityAsMissionEntity(existingVeh, true, true)
        SetVehicleFuelLevel(existingVeh, 100)
        local plate = GetVehicleNumberPlateText(existingVeh)
        SetPedIntoVehicle(myPed, existingVeh, -1)
        TriggerServerEvent('ls:recevoircles', string.lower(plate), existingVeh)
        vehiculeLivreurDetection = existingVeh
        Menu.hidden = true
    else
        DisplayHelpText('Zone Encombrée', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        Menu.hidden = true
        Citizen.Wait(2000)
        SetEntityAsMissionEntity(vehiculeDetected, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
    end
end

















































































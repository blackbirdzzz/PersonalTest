local Job_Name = "Loca'Luxe"
local Job_ID = 25
local autorise = false
local spawn_vehicle_int = false
local spawn_vehicle_ext = false
local firstspawn = 0
local LouerVeh = nil
local NewVeh = nil
local NewVeh2 = nil
local ServiceConcessionnaire = false

local options = {
    x = 0.1, 
    y = 0.2, 
    width = 0.2, 
    height = 0.04, 
    scale = 0.4, 
    font = 0, 
    menu_title = "Loca'Luxe", 
    color_r = 30, 
    color_g = 144, 
    color_b = 255, 
}

function isInServiceConcessionnaireBool()
    return ServiceConcessionnaire
end

function SetConcessServices()
    ServiceConcessionnaire = true
end
--[[
{ ['x'] = 265.52453613281, ['y'] = -1149.4920654297, ['z'] = 28.610769271851 },
{ ['x'] = 262.36285400391, ['y'] = -1150.0189208984, ['z'] = 28.61079788208 },
{ ['x'] = 259.17306518555, ['y'] = -1149.8557128906, ['z'] = 28.610738754272 },
{ ['x'] = 256.11770629883, ['y'] = -1149.5499267578, ['z'] = 28.609014511108 },
{ ['x'] = 253.23390197754, ['y'] = -1150.0388183594, ['z'] = 28.59910774231 },
{ ['x'] = 250.16149902344, ['y'] = -1149.8028564453, ['z'] = 28.595199584961 },
{ ['x'] = 247.77964782715, ['y'] = -1149.5981445313, ['z'] = 28.574810028076 },
{ ['x'] = 244.48553466797, ['y'] = -1149.6822509766, ['z'] = 28.525943756104 },

{ ['x'] = 265.31509399414, ['y'] = -1162.2912597656, ['z'] = 28.761085510254 },
{ ['x'] = 262.39401245117, ['y'] = -1161.9461669922, ['z'] = 28.748834609985 },
{ ['x'] = 259.41180419922, ['y'] = -1161.998046875, ['z'] = 28.748151779175 },
{ ['x'] = 256.23992919922, ['y'] = -1162.0283203125, ['z'] = 28.735708236694 },
{ ['x'] = 253.14878845215, ['y'] = -1161.6984863281, ['z'] = 28.714601516724 },
{ ['x'] = 250.00202941895, ['y'] = -1162.2701416016, ['z'] = 28.70671081543 },
{ ['x'] = 246.82179260254, ['y'] = -1161.8815917969, ['z'] = 28.717723846436 },

]]--

local emplacements_exterieurs = {
    {nom = 'Véhicule 2', x = -47.766593933105, y = -1116.3952636719, z = 25.817056655884, carmodel = 'entityxf'}, 
    {nom = 'Véhicule 3', x = -56.570507049561, y = -1116.8994140625, z = 25.817056655884, carmodel = 'fmj'}, 
}
--{nom='Véhicule 1',x=265.52453613281, y=-1149.4920654297, z=28.610769271851, carmodel='zentorno'},
--{nom='Véhicule 2',x=262.52453613281, y=-1149.4920654297, z=28.610769271851, carmodel='entityxf'},
--{nom='Véhicule 3',x=259.52453613281, y=-1149.4920654297, z=28.610769271851, carmodel='tyrus'},
--{nom='Véhicule 4',x=256.52453613281, y=-1149.4920654297, z=28.610769271851, carmodel='vacca'},
--{nom='Véhicule 5',x=253.52453613281, y=-1149.4920654297, z=28.610769271851, carmodel='voltic'},
--{nom='Véhicule 6',x=250.52453613281, y=-1149.4920654297, z=28.610769271851, carmodel='gp1'},
--{nom='Véhicule 7',x=247.52453613281, y=-1149.4920654297, z=28.610769271851, carmodel='italigtb'},
--{nom='Véhicule 8',x=244.02453613281, y=-1149.4920654297, z=28.610769271851, carmodel='fmj'},
--{nom='Véhicule 9',x=265.31509399414, y=-1162.2912597656, z=28.610769271851, carmodel='coquette2'}, -- Seconde partie
--{nom='Véhicule 10',x=262.31509399414, y=-1162.2912597656, z=28.610769271851, carmodel='feltzer3'},
--{nom='Véhicule 11',x=259.31509399414, y=-1162.2912597656, z=28.610769271851, carmodel='infernus2'},
--{nom='Véhicule 12',x=256.31509399414, y=-1162.2912597656, z=28.610769271851, carmodel='manana'},
--{nom='Véhicule 13',x=253.14878845215, y=-1162.2912597656, z=28.610769271851, carmodel='btype3'},
--{nom='Véhicule 14',x=250.00202941895, y=-1162.2912597656, z=28.610769271851, carmodel='ztype'},
--{nom='Véhicule 15',x=246.82179260254, y=-1162.2912597656, z=28.610769271851, carmodel='monroe'},

--[[
{ ['x'] = -39.266609191895, ['y'] = -1096.0317382813, ['z'] = 25.805316925049 },
{ ['x'] = -56.031757354736, ['y'] = -1093.9692382813, ['z'] = 25.805271148682 },
{ ['x'] = -54.502326965332, ['y'] = -1092.0174560547, ['z'] = 25.806100845337 },
]]--
local emplacements_interieurs = {
    {nom = 'Véhicule 19', x = -56.031757354736, y = -1096.9692382813, z = 25.805316925049, carmodel = 'esskey'}, 
    {nom = 'Véhicule 10', x = -54.031757354736, y = -1093.9692382813, z = 25.805316925049, carmodel = 'wolfsbane'}, 
    {nom = 'Véhicule 31', x = -39.266609191895, y = -1096.0317382813, z = 25.805316925049, carmodel = 'brawler'}, 
}
--[[
{nom='Véhicule 1',x=221.4833984375, y=-1005.5525512695, z=-99.497222900391, carmodel='AKUMA'},
{nom='Véhicule 2',x=221.4833984375, y=-1003.5525512695, z=-99.497222900391, carmodel='bagger'},
{nom='Véhicule 3',x=221.4833984375, y=-1001.5525512695, z=-99.497222900391, carmodel='bati'},
{nom='Véhicule 4',x=221.4833984375, y=-999.5525512695, z=-99.497222900391, carmodel='BF400'},
{nom='Véhicule 5',x=221.4833984375, y=-997.5525512695, z=-99.497222900391, carmodel='carbonrs'},
{nom='Véhicule 6',x=221.4833984375, y=-995.5525512695, z=-99.497222900391, carmodel='cliffhanger'},
{nom='Véhicule 7',x=221.4833984375, y=-993.5525512695, z=-99.497222900391, carmodel='daemon'},
{nom='Véhicule 8',x=221.4833984375, y=-991.5525512695, z=-99.497222900391, carmodel='daemon2'},
{nom='Véhicule 9',x=221.4833984375, y=-987.5525512695, z=-99.497222900391, carmodel='vindicator'},
{nom='Véhicule 10',x=221.4833984375, y=-989.5525512695, z=-99.497222900391, carmodel='wolfsbane'},
{nom='Véhicule 11',x=221.4833984375, y=-985.5525512695, z=-99.497222900391, carmodel='double'},
{nom='Véhicule 12',x=221.4833984375, y=-983.5525512695, z=-99.497222900391, carmodel='enduro'},
{nom='Véhicule 13',x=221.4833984375, y=-981.5525512695, z=-99.497222900391, carmodel='gargoyle'},
{nom='Véhicule 14',x=221.4833984375, y=-979.5525512695, z=-99.497222900391, carmodel='hakuchou'},
{nom='Véhicule 15',x=221.4833984375, y=-977.5525512695, z=-99.497222900391, carmodel='hexer'},
{nom='Véhicule 16',x=221.4833984375, y=-975.5525512695, z=-99.497222900391, carmodel='nemesis'},
--{nom='Véhicule 17',x=226.4833984375, y=-1005.5525512695, z=-99.497222900391, carmodel='nightblade'}, -- Seconde rangée
--{nom='Véhicule 18',x=226.4833984375, y=-1003.5525512695, z=-99.497222900391, carmodel='diablous'},
--{nom='Véhicule 19',x=226.4833984375, y=-1001.5525512695, z=-99.497222900391, carmodel='esskey'},
--{nom='Véhicule 20',x=226.4833984375, y=-999.5525512695, z=-99.497222900391, carmodel='manchez'},
--{nom='Véhicule 21',x=226.4833984375, y=-997.5525512695, z=-99.497222900391, carmodel='pcj'},
--{nom='Véhicule 22',x=226.4833984375, y=-995.5525512695, z=-99.497222900391, carmodel='ruffian'},
--{nom='Véhicule 23',x=226.4833984375, y=-993.5525512695, z=-99.497222900391, carmodel='sanchez'},
--{nom='Véhicule 24',x=226.4833984375, y=-991.5525512695, z=-99.497222900391, carmodel='sovereign'},
--{nom='Véhicule 25',x=226.4833984375, y=-987.5525512695, z=-99.497222900391, carmodel='vader'},
--{nom='Véhicule 26',x=226.4833984375, y=-989.5525512695, z=-99.497222900391, carmodel='zombiea'},
--{nom='Véhicule 27',x=226.4833984375, y=-985.5525512695, z=-99.497222900391, carmodel='zombieb'},
{nom='Véhicule 28',x=233.5833984375, y=-1000.5525512695, z=-99.497222900391, carmodel='sandking'}, -- Troisième rangée
{nom='Véhicule 29',x=233.5833984375, y=-996.5525512695, z=-99.497222900391, carmodel='sandking2'},
{nom='Véhicule 30',x=233.2833984375, y=-993.5525512695, z=-99.497222900391, carmodel='dubsta3'},
{nom='Véhicule 31',x=233.5833984375, y=-990.5525512695, z=-99.497222900391, carmodel='brawler'},
{nom='Véhicule 32',x=233.5833984375, y=-986.5525512695, z=-99.497222900391, carmodel='trophytruck'},
{nom='Véhicule 33',x=233.5833984375, y=-982.5525512695, z=-99.497222900391, carmodel='monster'}, ]]--

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

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('concessionnaire:DroitMenu')
AddEventHandler('concessionnaire:DroitMenu', function(result)
    if(result == "0") then
        Menu.hidden = true
    else
        Menu.hidden = false
    end
end)

--AddEventHandler('playerSpawned', function(spawn)
--if firstspawn == 0 then
--ShowLocaLuxeBlip()
--firstspawn = 1
--end
--end)

function AfficherVehiculesExternes()
    for i, veh in pairs(emplacements_exterieurs) do
        local vehiculeDetected = GetClosestVehicle(veh.x, veh.y, veh.z, 3.0, 0, 70)
        if vehiculeDetected then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
        end

        local vehicle = GetHashKey(veh.carmodel)
        RequestModel(vehicle)
        while not HasModelLoaded(vehicle) do
            Wait(1)
        end
        --if(i < 9) then
        if(i < 5) then
            NewVeh = CreateVehicle(vehicle, veh.x, veh.y, veh.z, 160.0, true, false)
        else
            NewVeh = CreateVehicle(vehicle, veh.x, veh.y, veh.z, 35.0, true, false)
        end
        SetVehicleOnGroundProperly(NewVeh)
        --SetVehicleHasBeenOwnedByPlayer(NewVeh,true)
        local id = NetworkGetNetworkIdFromEntity(NewVeh)
        SetNetworkIdCanMigrate(id, true)
        SetEntityInvincible(NewVeh, true)
        --SetEntityAsMissionEntity(NewVeh, true, true)
        SetVehicleNumberPlateText(NewVeh, ""..veh.carmodel)
        SetVehicleDoorsLocked(NewVeh, 4)
        Wait(2000)
        FreezeEntityPosition(NewVeh, true)
        SetEntityCollision(NewVeh, false, false)
        FreezeEntityPosition(NewVeh, true)
        --SetVehicleInteriorlight(NewVeh,true)
        --SetVehicleLights(NewVeh, 2)
    end
    spawn_vehicle_int = true -- Fin du Spawn des véhicules INTERNES
end

function AfficherVehiculesInternes()
    for i, veh in pairs(emplacements_interieurs) do
        local vehiculeDetected = GetClosestVehicle(veh.x, veh.y, veh.z, 1.5, 0, 70)
        if vehiculeDetected then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
        end
        local vehicle = GetHashKey(veh.carmodel)
        RequestModel(vehicle)
        while not HasModelLoaded(vehicle) do
            Wait(1)
        end
        if(i < 28) then
            NewVeh2 = CreateVehicle(vehicle, veh.x, veh.y, veh.z, 250.0, true, false)
        else
            NewVeh2 = CreateVehicle(vehicle, veh.x, veh.y, veh.z, 80.0, true, false)
        end
        SetVehicleOnGroundProperly(NewVeh2)
        --SetVehicleHasBeenOwnedByPlayer(NewVeh2,true)
        local id = NetworkGetNetworkIdFromEntity(NewVeh2)
        SetNetworkIdCanMigrate(id, true)
        SetEntityInvincible(NewVeh2, true)
        --SetEntityAsMissionEntity(NewVeh2, true, true)
        SetVehicleNumberPlateText(NewVeh2, ""..veh.carmodel)
        SetVehicleDoorsLocked(NewVeh2, 4)
        Wait(2000)
        FreezeEntityPosition(NewVeh2, true)
        SetEntityCollision(NewVeh2, false, false)
        FreezeEntityPosition(NewVeh2, true)
        --SetVehicleInteriorlight(NewVeh2,true)
        --SetVehicleLights(NewVeh2, 2)
    end
    spawn_vehicle_ext = true -- Fin du Spawn des véhicules INTERNES
end

function ShowLocaLuxeBlip()
    local blip = AddBlipForCoord(-31.773624420166, -1113.5218505859, 25.422338485718)
    SetBlipSprite(blip, 369)
    SetBlipColour(blip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Concessionnaire')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip, true)
    SetBlipAsMissionCreatorBlip(blip, true)
end

AddEventHandler('playerSpawned', function(spawn)
    if firstspawn == 0 then
        --ShowLocaLuxeBlip()
        firstspawn = 1
    end
end)

function CheckForOpeningConcessMenu()
    TriggerServerEvent("concessionnaire:CheckJob", 25)
    Main(25)
    Menu.renderGUI(options) 
end

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        --DisplayHelpText('Debug Concessionnaire',0,1,0.5,0.8,0.6,255,255,255,255)
        DrawMarker(1, -9.52, -1089.89, 25.67, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 125, 125, 255, 200, 0, 0, 2, 0, 0, 0, 0)
        DrawMarker(1, -31.773624420166, -1113.5218505859, 25.422338485718, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 255, 125, 255, 200, 0, 0, 2, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -31.773624420166, -1113.5218505859, 25.422338485718, true) < 3 then
            if (IsControlJustPressed(1, 51)) then
                TriggerServerEvent("concessionnaire:CheckJob", 25)
                Main(25)
            end
            Menu.renderGUI(options) 
        end
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -9.52, -1089.89, 25.67, true) < 3 then
            if (IsControlJustPressed(1, 51)) then
                SupprimerVeh()
            end
        end
        --local ped = GetPlayerPed(-1)
        --local playerPos = GetEntityCoords(ped, true)
    end
end)]]--

function SupprimerVehiculeConcessionnaire()
    local ped = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(ped)) then 
        local vehicle = GetVehiclePedIsIn(ped, false)

        if (GetPedInVehicleSeat(vehicle, -1) == ped) then 
            SetEntityAsMissionEntity(vehicle, true, true)
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
        end 
    end
end

function LouerModel(model)
    local model = model.model
    DisplayHelpText("Entrer l'~r~ID~w~ du joueur present en bas de sa ~g~carte d'identité")
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        if(tonumber(result) ~= nil and tonumber(result) ~= "") then
            --
            local vehicle = GetHashKey(model)
            RequestModel(vehicle)
            while not HasModelLoaded(vehicle) do
                Wait(1)
            end
            LouerVeh = CreateVehicle(vehicle, -31.3392162323, -1090.6228027344, 26.347665786743, 80.0, true, false)
            --
            SetVehicleOnGroundProperly(LouerVeh)
            SetVehicleHasBeenOwnedByPlayer(LouerVeh, true)
            local plate = "LOCA" .. tostring(math.random(1000, 9999))
            SetVehicleNumberPlateText(LouerVeh, plate)
            local id = NetworkGetNetworkIdFromEntity(LouerVeh)
            SetNetworkIdCanMigrate(id, true)
            SetEntityInvincible(LouerVeh, false)
            SetVehicleFuelLevel(LouerVeh, 100)
            local plate = GetVehicleNumberPlateText(LouerVeh)
            TriggerServerEvent('ls:recevoircles', plate, LouerVeh)
            SetEntityAsMissionEntity(LouerVeh, true, true)
            --
            SetTextEntry_2("STRING")
            AddTextComponentString("Le vehicule ~g~"..model.."~w~ vous attends dehors !")
            DrawSubtitleTimed(5000, 1)
            Wait(5000)
            --
            TriggerServerEvent('concessionnaire:LouerVeh', result, model)
        else
            Main(25)
        end
    end
end

function TransfertVeh()
    DisplayHelpText("Entrer ~r~la plaque du vehicule~w~ que vous souhaitez ~g~transferer !")
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result_plate = GetOnscreenKeyboardResult()
        if(result_plate ~= nil and result_plate ~= "") then
            --
            DisplayHelpText("Entrer l'~r~ID~w~ de l'acheteur present en bas de sa ~g~carte d'identite")
            DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0); 
                Wait(0); 
            end
            if (GetOnscreenKeyboardResult()) then
                --if (assert(type(x) == "number"))then
                local result_acheteur = GetOnscreenKeyboardResult()
                if(result_acheteur ~= nil and result_acheteur ~= "") then
                    TriggerServerEvent('concessionnaire:TransfertVeh', result_plate, result_acheteur)
                else
                    Main(25)
                end
            end
        else
            Main(25)
        end
    end
end

--[[function LouerouMontrerModel(model)
local vehicle = GetHashKey(model)
RequestModel(vehicle)
while not HasModelLoaded(vehicle) do
Wait(1)
end
LouerVeh = CreateVehicle(vehicle,-31.3392162323, -1090.6228027344, 26.347665786743,80.0, true, false)
--
SetVehicleOnGroundProperly(LouerVeh)
SetVehicleHasBeenOwnedByPlayer(LouerVeh,true)
local plate = "LOCA" .. tostring(math.random(10000,99999))
SetVehicleNumberPlateText(LouerVeh, plate)
local id = NetworkGetNetworkIdFromEntity(LouerVeh)
SetNetworkIdCanMigrate(id, true)
SetEntityInvincible(LouerVeh, false)
local plate = GetVehicleNumberPlateText(LouerVeh)
--
SetTextEntry_2("STRING")
    AddTextComponentString("Le vehicule ~g~"..model.."~w~ vous attends dehors !")
    DrawSubtitleTimed(5000, 1)
Wait(5000)
end]]--

function VendreModel(model)
    DisplayHelpText("Entrer l'~r~ID~w~ du joueur present en bas de sa ~g~carte d'identité")
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
        
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        if(tonumber(result) ~= nil and tonumber(result) ~= "") then
            getIDandSell(model.model, model.price, result)
        else
            Main(25)
        end
    end
end

function getIDandSell(model, prix, idcible)
    
    DisplayHelpText("Entrer le ~r~prix de vente ~w~ du vehicule (mini ~g~"..prix.."~w~$")
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        if(tonumber(result) ~= nil and tonumber(result) ~= "") then
            if(tonumber(result) > prix) then
                local plate = tostring(math.random(10000000, 99999999))
               TriggerServerEvent('concessionnaire:VendreVeh', idcible, model, result, plate, prix)
				
            else
                Main(25)
            end
        else
            Main(25)
        end
    end
end

RegisterNetEvent('concessionnaire:spawnSoldCar')
AddEventHandler('concessionnaire:spawnSoldCar', function(model, plate)
    local vehicle = GetHashKey(model)
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
    LouerVeh = CreateVehicle(vehicle, -31.3392162323, -1090.6228027344, 26.347665786743, 80.0, true, false)
    --
    SetVehicleOnGroundProperly(LouerVeh)
    SetVehicleHasBeenOwnedByPlayer(LouerVeh, true)
    local id = NetworkGetNetworkIdFromEntity(LouerVeh)
    SetNetworkIdCanMigrate(id, true)
    SetEntityInvincible(LouerVeh, false)
    SetVehicleFuelLevel(LouerVeh, 100)
    SetVehicleNumberPlateText(LouerVeh, plate)
    SetEntityAsMissionEntity(LouerVeh, true, true)
end)

--[[function VendreModel2(model,prix,idcible)
DisplayHelpText("Entrer le ~r~prix de vente ~w~ du vehicule (minimum ~r~"..prix.."~g~$")
DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);  
    end
    if (GetOnscreenKeyboardResult()) then
    --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
if(tonumber(result) ~= nil and tonumber(result) ~= "" and tonumber(result) > prix) then
local vehicle = GetHashKey(model)
RequestModel(vehicle)
while not HasModelLoaded(vehicle) do
Wait(1)
end
LouerVeh = CreateVehicle(vehicle,-31.3392162323, -1090.6228027344, 26.347665786743,80.0, true, false)
--
SetVehicleOnGroundProperly(LouerVeh)
SetVehicleHasBeenOwnedByPlayer(LouerVeh,true)
local id = NetworkGetNetworkIdFromEntity(LouerVeh)
SetNetworkIdCanMigrate(id, true)
SetEntityInvincible(LouerVeh, false)
SetVehicleFuelLevel(LouerVeh,100)
local plate = tostring(math.random(00000000,99999999))
SetVehicleNumberPlateText(LouerVeh, plate)
SetEntityAsMissionEntity(LouerVeh, true, true)
--
TriggerServerEvent('concessionnaire:VendreVeh',idcible,model,result,plate,prix)
else
Main(25)
end
    end
end]]--





--[[Register]]--

RegisterNetEvent("garages:getVehicles")
RegisterNetEvent('garages:SpawnVehicle')
RegisterNetEvent('garages:StoreVehicle')
RegisterNetEvent('garages:SelVehicle')


local options = {
    x = 0.17,
    y = 0.15,
    width = 0.27,
    height = 0.035,
    scale = 0.2,
    font = 0,
    menu_title = "Mon Garage",
    menu_subtitle = "Véhicules",
    color_r = 50,
    color_g = 0,
    color_b = 10
}
--[[Local/Global]]--
local mods ={}
local neoncolor = {}
local neon = 0
local xenon =0
local colors = {}
local colorsExtra = {}
local colorsmoke = {}
local windowtint = 0
local wheeltype = 0
local smoke = 0
local pneu = 0
local  pneum = 0
local plac = 0
local turbo = 0
VEHICLES = {}
local currentPos
local garage_voiture = {215.124, -791.377, 29.736}
local garage_voiture2 = {-956.40515136719, -2704.7595214844, 12.831034660339}
local garage_voiture3 = {145.36895751953, 6604.7758789063, 30.851282119751}
local garage_voiture4 = {1701.49, 4803.16, 40.8}
local garage_heliboat = {-724.85003662109,-1443.9534912109,4.0005254745483}
local garage_heliboat2 = {-801.96124267578,-1513.6092529297,0.5952142477036}
local garage_heliboat3 = {-733.68,5813.26,16.42} -- helico
local garage_heliboat5 = {1745.947265625,3251.03198242188,40.5154838562012} -- helico
local garage_heliboat4 = {-850.28,5864.83,0.0} -- bateau
local vente_location = {-45.228, -1083.123, 25.816}
local inrangeofgarage = false
local currentlocation = nil
local garage = {title = "garage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Functions]]--

function MenuGarage()
    ped = GetPlayerPed(-1)
    MenuTitle = "Garage"
    ClearMenu()
    Menu.selection = 1
    Menu.addButton("Rentrer le véhicule","RentrerVehicule2",nil)
    Menu.addButton("Sortir un véhicule","ListeVehicule",nil)
    Menu.addButton("Fermer","CloseMenu",nil)
end




function RentrerVehicule2()
    ped = GetPlayerPed(-1)
    MenuTitle = "Mes vehicules"
    ClearMenu()
    for ind, value in pairs(VEHICLES) do
    	if tostring(value.vehicle_state) == "Sorti" then
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "RentrerVehicule", value.id)
    	end
    end
    Menu.addButton("Retour","MenuGarage",nil)
end

function RentrerVehicule(vehID)
    ped = GetPlayerPed(-1)
    local vehID = vehID
	if vehID ~= nil then
        TriggerServerEvent('garages:CheckForVeh', vehID)
	end
    CloseMenu()
end

function ListeVehicule()
    ped = GetPlayerPed(-1)
    MenuTitle = "Mes vehicules"
    ClearMenu()
    for ind, value in pairs(VEHICLES) do
		if tostring(value.vehicle_state) == "Rentré" then
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehicle", value.id)
		end
    end
    Menu.addButton("Retour","MenuGarage",nil)
end

function OptionVehicle(vehID)
    local vehID = vehID
    MenuTitle = "Options"
    ClearMenu()
    Menu.addButton("Sortir", "SortirVehicule", vehID)
    Menu.addButton("Retour", "ListeVehicule", nil)
end

function SortirVehicule(vehID)
    local vehID = vehID
    TriggerServerEvent('garages:CheckForSpawnVeh', vehID)
    CloseMenu()
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true
end

function LocalPed()
    return GetPlayerPed(-1)
end

function IsPlayerInRangeOfGarage()
    return inrangeofgarage
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function showHelpNotification(str)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

--[[Citizen]]--
Citizen.CreateThread(function()
    local loc = garage_voiture4
    pos = garage_voiture4
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,357)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_voiture4[1],garage_voiture4[2],garage_voiture4[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_voiture4[1],garage_voiture4[2],garage_voiture4[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_voiture4[1],garage_voiture4[2],garage_voiture4[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForVeh")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_voiture4
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_voiture
    pos = garage_voiture
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,357)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_voiture[1],garage_voiture[2],garage_voiture[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_voiture[1],garage_voiture[2],garage_voiture[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_voiture[1],garage_voiture[2],garage_voiture[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForVeh")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_voiture
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_voiture3
    pos = garage_voiture3
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,357)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_voiture3[1],garage_voiture3[2],garage_voiture3[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_voiture3[1],garage_voiture3[2],garage_voiture3[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_voiture3[1],garage_voiture3[2],garage_voiture3[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForVeh")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_voiture3
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_voiture2
    pos = garage_voiture2
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,357)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_voiture2[1],garage_voiture2[2],garage_voiture2[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_voiture2[1],garage_voiture2[2],garage_voiture2[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_voiture2[1],garage_voiture2[2],garage_voiture2[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForVeh")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_voiture2
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_heliboat
    pos = garage_heliboat
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,360)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_heliboat[1],garage_heliboat[2],garage_heliboat[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_heliboat[1],garage_heliboat[2],garage_heliboat[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_heliboat[1],garage_heliboat[2],garage_heliboat[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForHeliBoat")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_heliboat
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_heliboat2
    pos = garage_heliboat2
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,356)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_heliboat2[1],garage_heliboat2[2],garage_heliboat2[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_heliboat2[1],garage_heliboat2[2],garage_heliboat2[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_heliboat2[1],garage_heliboat2[2],garage_heliboat2[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForHeliBoat")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_heliboat2
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_heliboat3
    pos = garage_heliboat3
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,360)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_heliboat3[1],garage_heliboat3[2],garage_heliboat3[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_heliboat3[1],garage_heliboat3[2],garage_heliboat3[3],0,0,0,0,0,0,6.001,6.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_heliboat3[1],garage_heliboat3[2],garage_heliboat3[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForHeliBoat")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_heliboat3
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_heliboat5
    pos = garage_heliboat5
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,360)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_heliboat5[1],garage_heliboat5[2],garage_heliboat5[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_heliboat5[1],garage_heliboat5[2],garage_heliboat5[3],0,0,0,0,0,0,6.001,6.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_heliboat5[1],garage_heliboat5[2],garage_heliboat5[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForHeliBoat")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_heliboat5
				end
				Menu.renderGUI(options)
			end
		end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_heliboat4
    pos = garage_heliboat4
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,356)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(garage_heliboat4[1],garage_heliboat4[2],garage_heliboat4[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,garage_heliboat4[1],garage_heliboat4[2],garage_heliboat4[3],0,0,0,0,0,0,6.001,6.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(garage_heliboat4[1],garage_heliboat4[2],garage_heliboat4[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("garages:CheckGarageForHeliBoat")
					MenuGarage()
					Menu.hidden = not Menu.hidden
					currentPos = garage_heliboat4
				end
				Menu.renderGUI(options)
			end
		end
    end
end)


Citizen.CreateThread(function()
    local loc = vente_location
    pos = vente_location
    -- local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    -- SetBlipSprite(blip,207)
    -- SetBlipColour(blip, 3)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Revente')
    -- EndTextCommandSetBlipName(blip)
    -- SetBlipAsShortRange(blip,true)
    -- SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(1)
		if GetDistanceBetweenCoords(vente_location[1],vente_location[2],vente_location[3],GetEntityCoords(LocalPed())) < 50 then
			DrawMarker(1,vente_location[1],vente_location[2],vente_location[3],0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
			if GetDistanceBetweenCoords(vente_location[1],vente_location[2],vente_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
				showHelpNotification('~INPUT_CONTEXT~ pour vendre le véhicule à 50% du prix d\'achat')
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent('garages:CheckForSelVeh',source)
				end
			end
		end
    end
end)



--[[Events]]--

AddEventHandler("garages:getVehicles", function(THEVEHICLES)
    VEHICLES = {}
    VEHICLES = THEVEHICLES
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("garages:CheckGarageForVeh")
    TriggerServerEvent("garages:storeallvehicles2")
end)

AddEventHandler('garages:SpawnVehicle', function(vehicle, veh_id, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, mods, neoncolor, neon, xenon, colorsmoke, windowtint, wheeltype, smoke, pneu, pneum, plac, turbo, health)
    local car = GetHashKey(vehicle)
    local plate = plate
    local state = state
    local primarycolor = tonumber(primarycolor)
    local secondarycolor = tonumber(secondarycolor)
    local pearlescentcolor = tonumber(pearlescentcolor)
    local wheelcolor = tonumber(wheelcolor)
	local mods = json.decode(mods)
	local neoncolor = json.decode(neoncolor)
	local neon = tonumber(neon)
	local xenon = tonumber(xenon)
	local colorsmoke = json.decode(colorsmoke)
	local windowtint = tonumber(windowtint)
	local wheeltype = tonumber(wheeltype)
	local smoke = tonumber(smoke)
	local pneu = tonumber(pneu)
	local pneum = tonumber(pneum)
	local plac =tonumber(plac)
	local turbo = tonumber(turbo)
	local health = tonumber(health)
	RequestModel(car)
    while not HasModelLoaded(car) do
		Wait(1)
	end
    local caisseo = GetClosestVehicle(currentPos[1], currentPos[2], currentPos[3], 3.000, 0, 70)
    if DoesEntityExist(caisseo) then
        drawNotification("La zone est encombrée")
    else
        if state == "Sorti" then
            drawNotification("Ce véhicule n'est pas dans le garage")
        else
            local veh = CreateVehicle(car, currentPos[1], currentPos[2], currentPos[3], 0.0, true, false)
           SetVehicleModKit(veh,0)
           number = (GetVehicleModKit(veh) - 1 )

           if number <= 24 then
               number = 24
           end
           SetVehicleWheelType(veh, wheeltype)
           for i = 0 , number  do
               if mods[""..i] ~= nil then
                   SetVehicleModKit(veh,0)
                   SetVehicleMod(veh,i,mods[""..i])
--                    print(mods[""..i] .." non null ".. i)
               else
                   SetVehicleModKit(veh,0)
                   SetVehicleMod(veh,i,-1)
--				    print("-1 i ".. i)
               end
           end
           SetVehicleWindowTint(veh, windowtint)
			SetVehicleColours(veh, primarycolor, secondarycolor)
            SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
            if neon == 1 then
                SetVehicleNeonLightsColour(veh,neoncolor[1],neoncolor[2],neoncolor[3])
                SetVehicleNeonLightEnabled(veh,0,true)
                SetVehicleNeonLightEnabled(veh,1,true)
                SetVehicleNeonLightEnabled(veh,2,true)
                SetVehicleNeonLightEnabled(veh,3,true)
            end
			if xenon == 1 then
				ToggleVehicleMod(veh,22,true)
			else
				ToggleVehicleMod(veh,22,false)
			end
			if pneu == 1 then
				SetVehicleMod(veh,23,mods["23"],true)
			else
				SetVehicleMod(veh,23,mods["23"],false)
			end
			if pneum == 1 then
				SetVehicleMod(veh,24,mods["24"],true)
			else
				SetVehicleMod(veh,24,mods["24"],false)
			end
			if smoke == 1 then
				ToggleVehicleMod(veh,20,true)
				SetVehicleTyreSmokeColor(veh,colorsmoke[1],colorsmoke[2],colorsmoke[3])
			else
				ToggleVehicleMod(veh,20,false)
				SetVehicleTyreSmokeColor(veh,0,0,0)
			end
			if turbo == 1 then
				ToggleVehicleMod(veh,18,true)
			else
				ToggleVehicleMod(veh,18,false)
			end
			SetVehicleNumberPlateTextIndex(veh, plac)
            SetVehicleNumberPlateText(veh, plate)
            SetVehicleOnGroundProperly(veh)
            SetVehicleHasBeenOwnedByPlayer(veh,true)
            local id = NetworkGetNetworkIdFromEntity(veh)
            SetNetworkIdCanMigrate(id, true)
            SetEntityInvincible(veh, false)
			local myPed = GetPlayerPed(-1)
			SetPedIntoVehicle(myPed, veh, - 1)
			SetVehicleEngineHealth(veh, health + 0.001)
            drawNotification("Véhicule sorti")
            TriggerServerEvent('garages:SetVehOut', veh_id, plate, car)
            TriggerServerEvent('ls:recevoircles', plate, veh)
            mods ={}
            neoncolor = {}
            turbo = 0
            health = 0
            neon = 0
            xenon = 0
            colors = {}
            colorsExtra = {}
            colorsmoke = {}
            windowtint = nil
            wheeltype = nil
            smoke = 0
            pneu = 0
            pneum = 0
            SetEntityAsMissionEntity(veh, true, true)
            TriggerServerEvent("garages:CheckGarageForVeh")
        end
    end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

AddEventHandler('garages:StoreVehicle', function(vehid, vehicle, plate, modeltype)
    local vehid = vehid
    local separate = " _-,"
    local plate = plate
    local platecaissei = nil
	if(modeltype == 2) then
		local rayHandle = CastRayPointToPoint(currentPos[1] - 10.000, currentPos[2] - 10.000,currentPos[3] - 10.000, currentPos[1] + 20.000, currentPos[2] + 20.000, currentPos[3] + 20.000, 10, GetPlayerPed(-1), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
		if DoesEntityExist(vehicleHandle) then
			SetVehicleUndriveable(vehicleHandle, true)
			SetEntityAsMissionEntity(vehicleHandle, true, true)
			platecaissei = GetVehicleNumberPlateText(vehicleHandle)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicleHandle))
			TriggerServerEvent('garages:SetVehIn', vehid, plate, 0, 0, 0, 0)
		end
	end

	local caisseo = nil

	caisseo = GetClosestVehicle(currentPos[1], currentPos[2], currentPos[3], 3.000, 0, 70)

    if not DoesEntityExist(caisseo) and not DoesEntityExist(vehicleHandle) then
   		local rayHandle = CastRayPointToPoint(currentPos[1] - 5.000, currentPos[2] - 5.000, currentPos[3] - 5.000, currentPos[1] + 10.000, currentPos[2] + 10.000, currentPos[3] + 10.000, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
		caisseo = vehicle
		SetEntityAsMissionEntity(caisseo, true, true)
		platecaissei = GetVehicleNumberPlateText(caisseo)
	else
		SetEntityAsMissionEntity(caisseo, true, true)
		platecaissei = GetVehicleNumberPlateText(caisseo)
    end


    if caisseo ~= nil or vehicleHandle ~= nil then
    	Citizen.Wait(500)
        if plate ~= platecaissei then
            drawNotification("Ce n'est pas ton véhicule")
        else
			number = (GetVehicleModKit(caisseo) - 1 )
            mods = {}
			if number <= 24 then
                number = 24
			end
			for i = 0, number do
				SetVehicleModKit(caisseo,0)
				if GetVehicleMod(caisseo,i) ~= -1 then
                    mods[i] = GetVehicleMod(caisseo,i)
				end
            end

			for e = 0,3 do
    			if IsVehicleNeonLightEnabled(caisseo,e) then
                    neon = 1
                    neoncolor = table.pack(GetVehicleNeonLightsColour(caisseo))
                else
                    neon = 0
                end
			end
			if GetVehicleModVariation(caisseo,23) then
                pneu = 1
			else
                pneu = 0
			end
			if GetVehicleModVariation(caisseo,24) then
                pneum = 1
			else
                pneum = 0
			end
			if IsToggleModOn(caisseo,22) then
                xenon = 1
			else
                xenon = 0
			end

			if IsToggleModOn(caisseo,20) then
                smoke = 1
			else
                smoke = 0
			end
			if IsToggleModOn(caisseo,18) then
                turbo = 1
			else
                turbo = 0
			end
			health = GetVehicleEngineHealth(caisseo)
			colors = table.pack(GetVehicleColours(caisseo))
			colorsExtra = table.pack(GetVehicleExtraColours(caisseo))
			colorsmoke = table.pack(GetVehicleTyreSmokeColor(caisseo))
			primarycolor = colors[1]
			secondarycolor = colors[2]
			pearlescentcolor = colorsExtra[1]
			wheelcolor = colorsExtra[2]
			windowtint = GetVehicleWindowTint(caisseo)
			wheeltype = GetVehicleWheelType(caisseo)
			plac = GetVehicleNumberPlateTextIndex(caisseo)
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caisseo))
            drawNotification("Véhicule rentré")
            TriggerServerEvent('ls:retirercles', plate)
			TriggerServerEvent('garages:putinfo', vehid, mods, neoncolor, neon, xenon, colorsmoke, windowtint, wheeltype, smoke, pneu, pneum, plac, turbo, health)
            TriggerServerEvent('garages:SetVehIn', vehid, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
            mods ={}
			turbo = 0
            neoncolor = {}
            neon = 0
            xenon =0
            colors = {}
            colorsExtra = {}
            colorsmoke = {}
            windowtint = 0
            wheeltype = 0
            smoke = 0
            pneu = 0
            pneum = 0
            plac = 0
			TriggerServerEvent("garages:CheckGarageForVeh")
        end
    else
        drawNotification("Aucun véhicule présent")
    end
end)

AddEventHandler('garages:SelVehicle', function(result)
	local caissei = GetClosestVehicle(-45.228, -1083.123, 25.816, 3.000, 0, 70)
	if DoesEntityExist(caissei) then
		  local platecaissei = GetVehicleNumberPlateText(caissei)
		  for k,v in pairs(result) do
		  	if (v.vehicle_plate == platecaissei) then
		  		SetEntityAsMissionEntity(caissei, true, true)
		  		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
           		TriggerServerEvent('garages:SelVeh', v.ID, v.vehicle_plate, v.vehicle_model)
           		TriggerServerEvent("garages:CheckGarageForVeh")
		  	end
		  end
	else
        drawNotification("Aucun véhicule présent")
    end
end)

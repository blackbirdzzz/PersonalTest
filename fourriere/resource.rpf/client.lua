AddEventHandler('playerSpawned', function(spawn)
  FourrieresBlips()
end)

local options = {
    x = 0.11,
    y = 0.2,
    width = 0.22,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Fourrière",
    menu_subtitle = "Gestion",
    color_r = 30,
    color_g = 144,
    color_b = 255,
}
local fourrieres = {
  {nom='Fourrière', x=401.34, y=-1631.62, z=28.20, jobid=16},
}

function FourrieresBlips()
for i,pos in pairs(fourrieres) do
      local blip = AddBlipForCoord(fourrieres[i].x,fourrieres[i].y,fourrieres[i].z)
      SetBlipSprite(blip,67)
      SetBlipColour(blip, 3)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('Fourrière')
      EndTextCommandSetBlipName(blip)
      SetBlipAsShortRange(blip,true)
      SetBlipAsMissionCreatorBlip(blip,true)
  end
end

RegisterNetEvent('fourriere:isMecaOrNot')
AddEventHandler('fourriere:isMecaOrNot', function(result)
  if result == true then
	Menu.hidden = false
  else
	Menu.hidden = true
  end
end)

function PutInFourriere()
	local ped = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(ped, true)
    local vehiculeDetected = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 5.0, 0, 70)
    if DoesEntityExist(vehiculeDetected) and IsEntityAMissionEntity(vehiculeDetected) then
      	SetEntityAsMissionEntity(vehiculeDetected, true, true)
        local plate_addfour = GetVehicleNumberPlateText(vehiculeDetected)
        SetVehicleUndriveable(vehiculeDetected,true)
        DeleteVehicle(vehiculeDetected)
        TriggerServerEvent('fourriere:updateFouriere', plate_addfour, 1)
        drawNotification("Le véhicule ~g~".. plate_addfour .."~w~ est mis dans la ~r~fourrière ~w~ ! (~g~+~w~250~g~$~w~)")
    else
        local rayHandle = CastRayPointToPoint(fourrieres[1].x - 10.000, fourrieres[1].y - 10.000, fourrieres[1].z - 10.000, fourrieres[1].x + 20.000, fourrieres[1].y + 20.000, fourrieres[1].z + 20.000, 10, GetPlayerPed(-1), 0)
        local _, _, _, _, vehicle = GetRaycastResult(rayHandle)

        if(DoesEntityExist(vehicle) and IsEntityAMissionEntity(vehicle)) then
            SetEntityAsMissionEntity(vehicle, true, true)
            local plate_addfour = GetVehicleNumberPlateText(vehicle)
            SetVehicleUndriveable(vehicle,true)
            DeleteVehicle(vehicle)
            TriggerServerEvent('fourriere:updateFouriere', plate_addfour, 1)
            drawNotification("Le véhicule ~g~".. plate_addfour .."~w~ est mis dans la ~r~fourrière ~w~ ! (~g~+~w~250~g~$~w~)")
        else
            drawNotification("~r~ Aucun véhicule détecté !")
        end
    end
end

function InitOutFourriere()
    TriggerServerEvent('fourriere:getVehInFourriere')
end

function getOutFourriere(vehicle)
    TriggerServerEvent('fourriere:updateFouriere', vehicle.plate, 0)
    drawNotification("Le véhicule ~g~".. vehicle.plate .."~w~ est sorti de la ~r~fourrière ~w~ ! (~r~-~w~250~g~$~w~)")
    TriggerServerEvent('fourriere:CheckForSpawnVeh',vehicle.id)
    Main(fourrx,fourry,fourrz)
end


-- Copié de ES_GARAGES
RegisterNetEvent("fourriere:SpawnVehicle")
AddEventHandler('fourriere:SpawnVehicle', function(vehicle, veh_id, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, mods, neoncolor, neon, xenon, colorsmoke, windowtint, wheeltype, smoke, pneu, pneum, plac, turbo, health)
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
    local caisseo = GetClosestVehicle(fourrieres[1].x, fourrieres[1].y, fourrieres[1].z, 3.000, 0, 70)
    if DoesEntityExist(caisseo) then
        drawNotification("La zone est encombrée")
    else
        if state == "Sorti" then
            drawNotification("Ce véhicule n'est pas dans le garage")
        else
            local veh = CreateVehicle(car, fourrieres[1].x, fourrieres[1].y, fourrieres[1].z, 0.0, true, false)
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
                    --print(mods[""..i] .." non null ".. i)
                else
                    SetVehicleModKit(veh,0)
                    SetVehicleMod(veh,i,-1)
                    --print("-1 i ".. i)
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
            TriggerServerEvent('garages:SetVehOut', veh_id,  plate, car)
            --Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(veh))
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
            print('spawn')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(ped, true)
	    for i,pos in pairs(fourrieres) do
	    	if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), fourrieres[i].x,fourrieres[i].y,fourrieres[i].z,true ) < 15 then
	    		DrawMarker(1, fourrieres[i].x,fourrieres[i].y,fourrieres[i].z, 0, 0, 0, 0, 0, 0, 6.0,6.0,1.5, 255,150,155, 200, 0, 0, 2, 0, 0, 0, 0)
	    	end
	        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), fourrieres[i].x,fourrieres[i].y,fourrieres[i].z,true ) < 5 then
			    DrawText3D(fourrieres[i].x,fourrieres[i].y,fourrieres[i].z+2,fourrieres[i].nom)
          		DisplayHelpText('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu de la fourrière',0,1,0.5,0.8,0.6,255,255,255,255)
                if (IsControlJustPressed(1,51)) then
				            TriggerServerEvent("fourriere:checkIfMeca")
				            Main(fourrieres[i].x,fourrieres[i].y,fourrieres[i].z)
                end
                Menu.renderGUI(options) 
        	end
	    end
    end
end)


function drawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 2.1*scale)
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
        DrawText(_x,_y)
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

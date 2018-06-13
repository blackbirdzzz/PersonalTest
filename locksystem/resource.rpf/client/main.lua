local vehicle, lockStatus
local lockunlock = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(IsControlJustPressed(1, globalConf['CLIENT'].key) or lockunlock)then
			local ped = GetPlayerPed( -1 )
	    	local playerPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 0.0)
    		local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -0.8)
    		local vehicleFront = GetVehicleInDirection(playerPos, inFrontOfPlayer)
			lockunlock = false
			 if (IsPedInAnyVehicle(ped, true)) then
			 	vehicle = GetVehiclePedIsIn(ped, true )
				lockStatus = GetVehicleDoorLockStatus(vehicle)
				local plate = GetVehicleNumberPlateText(vehicle)
				local isPlayerInside = IsPedInAnyVehicle(ped, true)
				if(plate)then
					TriggerServerEvent("ls:mainCheck", plate, vehicle, isPlayerInside)
				end
			 elseif ( DoesEntityExist( vehicleFront ) ) then
			 	vehicle = vehicleFront
				lockStatus = GetVehicleDoorLockStatus(vehicleFront)
				local plate = GetVehicleNumberPlateText(vehicleFront)
				local isPlayerInside = IsPedInAnyVehicle(ped, true)
				if(plate)then
					TriggerServerEvent("ls:mainCheck", plate, vehicleFront, isPlayerInside)
				end
--			 else
--			 	Notify("Aucun véhicule présent")
			 end
		end
	end
end)

function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

RegisterNetEvent('ls:lock')
AddEventHandler('ls:lock', function()
	Citizen.CreateThread(function()
			if(lockStatus == 2)then
				SetVehicleDoorsLocked(vehicle, 0)
				--Notify("~o~" .. GetVehicleNumberPlateText(vehicle) .. "~w~ Status de vérouillage : ".. lockStatus .. " ~g~déverrouilé")
				Notify('Vehicule ~g~déverrouilé')
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.6)
			else
				SetVehicleDoorsLocked(vehicle, 2)
				--Notify("~o~" .. GetVehicleNumberPlateText(vehicle) .. "~w~ Status de vérouillage : ".. lockStatus .. " ~r~verrouillé")
				Notify('Vehicule ~r~verrouillé')
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.6)
			end
	end)
end)

RegisterNetEvent('ls:notify')
AddEventHandler('ls:notify', function(text)
	Notify(text)
end)

-- Piece of code from Scott's InteractSound script : https://forum.fivem.net/t/release-play-custom-sounds-for-interactions/8282
RegisterNetEvent('InteractSound_CL:PlayWithinDistance')
AddEventHandler('InteractSound_CL:PlayWithinDistance', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)

RegisterNetEvent('ls:lockunlock')
AddEventHandler('ls:lockunlock', function()
	lockunlock = true
end)

AddEventHandler('playerSpawned', function()
	TriggerServerEvent("ls:checkallkeys")
end)

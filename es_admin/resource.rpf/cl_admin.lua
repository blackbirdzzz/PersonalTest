local states = {}
states.frozen = false
states.frozenPos = nil

RegisterNetEvent('es_admin:spawnVehicle')
AddEventHandler('es_admin:spawnVehicle', function(v)
	local carid = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(carid)
		while not HasModelLoaded(carid) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
		SetVehicleNumberPlateText(veh, "BIRP")
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()
	local ped = GetPlayerPed(-1)
	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)
	if not state then
			if not IsEntityVisible(ped) then
					SetEntityVisible(ped, true)
			end
			if not IsPedInAnyVehicle(ped) then
					SetEntityCollision(ped, true)
			end
			FreezeEntityPosition(ped, false)
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
	else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)
			if not IsPedFatallyInjured(ped) then
					ClearPedTasksImmediately(ped)
			end
	end
end)
 
RegisterNetEvent('es_admin:viewname')
AddEventHandler('es_admin:viewname', function(t)
        for id = 0, 68 do
            if  NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped )
                -- Create head display (this is safe to be spammed)
                headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, GetPlayerName( id ), false, false, "", false )
                if NetworkIsPlayerTalking( id ) then
                    Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, true ) -- Add speaking sprite
                else
                    Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, false ) -- Remove speaking sprite
                end
            end
        end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(user)
	local pos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(user))))
	RequestCollisionAtCoord(pos.x, pos.y, pos.z)
	while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1))do
		RequestCollisionAtCoord(pos.x, pos.y, pos.z)
		Citizen.Wait(0)
	end
	SetEntityCoords(GetPlayerPed(-1), pos)
	states.frozenPos = pos
end)

RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	ApplyForceToEntity(GetPlayerPed(-1), 0, 0.0, 0.0, 900000.0, 0.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:givePosition')
AddEventHandler('es_admin:givePosition', function()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local string = "{ ['x'] = " .. pos.x .. ", ['y'] = " .. pos.y .. ", ['z'] = " .. pos.z .. " },\n"
	TriggerServerEvent('es_admin:givePos', string)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Position saved to file.')
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(GetPlayerPed(-1), 0)
end)

RegisterNetEvent('es_admin:revive')
AddEventHandler('es_admin:revive', function()
	TriggerServerEvent("ambulancier:setDead",0)
	ResurrectPed(GetPlayerPed(-1))
	SetEntityHealth(GetPlayerPed(-1), GetPedMaxHealth(GetPlayerPed(-1)))
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

local distanceToCheck = 5.0
RegisterNetEvent('es_admin:rmcar')
AddEventHandler('es_admin:rmcar', function()
    local ped = GetPlayerPed(-1)
	
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        local pos = GetEntityCoords(ped)
		
        if (IsPedSittingInAnyVehicle(ped)) then 
            local vehicle = GetVehiclePedIsIn(ped, false)
			
            if (GetPedInVehicleSeat(vehicle, -1) == ped) then 
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
                if (DoesEntityExist(vehicle)) then 
                	ShowNotification("~r~Unable to delete vehicle, try again.")
                else 
                	ShowNotification("Vehicle deleted.")
                end 
            else 
                ShowNotification("You must be in the driver's seat!")
            end 
        else
            local playerPos = GetEntityCoords(ped, 1)
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, distanceToCheck, 0.0)
            local vehicle = GetVehicleInDirection(playerPos, inFrontOfPlayer)

            if (DoesEntityExist(vehicle)) then 
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
                if (DoesEntityExist(vehicle)) then 
                	ShowNotification("~r~Unable to delete vehicle, try again.")
                else 
                	ShowNotification("Vehicle deleted.")
                end 
            else 
                ShowNotification("You must be in or near a vehicle to delete it.")
            end 
        end 
    end 
end)

function deleteCar(entity)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

local drunk = false
RegisterNetEvent('es_admin:drunk')
AddEventHandler('es_admin:drunk', function()
	if (drunk == false) then
		StopAllScreenEffects()
		SetPedIsDrunk(GetPlayerPed(-1), true)
		ShakeGameplayCam("DRUNK_SHAKE", 1.0)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		SetPedConfigFlag(GetPlayerPed(-1), 100, true)
		SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
		StartScreenEffect("DrugsDrivingIn", 0, 0)
		Wait(10000);
		drawNotification("Woooah j'ai mal à la tête ...")
		for i=1,100 do
			SetPedToRagdoll(GetPlayerPed(-1), 6000, 6000, 0, 0, 0, 0)
			Citizen.Wait(15000)
			i = i + 1
		end
	end
	if (drunk) then
		SetPedIsDrunk(GetPlayerPed(-1), false)
		ShakeGameplayCam("", 1.0)
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetPedConfigFlag(GetPlayerPed(-1), 100, false)
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(GetPlayerPed(-1), 0)
		StopAllScreenEffects()
	end
end)

local noclip = false
RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
	local msg = "désactivé"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
	end
	noclip = not noclip
	if(noclip)then
		msg = "activé"
	end
	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Le ghost mode a été ^2"..msg)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), states.frozenPos)
		end
	end
end)

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip)then
			SetEntityCoordsNoOffset(GetPlayerPed(-1),  noclip_pos.x,  noclip_pos.y,  noclip_pos.z,  0, 0, 0)
			if(IsControlPressed(1,  34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
			end
			if(IsControlPressed(1,  32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1,  27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 1.0)
			end
			if(IsControlPressed(1,  173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, -1.0)
			end
		end
	end
end)

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
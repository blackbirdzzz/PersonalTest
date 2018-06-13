function ToggleDoorData(data)
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, false)
	if vehicle ~= 0 then
		local porte = data.Porte
		local doorAngle = GetVehicleDoorAngleRatio(vehicle, porte)
        if (doorAngle == 0) then -- Door is closed
			SetVehicleDoorOpen(vehicle, porte, 0, 0)
        else
			SetVehicleDoorShut(vehicle, porte, 0, 0)
    	end
    else
        showMessageInformation("~r~Il faut être dans le vehicule.")
    end
end

function EngineToggle()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	if IsVehicleEngineOn(vehicle) then
		SetVehicleEngineOn(vehicle, false, false, true)
	else
		SetVehicleEngineOn(vehicle, true, false, true)
	end
end

function repair()
    TriggerEvent('iens:repair')
end

function lockunlock()
    TriggerEvent('ls:lockunlock')
end

function showMessageInformation(message, duree)
    duree = duree or 2000
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

function givekey(data)
    local player, distance = GetClosestPlayer()
--    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        if(distance ~= -1 and distance < 3) then
            local playerid = GetPlayerServerId(player)
            TriggerServerEvent('ls:givekey', playerid, data.Plate)
        else
            showMessageInformation("Pas de joueur proche")
        end
--    else
--        showMessageInformation("Vous ne pouvez pas faire ça dans un vehicule")
--    end
end

function delkey(data)
    TriggerServerEvent("ls:retirercles", data.Plate)
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
--        print(target.." TARGET")
--        print(ply.. " PLY")
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}
    for i = 0, 68 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end
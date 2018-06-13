
local driftmode = false

function drifmodSwitch()
    driftmode = not driftmode

    if driftmode then
        exports["ft_libs"]:Notification("Driftmode Activer")
    else
        exports["ft_libs"]:Notification("Driftmode Désactiver")
    end
end

RegisterNetEvent('dsmoke:Switch')
AddEventHandler('dsmoke:Switch', drifmodSwitch)

function angle(veh)
    if not veh then return false end
    local vx,vy,vz = table.unpack(GetEntityVelocity(veh))
    local modV = math.sqrt(vx*vx + vy*vy)


    local rx,ry,rz = table.unpack(GetEntityRotation(veh,0))
    local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))

    if GetEntitySpeed(veh) * 3.6 < 5 or GetVehicleCurrentGear(veh) == 0 then
        return 0,modV
    end --speed over 30 km/h

    local cosX = (sn*vx + cs*vy)/modV
    if cosX > 0.966 or cosX < 0 then return 0,modV end
    return math.deg(math.acos(cosX))*0.5, modV
end

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(1)

        local playerPed = GetPlayerPed(-1)
        if driftmode and IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsUsing(playerPed)
            local driver = (GetPedInVehicleSeat(vehicle, -1) == ped)
            local ang, speed = angle(vehicle)

            if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                if IsControlPressed(2, 21) and GetLastInputMethod(2) and ang ~= 0 and speed >= 3.0 then
                    SetVehicleReduceGrip(vehicle, true)
                else
                    SetVehicleReduceGrip(vehicle, false)
                end
            end

        end

    end
end)
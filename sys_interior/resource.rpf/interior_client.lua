POS_actual = 1
New_POS = 0
PED_hasBeenTeleported = false
text_x = 0.2575
text_y = 0.975

function teleport(pos)
    local ped = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        PED_hasBeenTeleported = true
        NetworkFadeOutEntity(ped, true, false)
        Citizen.Wait(500)
        
        SetEntityCoords(ped, pos.x, pos.y, pos.z, 1, 0, 0, 1)
        SetEntityHeading(ped, pos.h)
        NetworkFadeInEntity(ped, 0)

        Citizen.Wait(500)
        PED_hasBeenTeleported = false
    end)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local ped = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(ped, true)
		local size = 0.5
		local r = 1.0

        for i,pos in pairs(INTERIORS) do
            if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.x, pos.y, pos.z, true) < 20) then
            	DrawText3D(pos.x,pos.y,pos.z,pos.name)
				if pos.t == 0 then
					size = 1.0
					DrawMarker(0, pos.x, pos.y, pos.z - 0.9, 0, 0, 0, 0, 0, 0, 0.8, 0.8, size, 0, 0, 255, 10, 0, 0, 2, 0, 0, 0, 0)
				end
				if pos.s == 's' then
					r = 0.5
				elseif pos.s == 'm' then
					r = 1.0
				elseif pos.s == 'l' then
					r = 1.5
				elseif pos.s == 'x' then
					r = 3.0
				elseif pos.s == 'n' then
					r = 0.0
				end
				DrawMarker(pos.t, pos.x, pos.y, pos.z - 1, 0, 0, 0, 0, 0, 0, r, r, size, 255, 255, 255, 200, 0, 0, 2, 0, 0, 0, 0)
				if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.x, pos.y, pos.z, true) < 1.2) and (PED_hasBeenTeleported == false) then
                    if IsControlJustPressed(1, 51) then
					   teleportation(pos)
                    else
                        notify("Appuyez sur ~INPUT_CONTEXT~ pour vous déplacer")
                    end
				end
            end
        end
    end
end)

function teleportation(pos)
    local ped = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        NetworkFadeOutEntity(ped, true, false)
		PED_hasBeenTeleported = true
		Citizen.Wait(500)
		for i,dest in pairs(INTERIORS[pos.id].destination) do
			SetEntityCoords(ped, INTERIORS[dest].x, INTERIORS[dest].y, INTERIORS[dest].z, 1, 0, 0, 1)
		break
		end
		NetworkFadeInEntity(ped, 0)
		Citizen.Wait(500)
		PED_hasBeenTeleported = false
    end)
end

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
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

function notify(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

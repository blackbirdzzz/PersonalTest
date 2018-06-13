function ShowHelp(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function ShowNotif(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function ShowMarker(x, y, z, d, r, g, b)
	DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, d, d, 0.5001, r, g, b, 255, 0, 0, 0, 0)
end

function ShowSubs(text, duration)
    duration = duration or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(duration, 1)
end

function Show3DText(x,y,z, text)
	z = z + 1
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
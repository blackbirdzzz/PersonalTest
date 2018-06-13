local hud = false

function getStatusHUD()
	return hud
end

function setStatusHUD(status)
	hud = status
end

function toogleHud()
	if hud then
		hud = false
	else
		hud = true
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
        if hud then
			HideHudAndRadarThisFrame() -- Life HUD + map
			HideHudComponentThisFrame(19) -- weapon wheel
			HideHudComponentThisFrame(1) -- Wanted Stars
			HideHudComponentThisFrame(2) -- Weapon icon
			HideHudComponentThisFrame(3) -- Cash
			HideHudComponentThisFrame(4) -- MP CASH
            HideHudComponentThisFrame(5) -- Mp Message
            HideHudComponentThisFrame(6) -- Vehicle Name
            HideHudComponentThisFrame(7)  -- Area Name
            HideHudComponentThisFrame(8) -- Vehicle Class
            HideHudComponentThisFrame(9) -- Street Name
			HideHudComponentThisFrame(13) -- Cash Change
			HideHudComponentThisFrame(11) -- Floating Help Text
			HideHudComponentThisFrame(12) -- more floating help text
			HideHudComponentThisFrame(15) -- Subtitle Text
            HideHudComponentThisFrame(16) -- Radio Stations Wheel
			HideHudComponentThisFrame(18) -- Game Stream
        end
    end
end)

RegisterNetEvent('Players:ToogleHud')
AddEventHandler('Players:ToogleHud', toogleHud)
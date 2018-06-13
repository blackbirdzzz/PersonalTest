-- Game menu
Citizen.CreateThread(function()

  if NetworkIsSessionStarted() then
	  while true do
	    Citizen.Wait(10)

      local status = exports["Players"]:getStatusHUD()

	    -- Open game menu
	    if not IsPauseMenuActive() and not IsHudComponentActive(19) and not IsHudComponentActive(16) and not status then
				SendNUIMessage({
					setOpacity = true,
					opacity = 1
				})
			else
				SendNUIMessage({
					setOpacity = true,
					opacity = 0
				})
	    end
	  end
  end

end)

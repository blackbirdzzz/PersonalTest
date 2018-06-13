AddEventHandler('onClientMapStart', function()
  Citizen.CreateThread(function()
    TriggerEvent("disclaimer:openHelp")
  end)
end)

RegisterNetEvent("disclaimer:openHelp")
AddEventHandler("disclaimer:openHelp", function()
	local display = true

	openDisclaimer(true)
    while display do
		Citizen.Wait(1)
		ShowInfo('~INPUT_CONTEXT~ pour fermer\n~INPUT_CELLPHONE_LEFT~ ~INPUT_CELLPHONE_RIGHT~ pour faire défiler', 0)
		drawNotification('~y~Merci de lire attentivement avant de poser des questions~w~')
		if (IsControlJustPressed(1, 51) or IsControlJustPressed(1, 215) or IsControlJustPressed(1, 322)) then
			display = false
			openDisclaimer(false)
			ShowInfo('Votre touche Push To Talk est ~INPUT_PUSH_TO_TALK~', 0)
		elseif (IsControlJustPressed(1, 175)) then
			nextdisclaimer()
		elseif (IsControlJustPressed(1, 174)) then
			previousdisclaimer()
	  end
	end
end)

function openDisclaimer(value)
  SendNUIMessage({
    opendisclaimer = value
  })
end

function nextdisclaimer()
  SendNUIMessage({
    nextdisclaimer = true
  })
end

function previousdisclaimer()
  SendNUIMessage({
    previousdisclaimer = true
  })
end

-- UTILS --
function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end
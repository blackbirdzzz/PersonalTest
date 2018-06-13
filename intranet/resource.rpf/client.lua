
--[[Citizen.CreateThread(function()
  while true do
    Wait(1)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)
    if GetDistanceBetweenCoords(213.72, -808.85, 31.01, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 1 then
    	if IsControlJustPressed(0, 51) then
			TriggerServerEvent("intranet:openintra")
			--TriggerEvent("intranet:open", "http://test.triumrp.com/web/panel")
    	end
    end
  end
end)]]


RegisterNetEvent("intranet:open")
AddEventHandler("intranet:open", function(url)
  openDisclaimer(true, url)
end)

function openDisclaimer(value, lien)
  SendNUIMessage({
    open = value,
    url = lien
  })
  SetNuiFocus(value, value)
end

RegisterNUICallback('close', function(data, cb)
  openDisclaimer(false)
  cb('ok')
end)

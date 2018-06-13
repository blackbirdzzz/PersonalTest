function GiveParachute()
	local player = GetPlayerPed(-1)
	if HasPedGotWeapon(player, GetHashKey("GADGET_PARACHUTE"), false) then
		ShowInfo("~r~Vous avez déjà un parachute.")
	else
		GiveWeaponToPed(player, GetHashKey("GADGET_PARACHUTE"), 0, true, true)
		TriggerServerEvent("parachute:buy")
		ShowInfo("~g~Vous venez d'acheter un parachute.\n~s~Bon saut !")
	end
end
function IsNearParachute()
  local player = GetPlayerPed(-1)
  local playerCoords = GetEntityCoords(player, 0)
  for _, item in pairs(parachutes) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  playerCoords["x"], playerCoords["y"], playerCoords["z"], true)
	if (distance < 15) then
		DrawMarker(1, item.x, item.y, item.z - 1, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 100, 200, 255, 200, 0, 0, 0, 0)
		local pickup = CreatePickupRotate(GetHashKey("PICKUP_PARACHUTE"), item.x, item.y, item.z , 0.0, 0.0, item.h, 1, 0, 1, true, GetHashKey("PICKUP_PARACHUTE"))
		--SetPickupRegenerationTime(pickup, 1)
		--SetEntityDynamic(pickup, true)
		--SetEntityCollisions(pickup, false)
		--SetEntityHasGravity(pickup, false)
		--FreezeEntityPosition(pickup, true)
		--SetEntityVelocity(weapon, 0.0, 0.0, -0.2)
		end
	if (distance < 3) then
		showHelpMessage("Appuyez sur ~INPUT_PICKUP~ pour obtenir un ~b~parachute ~w~(" .. price .. "$)")
		if IsControlJustPressed(1, 38) then
			GiveParachute()
		end
	end
	if (distance > 15) then
		RemoveAllPickupsOfType(GetHashKey("PICKUP_PARACHUTE"))
	end
  end
end

RegisterNetEvent('parachute:notif')
AddEventHandler('parachute:notif', function(txt)
    ShowInfo(txt)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		IsNearParachute()
    end
end)

function showHelpMessage(message)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function ShowInfo(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(true, false)
end

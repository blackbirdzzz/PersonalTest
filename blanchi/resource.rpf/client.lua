-- HERE GOES YOUR CLIENT FUNCTIONALITY!
isBlanchisseur = false
local nbPolice = 0

local posBlanchi = {
	{ x = 1446.99, y = 1152.89, z = 114.33 },
	{ x = -103.46, y = 6476.16,z = 31.63},
	{ x = 708.3, y = -966.54,z = 30.4}
	
}


AddEventHandler("playerSpawned", function()
  TriggerServerEvent("blanchi:checkIsBlanchisseur")
end)

RegisterNetEvent('blanchi:receiveIsBlanchisseur')
AddEventHandler('blanchi:receiveIsBlanchisseur', function(result)
  Citizen.Trace('isBlanchisseur')
  if(result == "0") then
    isBlanchisseur = false
  else
    isBlanchisseur = true
  end
end)

RegisterNetEvent('blanchi:drawTransform')
AddEventHandler('blanchi:drawTransform', function (qte)
		if(qte == nil) then
			qte = 0
		end
		if qte > 0 then
			
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~b~Vous avez blanchis votre argent")
			DrawSubtitleTimed(2000, 1)
		else
			-- ClearPrints()
			-- SetTextEntry_2("STRING")
			-- AddTextComponentString("~r~Vous n'avez plus d'argent sale")
			-- DrawSubtitleTimed(2000, 1)
		end
end)

Citizen.CreateThread(function()
    while true do
       Citizen.Wait(1)
       playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if pos then
			if (isBlanchisseur == true) then
				for k,v in ipairs(posBlanchi) do
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) <= 2 then
						if (nbPolice > 1) then
							ClearPrints()
							SetTextEntry_2("STRING")
							AddTextComponentString("~s~Blanchiment en cours...")
							DrawSubtitleTimed(90000, 1)
							Citizen.Wait(90000)
							TriggerServerEvent('blanchi:transform',source)
						else
							TriggerEvent("mt:missiontext", 'Il faut au moins 2 policiers en Service pour Blanchir', 800)
						end		
					end	
				end
			end			
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		TriggerServerEvent('blanchi:stestcop')
	end
end)

RegisterNetEvent('blanchi:getcop')
AddEventHandler("blanchi:getcop", function(nbPolicier)
	nbPolice = nbPolicier
	--Citizen.Trace(nbPolice)
end)
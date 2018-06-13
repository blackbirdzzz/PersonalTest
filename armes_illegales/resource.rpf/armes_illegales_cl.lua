local posVentes = {
	{x=1188.50,y=2641.00,z=38.40},
	{x=-110.38,y=-14.34,z=70.02},
	{x=-331.7,y=6085.02,z=30.95},
}
local isMafieu = false

AddEventHandler("playerSpawned", function()
  TriggerServerEvent("armes_illegales:checkIsMafieu")
end)

RegisterNetEvent('armes_illegales:receiveIsMafieu')
AddEventHandler('armes_illegales:receiveIsMafieu', function(result)
  if(result == "0") then
    isMafieu = false
	Citizen.Trace('isNotVendeurArmesIllegales')
  else
    isMafieu = true
	Citizen.Trace('isVendeurArmesIllegales')
  end
end)

RegisterNetEvent("armes_illegales:getFood")
RegisterNetEvent("armes_illegales:selection")

function Chat(t)
	TriggerEvent("chatMessage", 'Atelier de fabrication', { 0, 255, 255}, "" .. tostring(t))
end

AddEventHandler("armes_illegales:selection", function(data)
	local item = data.itemid
	local price = data.price
	if (exports.vdk_inventory:notFull() == true) then
		TriggerServerEvent('armes_illegales:testprix',item,price)
	else
		Chat("INVENTAIRE PLEIN")
	end
end)

AddEventHandler("armes_illegales:getFood", function(item)
	TriggerEvent('player:receiveItem',item,1)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(posVentes) do
			if (isMafieu == true) then
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
					DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
					if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
						DisplayHelpText("Appuyer sur ~INPUT_CONTEXT~ pour ouvrir/fermer l'atelier de fabrication")
						if(IsControlJustReleased(1, 51))then
							Menu.initMenu()
							Menu.isOpen = not Menu.isOpen
						end
						if Menu.isOpen then
							Menu.draw()
							Menu.keyControl()
						end
					end
				end
			end
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
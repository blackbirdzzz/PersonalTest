isCop = falsez
isCopInService = false
local rank = "inconnu"
local checkpoints = {}
local existingVeh = nil
local handCuffed = false
local isAlreadyDead = false
local allServiceCops = {}
local blipsCops = {}
local drag = false
local officerDrag = -1
local isDragging = false

local takingService = {
  --{x=850.156677246094, y=-1283.92004394531, z=28.0047378540039},
  {x=457.95, y=-992.72, z=30.68}, -- Central
  {x=1856.91, y=3689.50, z=34.26},	-- Sandy Shore
  {x=-449.62, y=6016.36, z=31.71}	-- Paleto Bay
}
local Armurerie = {
 {x = 452.24, y = -980.12, z = 30.68}, -- Central
 {x = 1848.67, y = 3689.97, z = 34.27}, -- Sandy Shores
 {x=-448.01, y=6008.26, z=31.71} -- Paleto
}

--local stationGarage = {
--	{x=455.36, y=-1019.94, z=28.3322}, -- Central
--	{x=1874.46, y=3686.08, z=31.3322}, -- Sandy Shore
--	{x=-452.02, y=5998.38, z=31.3322} -- Paelo Bay
	
--}
stationGarage = {
	{id=1, xMenu=455.36, yMenu=-1019.94, zMenu=28.3322, xSortieVL = 463.3115, ySortieVL = -1019.43, zSortieVL = 27.84 , hSortieV = 90.02,xSortiePL = 451.15, ySortiePL = -1013.65, zSortiePL = 28.47, h = 93.23 }, -- Central
	{id=2, xMenu=1868.79, yMenu= 3688.21, zMenu=33.70, xSortieV=1868.24, ySortieV=3697.23, zSortieV=32.70, hSortieV=209.0}, -- Sandy Shore
	{id=3, xMenu=-456.58, yMenu= 6009.36, zMenu=31.33, xSortieV=-452.02, ySortieV=5998.38, zSortieV=31.33, hSortieV = 87.0} -- Paleto Bay
}

local Helipad = {
    {x=449.113,y=-981.084,z=43.691,}, -- Central
    {x=-470.64, y=5984.48, z=31.40} -- Paelo Bay
}

AddEventHandler("playerSpawned", function()
	TriggerServerEvent("police:checkIsCop")
end)

local isok = nil
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerpos = GetEntityCoords(GetPlayerPed(-1), true)
		for k, v in pairs(portes) do
			if GetDistanceBetweenCoords(v.x, v.y, v.z, playerpos.x, playerpos.y, playerpos.z, true) < v.detectdist then
				if isok == nil then
					TriggerServerEvent("police:lockunlockjaildoorSpawn", v.id)
					isok = v
				end
			elseif isok == v then
				isok = nil
			end
		end
	end
end)

RegisterNetEvent('police:receiveIsCop')
AddEventHandler('police:receiveIsCop', function(result)
--	Citizen.Trace('isCopisCopisCopisCopisCopisCopisCop')
	if(result == "inconnu") then
		isCop = false
	else
		isCop = true
		rank = result
	end
end)

RegisterNetEvent('police:nowCop')
AddEventHandler('police:nowCop', function()
	isCop = true
end)

RegisterNetEvent('police:noLongerCop')
AddEventHandler('police:noLongerCop', function()
	isCop = false
	isCopInService = false
	
	local playerPed = GetPlayerPed(-1)					
	TriggerServerEvent("skin_customization:SpawnPlayer")
	SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)
	RemoveAllPedWeapons(playerPed)
	
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
	
	ServiceOff()
end)

RegisterNetEvent('police:getArrestedetouicchiant')
AddEventHandler('police:getArrestedetouicchiant', function()
	--if(isCop == false) then
		handCuffed = not handCuffed
		if(handCuffed) then
			TriggerEvent('gcPhone:handCuffed', true)
			TriggerEvent('item:handCuffed', true)
			TriggerEvent('chatMessage', 'LSPD', {0, 0, 255}, "vous êtes menotté")
		else
			TriggerEvent('gcPhone:handCuffed', false)
			TriggerEvent('item:handCuffed', false)
			TriggerEvent('chatMessage', 'LSPD', {0, 0, 255}, "LIBRE !")
		end
	--end
end)

RegisterNetEvent('police:LooseWeapons')
AddEventHandler('police:LooseWeapons', function()
	local ply = GetPlayerPed(-1)
	TriggerServerEvent("weaponshop:RemoveWeaponsToPlayer")
	--
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_KNIFE"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_HAMMER"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_BAT"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_GOLFCLUB"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_HATCHET"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_BATTLEAXE"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_MACHETE"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_CROWBAR"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SNSPISTOL"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_FIREWORK"))
	--
	
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PUMPSHOTGUN"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_ASSAULTRIFLE"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SNIPERRIFLE"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL50"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SMG"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_MICROSMG"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_CARBINERIFLE"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SPECIALCARBINE"))
	RemoveWeaponFromPed(ply, GetHashKey("WEAPON_COMBATPISTOL"))
	TriggerEvent('chatMessage', 'LSPD', {0, 0, 255}, "Le Policier vient de prendre vos armes !")
end)

RegisterNetEvent('police:dropIllegalItem')
AddEventHandler('police:dropIllegalItem', function(id)
	TriggerEvent("player:looseItem", tonumber(id), exports.vdk_inventory:getQuantity(id))
end)

RegisterNetEvent('police:unseatme')
AddEventHandler('police:unseatme', function(t)
	local ped = GetPlayerPed(t)        
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2
   
	SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('police:toggleDrag')
AddEventHandler('police:toggleDrag', function(t)
	if(handCuffed) then
		drag = not drag
		officerDrag = t
	end
end)

--[[Citizen.CreateThread(function()
	while true do
		if drag then
			local ped = GetPlayerPed(GetPlayerFromServerId(officerDrag))
			local myped = GetPlayerPed(-1)
			AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
		else
			DetachEntity(GetPlayerPed(-1), true, false)
		end
		Citizen.Wait(0)
	end
end)]]--

RegisterNetEvent('police:forcedEnteringVeh')
AddEventHandler('police:forcedEnteringVeh', function(veh)
	if(handCuffed) then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
		end
	end
end)

RegisterNetEvent('police:resultAllCopsInService')
AddEventHandler('police:resultAllCopsInService', function(array)
	allServiceCops = array
	enableCopBlips()
end)

function enableCopBlips()

	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
	
	local localIdCops = {}
	for id = 0, 68 do
		if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			for i,c in pairs(allServiceCops) do
				if(i == GetPlayerServerId(id)) then
					localIdCops[id] = c
					break
				end
			end
		end
	end
	
	for id, c in pairs(localIdCops) do
		local ped = GetPlayerPed(id)
		local blip = GetBlipFromEntity(ped)
		
		if not DoesBlipExist( blip ) then

			blip = AddBlipForEntity( ped )
			SetBlipSprite( blip, 1 )
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			HideNumberOnBlip( blip )
			SetBlipNameToPlayerName( blip, id )
			
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsCops, blip)
		else
			
			blipSprite = GetBlipSprite( blip )
			
			HideNumberOnBlip( blip )
			if blipSprite ~= 1 then
				SetBlipSprite( blip, 1 )
				Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			end
			
			Citizen.Trace("Name : "..GetPlayerName(id))
			SetBlipNameToPlayerName( blip, id )
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsCops, blip)
		end
	end
end

function GetPlayers()
    local players = {}

    for i = 0, 68 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function getIsInService()
	return isCopInService
end

function isNearTakeService()
	for i = 1, #takingService do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end
function isNearArmurerie()
	for i = 1, #Armurerie do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(Armurerie[i].x, Armurerie[i].y, Armurerie[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, Armurerie[i].x, Armurerie[i].y, Armurerie[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 1.25) then
			return true
		end
	end
end

function isNearStationGarage()
	for i = 1, #stationGarage do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationGarage[i].xMenu, stationGarage[i].yMenu, stationGarage[i].zMenu, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, stationGarage[i].xMenu, stationGarage[i].yMenu, stationGarage[i].zMenu-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function isNearHelipad()
    for i = 1, #Helipad do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(Helipad[i].x, Helipad[i].y, Helipad[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(1, Helipad[i].x, Helipad[i].y, Helipad[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
        end
        if(distance < 2) then
            return true
        end
    end
end

function ServiceOn()
	isCopInService = true
	--TriggerServerEvent("jobssystem:jobs", 2)
	TriggerServerEvent("police:takeService")
end

function ServiceOff()
	isCopInService = false
	--TriggerServerEvent("jobssystem:jobs", 7)
	TriggerServerEvent("police:breakService")
	allServiceCops = {}
	
	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if drag then
            isDragging = true
            local ped = GetPlayerPed(GetPlayerFromServerId(officerDrag))
            local myped = GetPlayerPed(-1)
            AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
        else
            if isDragging then
                isDragging = false
                DetachEntity(GetPlayerPed(-1), true, false)
            end
        end
        if(isCop and not handCuffed) then -- impossible de menotter les flics sans "not handCuffed"
            if(isNearTakeService()) then
            
                DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le vestiaire',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~
                if IsControlJustPressed(1,51) then
                    --OpenMenuVest()
                    MenuChoixPoliceService()
                end
            end
            
            
           if(isCopInService) then
                --
                if(isNearArmurerie()) then
                    DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l\'armurerie',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~
                    if IsControlJustPressed(1,51) then
                        MenuArmurerie()
                    end
                end
                
            
                if (isNearHelipad()) then
                    if(existingVeh ~= nil) then
                        DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ranger votre helicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
                    else
                        DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour prendre vote helicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
                    end
                    
                    if IsControlJustPressed(1,51)  then
                        if(existingVeh ~= nil) then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
							--[[local car = GetHashKey("polmav")
							local ply = GetPlayerPed(-1)
							local plyCoords = GetEntityCoords(ply, 0)
							
							RequestModel(car)
							while not HasModelLoaded(car) do
									Citizen.Wait(0)
							end
							
							existingVeh = CreateVehicle(car, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
							SetVehicleLivery(existingVeh, 0)
							local id = NetworkGetNetworkIdFromEntity(existingVeh)
							SetNetworkIdCanMigrate(id, true)
							TaskWarpPedIntoVehicle(ply, existingVeh, -1)]]--
							MenuChoixPoliceVehicleHeli()
						end
					end
				end
				--
				if(isNearStationGarage()) then
					if(policevehicle ~= nil) then --existingVeh
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ranger votre vehicule',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage de police',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51) then
						if(policevehicle ~= nil) then
							SetEntityAsMissionEntity(policevehicle, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(policevehicle))
							policevehicle = nil
						else
							--OpenVeh()
							MenuChoixPoliceVehicleCar()
						end
					end
				end
				
				
			end
		else
			if (handCuffed == true) then
			  RequestAnimDict('mp_arresting')

			  while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			  end

			  local myPed = PlayerPedId()
			  local animation = 'idle'
			  local flags = 16

			  TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
			end
		end
		for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
    end
end)
---------------------------------------------------------------------------------------
-------------------------------SPAWN HELI AND CHECK DEATH------------------------------
---------------------------------------------------------------------------------------
local alreadyDead = false

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isCop) then
			if(isCopInService) then
			
				-- if(IsPlayerDead(PlayerId())) then
					-- if(alreadyDead == false) then
						-- ServiceOff()
						-- alreadyDead = true
					-- end
				-- else
					-- alreadyDead = false
				-- end
			
				DrawMarker(1,449.113,-981.084,42.691,0,0,0,0,0,0,2.0,2.0,2.0,0,155,255,200,0,0,0,0)
			
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 449.113,-981.084,43.691, true ) < 5 then
					if(existingVeh ~= nil) then
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ranger votre helicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour prendre vote helicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51)  then
						if(existingVeh ~= nil) then
							SetEntityAsMissionEntity(existingVeh, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
							existingVeh = nil
						else
							local car = GetHashKey("polmav")
							local ply = GetPlayerPed(-1)
							local plyCoords = GetEntityCoords(ply, 0)
							
							RequestModel(car)
							while not HasModelLoaded(car) do
									Citizen.Wait(0)
							end
							
							existingVeh = CreateVehicle(car, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
							SetVehicleLivery(existingVeh, 0)
							local id = NetworkGetNetworkIdFromEntity(existingVeh)
							SetNetworkIdCanMigrate(id, true)
							TaskWarpPedIntoVehicle(ply, existingVeh, -1)
						end
					end
				end
			end
		end
    end
end)]]--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
			if not(isCopInService) then
				local ply = GetPlayerPed(-1)
				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PUMPSHOTGUN"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_ASSAULTRIFLE"))
				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SNIPERRIFLE"))
				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL50"))
				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SMG")) Arme Garde du corp Gouv 
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_MICROSMG"))
				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_CARBINERIFLE"))
				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SPECIALCARBINE"))
				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_COMBATPISTOL"))
			end
	end
end)

--[[Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
end)]]--


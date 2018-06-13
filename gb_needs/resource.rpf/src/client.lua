--
-- @Project: Trium
-- @License: No License
--

local rpdfirstspawn = 0
local foodv = 0
local peev = 0
local waterv = 0
local timingsave = 120000

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
					opacity = 1,
				})
			else
				SendNUIMessage({
					setOpacity = true,
					opacity = 0,
				})
	    end
	  end

  end

end)

AddEventHandler('playerSpawned', function(spawn)
	if rpdfirstspawn == 0 then
		rpdfirstspawn = 1
	else
		TriggerServerEvent('gabs:setdefaultneeds')
	end
end)

RegisterNetEvent("ft_libs:OnClientReady")
AddEventHandler('ft_libs:OnClientReady', function()

	Citizen.Trace("ft_libs : Ready")
	while true do
		Citizen.Wait(timingsave)
		TriggerServerEvent("gabs:updateMe")
	end

end)

RegisterNetEvent('gabs:needskill')
AddEventHandler('gabs:needskill', function(foods, waters , pees)
	if foods == foodv and waters == waterv and pees == peev then
		SetEntityHealth(GetPlayerPed(-1), 0)
	end
	if foods ~= foodv then
		 local id = PlayerId()
		foodv = foods
		local playerName = GetPlayerName(id)
		SendNUIMessage({
		setfood = true,
		food = foods,
		player = playerName
		})
		end
	if waters ~= waterv then
		local id = PlayerId()
		waterv = waters
		local playerName = GetPlayerName(id)
			SendNUIMessage({
			setwater = true,
			water = waters,
			player = playerName
			})
			end
	if pees ~= peev then
	local id = PlayerId()
		peev = pees
		local playerName = GetPlayerName(id)
		SendNUIMessage({
		setneeds = true,
		needs = pees,
		player = playerName
		})
		end

end)

-- FOOD
RegisterNetEvent('gabs:setfood')
AddEventHandler('gabs:setfood', function(food)
  local id = PlayerId()
  foodv = food
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		setfood = true,
		food = food,
		player = playerName
	})
end)

RegisterNetEvent("gabs:add_calories")
AddEventHandler("gabs:add_calories", function(calories)

	SendNUIMessage({
		addcalories = true,
		calories = calories
	})

end)

RegisterNetEvent("gabs:remove_calories")
AddEventHandler("gabs:remove_calories", function(calories)
	SendNUIMessage({
		removecalories = true,
		calories = calories
	})
end)
-- WATER
RegisterNetEvent('gabs:setwater')
AddEventHandler('gabs:setwater', function(water)
  local id = PlayerId()
  waterv = water
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		setwater = true,
		water = water,
    player = playerName
	})
end)

RegisterNetEvent("gabs:add_water")
AddEventHandler("gabs:add_water", function(waterdrops)
	SendNUIMessage({
		addwater = true,
		waterdrops = waterdrops
	})

end)

RegisterNetEvent("gabs:remove_water")
AddEventHandler("gabs:remove_water", function(waterdrops)
	SendNUIMessage({
		removewater = true,
		waterdrops = waterdrops
	})
end)
-- NEEDS
RegisterNetEvent('gabs:setneeds')
AddEventHandler('gabs:setneeds', function(needs)
  local id = PlayerId()
  peev = needs
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		setneeds = true,
		needs = needs,
    player = playerName
	})
end)

RegisterNetEvent("gabs:add_needs")
AddEventHandler("gabs:add_needs", function(wc)
	SendNUIMessage({
		addneeds = true,
		wc = wc
	})

end)

RegisterNetEvent("gabs:remove_needs")
AddEventHandler("gabs:remove_needs", function(wc)
	SendNUIMessage({
		removeneeds = true,
		wc = wc
	})
end)
-- EMOTES
RegisterNetEvent('gabs:drink')
AddEventHandler('gabs:drink', function()
	ped = GetPlayerPed(-1)
	if ped then
		Citizen.CreateThread(function()
			RequestAnimDict('amb@world_human_drinking_fat@beer@male@idle_a')
		    local pedid = PlayerPedId()
			TaskPlayAnim(pedid, 'amb@world_human_drinking_fat@beer@male@idle_a', 'idle_a', 8.0, -8, -1, 16, 0, 0, 0, 0)
			Citizen.Wait(5000)
			ClearPedTasks(ped)
		end)
	end
end)

RegisterNetEvent('gabs:eat')
AddEventHandler('gabs:eat', function()
	ped = GetPlayerPed(-1)
	if ped then
		Citizen.CreateThread(function()
			RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
		    local pedid = PlayerPedId()
			TaskPlayAnim(pedid, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c', 8.0, -8, -1, 16, 0, 0, 0, 0)
			Citizen.Wait(5000)
			ClearPedTasks(ped)
		end)
	end
end)

RegisterNetEvent('gabs:pee')
AddEventHandler('gabs:pee', function()
	ped = GetPlayerPed(-1)
	local hashSkin = GetHashKey("mp_m_freemode_01")
	if IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
		if ped then
			if(GetEntityModel(GetPlayerPed(-1)) ~= hashSkin) then
				Citizen.CreateThread(function()
					RequestAnimDict('missfbi3ig_0')
					local pedid = PlayerPedId()
					TaskPlayAnim(pedid, 'missfbi3ig_0', 'shit_loop_trev', 8.0, 8, -1, 0, 0, 0, 0, 0)
					ClearPedTasks(ped)
				end)
			else
				Citizen.CreateThread(function()
					RequestAnimDict('misscarsteal2peeing')
					local pedid = PlayerPedId()
					TaskPlayAnim(pedid, 'misscarsteal2peeing', 'peeing_intro', 8.0, -8, -1, 0, 0, 0, 0, 0)
					Citizen.Wait(GetAnimDuration('misscarsteal2peeing', 'peeing_intro'))
					TaskPlayAnim(pedid, 'misscarsteal2peeing', 'peeing_loop', 8.0, -8, -1, 0, 0, 0, 0, 0)
					Citizen.Wait(GetAnimDuration('misscarsteal2peeing', 'peeing_loop'))
					TaskPlayAnim(pedid, 'misscarsteal2peeing', 'peeing_outro', 8.0, -8, -1, 0, 0, 0, 0, 0)
					ClearPedTasks(ped)
				end)
			end
		end
	else
	end
end)

-- Decor
DecorRegister("_lspd", 2)

local policeveh = {
	opened = false,
	title = "Cop Garage",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }, -- ???
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				--{name = "Police Stanier", costs = 0, description = {}, model = "police"},
				--{name = "Police Buffalo", costs = 0, description = {}, model = "police2"},
				--{name = "Police Interceptor", costs = 0, description = {}, model = "police3"},
				{name = "Cop Car", costs = 0, description = {}, model = "police4"},
				--{name = "Police Rancher", costs = 0, description = {}, model = "policeold1"},
				--{name = "Police Esperanto", costs = 0, description = {}, model = "policeold2"},
				--{name = "Police Transport Van", costs = 0, description = {}, model = "policet"},
				--{name = "FBI", costs = 0, description = {}, model = "fbi"},
				--{name = "FBI2", costs = 0, description = {}, model = "fbi2"},
				{name = "Cop Motorcycle", costs = 0, description = {}, model = "policeb"},

			}
		},
	},

	police = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    police2 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    police9 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    police10 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    police11 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    police13 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    policebike = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    pranger = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    fbi = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	fbi2 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    fbi3 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    sheriff = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    sheriff2 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    bulpolice = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    bulpolice3 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    bulhway2 = {x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
    policeb = {x = 463.3115, y = -1019.43, z = 27.84, h = 90.02},
    policet = {x = 451.15, y = -1013.65, z = 28.47, h = 93.23},
    pbus = {x = 451.15, y = -1013.65, z = 28.47, h = 93.23},
    police14 = {x = 451.15, y = -1013.65, z = 28.47, h = 93.23},
    riot = {x = 451.15, y = -1013.65, z = 28.47, h = 93.23}
}

local fakecar = {model = '', car = nil}
local boughtcar = false
local vehicle_price = 0

function LocalPed()
    return GetPlayerPed(-1)
end

function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
end

function POLICE_invokeVehicle(data)
	car = GetHashKey(data.model)
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	RequestModel(car)
	while not HasModelLoaded(car) do
		Citizen.Wait(0)
	end

	existingVeh = CreateVehicle(car, plyCoords["x"], plyCoords["y"], plyCoords["z"], 345.0, true, false)
	SetVehicleLivery(existingVeh, 0)
	local id = NetworkGetNetworkIdFromEntity(existingVeh)
	SetNetworkIdCanMigrate(id, true)
	TaskWarpPedIntoVehicle(ply, existingVeh, -1)
	DecorSetBool(existingVeh, "_lspd", true)
end

function POLICE_deleteHelicouptere()
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	local vehiculeDetected = GetPoliceHeli(plyCoords["x"], plyCoords["y"], plyCoords["z"])
	if DoesEntityExist(vehiculeDetected) then
		SetEntityAsMissionEntity(vehiculeDetected, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
	else
		if ( IsPedSittingInAnyVehicle( ply ) ) then
            local vehiculeDetected = GetVehiclePedIsIn( ply, false )
            SetEntityAsMissionEntity(vehiculeDetected, true, true)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
        end
	end
end

function GetPoliceHeli(helix, heliy, heliz)
    local rayHandle = CastRayPointToPoint( helix - 10, heliy - 10, heliz - 10, helix + 20, heliy + 20, heliz + 20, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

function POLICE_SpanwVehicleCar(data)
    --Citizen.Trace('POLICE_SpawnVehicleCar' .. data.model)
    --if fakecar.model ~= data.model then
        --if DoesEntityExist(fakecar.car) then
        --    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        --end
        local ped = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ped, 0)
        local hash = GetHashKey(data.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end
		local pos = {}
		for k, v in pairs(stationGarage) do
			local distance = GetDistanceBetweenCoords(v.xMenu, v.yMenu, v.zMenu, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(distance < 10) then
				pos = v
				break
			end
		end
		local vehiculeDetected = GetClosestVehicle(pos.xSortieV, pos.ySortieV, pos.zSortieV, 6.0, 0, 70)
		if(DoesEntityExist(vehiculeDetected)) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
		end
		--Citizen.Trace('P' .. pos.x .. '  '.. pos.y .. '  '.. pos.z .. '  '.. pos.h)

		if pos.id == 1 then
			if	data.model =="pbus" or data.model =="riot" or data.model =="policet" or data.model =="police14" then -- gros véhicules comico principal
				veh = CreateVehicle(hash,pos.xSortiePL, pos.ySortiePL, pos.zSortiePL,pos.hSortieV,true,false)
			else
				veh = CreateVehicle(hash,pos.xSortieVL, pos.ySortieVL, pos.zSortieVL,pos.hSortieV,true,false) -- normaux comico principal
			end
		else
			veh = CreateVehicle(hash,pos.xSortieV, pos.ySortieV, pos.zSortieV,pos.hSortieV,true,false) -- autres comicos
		end

		local plate = math.random(100, 900)
		local plateBana = math.random(10000000, 90000000)
		if data.model == "xls2" then -- ???
			SetVehicleNumberPlateText(veh, "SECRET"..plate)
		elseif data.model == "fbi" or data.model == "fbi2" or data.model == "fbi3" or data.model == "police14"  or data.model == "bulpolice3" or data.model == "infpolice2" then
			SetVehicleNumberPlateText(veh,tostring(plateBana)) --  Plaque normale pour les véhicules bana
		else 												-- tout autres véhicules
			SetVehicleNumberPlateText(veh, "LSPD "..plate)
		end

		SetEntityAsMissionEntity(veh, true, true)
		_plate = GetVehicleNumberPlateText(veh)
		TriggerServerEvent('ls:recevoircles', string.lower(tostring(_plate)), veh)

		SetVehicleMod(veh,11,3) -- Engine
		SetVehicleMod(veh,12,2)	-- brakes
		SetVehicleMod(veh,13,2) -- transmission
		SetVehicleMod(veh,15,3) -- suspension
		SetVehicleMod(veh,16,2) -- armor
		ToggleVehicleMod(veh, 18, true) -- turbo
		if data.model == "fbi3" or data.model == "fbi" or data.model == "fbi2" then -- color random bana
			local color = math.random(0, 159)
			local paintType = 0 -- normal
			 SetVehicleModColor_1(veh,paintType,color, false) -- last param seems to be always false
			 SetVehicleModColor_2(veh,paintType,color, false) -- last param seems to be always false
		end
		--[[if data.model == "police" or data.model == "police2" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		elseif data.model == "police3" or data.model == "police4" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		elseif data.model == "police5" or data.model == "police6" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		elseif data.model == "police7" or data.model == "police8" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		elseif data.model == "police9" or data.model == "police10" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		elseif data.model == "fbi" or data.model == "fbi2" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		elseif data.model == "sheriff" or data.model == "sheriff2" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		elseif data.model == "policet" or data.model == "policeb" then
			SetVehicleEnginePowerMultiplier(veh, 150.01)
		end]]--

        --FreezeEntityPosition(veh,true)
        --SetEntityInvincible(veh,true)
        --SetVehicleDoorsLocked(veh,4)
        --SetEntityCollision(veh,false,false)
        --TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
        -- for i = 0,24 do
        --     SetVehicleModKit(veh,0)
        --     RemoveVehicleMod(veh,i)
        -- end
        fakecar = { model = data.model, car = veh}
--    -- end

end



RegisterNetEvent('policeveh:spawnVehicle')
AddEventHandler('policeveh:spawnVehicle', function(v)
	-- local car = GetHashKey(v)
	-- local playerPed = GetPlayerPed(-1)
	-- if playerPed and playerPed ~= -1 then
	-- 	RequestModel(car)
	-- 	while not HasModelLoaded(car) do
	-- 			Citizen.Wait(0)
	-- 	end
	-- 	local playerCoords = GetEntityCoords(playerPed)

	-- 	veh = CreateVehicle(car, playerCoords, 0.0, true, false)
	-- 	TaskWarpPedIntoVehicle(playerPed, veh, -1)
	-- 	SetEntityInvincible(veh, false)
	-- end
end)
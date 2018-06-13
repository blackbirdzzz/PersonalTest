
local isInServicePecheur = false

local spawn_tug = {x = 3860.796, y = 4473.504, z = 0.473, h= 275.0}
local spawn_benson = {x = 3792.856, y = 4472.238, z = 5.200, h= 116.0}

function isInServicePecheurBool()
    return isInServicePecheur
end
function GetServicePecheur()
    local playerPed = GetPlayerPed(-1)
    if isInServicePecheur then
        DisplayHelpText('Fin du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        TriggerServerEvent("skin_customization:SpawnPlayer")
        isInServicePecheur = not isInServicePecheur
    else
        DisplayHelpText('Début du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        GetSkinPecheur()
        isInServicePecheur = true
    end
end

function GetSkinPecheur()
    local hashSkin = GetHashKey("mp_m_freemode_01")
    Citizen.CreateThread(function()
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) -- pas de collier
            SetPedComponentVariation(GetPlayerPed(-1), 11, 124, 0, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 24, 1, 2) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 47, 1, 2) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 108, 0, 2) -- under skin
        else
            SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) -- pas de collier
            SetPedComponentVariation(GetPlayerPed(-1), 11, 63, 3, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 44, 1, 2) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 11, 14, 2) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 36, 0, 2) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 78, 0, 2) -- under skin
        end
    end)
end

-- SUPPRESSION DES VEHICULES
function pecheur_RangerBateau(result)
    local vehiculeDetected = GetTugBoat(result.coordx, result.coordy, result.coordz)
    if DoesEntityExist(vehiculeDetected) then
        SetEntityAsMissionEntity(vehiculeDetected, true, true)
        DeleteVehicle(vehiculeDetected)
    end
    Menu.hidden = true
end

function GetTugBoat(tugx, tugy, tugz)
    local rayHandle = CastRayPointToPoint(tugx - 10.0, tugy - 10.0, tugz - 10.0, tugx + 20.0, tugy + 20.0, tugz + 20.0, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function pecheur_RangerCamion(result)
    local vehiculeDetected = GetClosestVehicle(result.coordx, result.coordy, result.coordz, 6.0, 0, 70)
    if DoesEntityExist(vehiculeDetected) then
        SetEntityAsMissionEntity(vehiculeDetected, true, true)
        DeleteVehicle(vehiculeDetected)
    end
    Menu.hidden = true
end
--

function GetVehiclePecheur(x, y, z, vehicules, PlayerId)
    ClearMenu()
    options.menu_title = "Pecheurs"
    options.menu_subtitle = "Vehicules"
    Menu.selection = 1
    for k, v in pairs(vehicules) do
        Menu.addButton(v.nom, "PecheurSpawnCar", {model = v.model, coordx = x, coordy = y, coordz = z,id=PlayerId})
        if(v.model == 'tug') then
            Menu.addButton("Ranger le Bâteau", "pecheur_RangerBateau", {coordx = spawn_tug.x, coordy = spawn_tug.y, coordz = spawn_tug.z, coordh = spawn_tug.h})
        elseif(v.model == 'benson') then
            Menu.addButton("Ranger la Camionette", "pecheur_RangerCamion", {coordx = spawn_benson.x, coordy = spawn_benson.y, coordz = spawn_benson.z, coordh = spawn_benson.h})
        end
    end
end

function PecheurSpawnCar(result)
    -- RECUPERATION DU MODELE POUR DIFFERENCIER BATEAU ET CAMION
    local vehiculeDetected = GetClosestVehicle(spawn_benson.x, spawn_benson.y, spawn_benson.z, 6.0, 0, 70)
	local id=result.id
	local plateNb = math.random(10000000, 90000000)
	local Prefix= "PECH"
    if(result.model == 'tug') then
		if id < 10 then 
			plateNb = ("00"..id.." "..Prefix)
		elseif id < 100 then 
			plateNb = ("0"..id.." "..Prefix)
		elseif id < 1000 then 
			plateNb = (id.." "..Prefix)
		elseif id<10000  then
			plateNb = (id..Prefix)
		end
        local tug_model = result.model
        result = {model = tug_model, coordx = spawn_tug.x, coordy = spawn_tug.y, coordz = spawn_tug.z, coordh = spawn_tug.h}
        vehiculeDetected = GetTugBoat(spawn_tug.x, spawn_tug.y, spawn_tug.z)
    elseif(result.model == 'benson') then
		if id < 10 then 
			plateNb = (Prefix.." 00"..id)
		elseif id < 100 then 
			plateNb = (Prefix.." 0"..id)
		elseif id < 1000 then 
			plateNb = (Prefix.." "..id)
		elseif id < 10000  then
			plateNb = (Prefix..id)
		end
        local benson_model = result.model
        result = {model = benson_model, coordx = spawn_benson.x, coordy = spawn_benson.y, coordz = spawn_benson.z, coordh= spawn_benson.h}
        vehiculeDetected = GetClosestVehicle(spawn_benson.x, spawn_benson.y, spawn_benson.z, 6.0, 0, 70)
    end
    --
    if not DoesEntityExist(vehiculeDetected) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local myPed = GetPlayerPed(-1)
        local vehicle = GetHashKey(result.model)
		
		
		

        RequestModel(vehicle)
        while not HasModelLoaded(vehicle) do
            Wait(1)
        end
        local existingVeh = CreateVehicle(vehicle, result.coordx, result.coordy, result.coordz, result.coordh, true, false)
	--	if result.model ='tug' then 
			SetVehicleNumberPlateText(existingVeh,plateNb)
	--	else 
	--		SetVehicleNumberPlateText(existingVeh, plateNb.."PECH")
	--	end
        SetVehicleHasBeenOwnedByPlayer(existingVeh, true)
        local id = NetworkGetNetworkIdFromEntity(existingVeh)
        SetNetworkIdCanMigrate(id, true)
        SetEntityInvincible(existingVeh, false)
        SetVehicleOnGroundProperly(existingVeh)
        SetEntityAsMissionEntity(existingVeh, true, true)
        SetVehicleFuelLevel(existingVeh, 100)
        local plate = GetVehicleNumberPlateText(existingVeh)
        --SetPedIntoVehicle(myPed, existingVeh, -1)
        TriggerServerEvent('ls:recevoircles', string.lower(plate), existingVeh)
        Menu.hidden = true
    else
        DisplayHelpText('Zone Encombrée', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        Menu.hidden = true
        Citizen.Wait(2000)
        SetEntityAsMissionEntity(vehiculeDetected, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
    end
end

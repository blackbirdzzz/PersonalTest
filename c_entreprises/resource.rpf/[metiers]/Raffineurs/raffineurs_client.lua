local isInServiceRaffineur = false

local remorque_coords = {x = 1358.4790039063, y = -2078.5981445313, z = 51.998558044434}
local camion_coords = {x = 1370.0805664063, y = -2067.0317382813, z = 52.068954467773}

function isInServiceRaffineurBool()
    return isInServiceRaffineur
end
function GetServiceRaffineur()
    local playerPed = GetPlayerPed(-1)
    if isInServiceRaffineur then
        DisplayHelpText('Fin du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        TriggerServerEvent("skin_customization:SpawnPlayer")
        isInServiceRaffineur = not isInServiceRaffineur
    else
        DisplayHelpText('Début du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        GetSkinRaffineur()
        isInServiceRaffineur = true
    end
end

function GetSkinRaffineur()
    local hashSkin = GetHashKey("mp_m_freemode_01")
    Citizen.CreateThread(function()
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 11, 41, 0, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 7, 0, 2) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 66, 0, 2) -- under skin
        else
            SetPedComponentVariation(GetPlayerPed(-1), 11, 109, 0, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 1, 0, 2) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 45, 2, 2) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 36, 0, 2) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2) -- under skin
        end
    end)
end

function GetVehicleRaffineur(x, y, z, vehicules,PlayerId)
    ClearMenu()
    options.menu_title = "Raffineurs"
    options.menu_subtitle = "Vehicules"
    Menu.selection = 1
    for k, v in pairs(vehicules) do
        Menu.addButton(v.nom, "RaffineurSpawnCar", {model = v.model, coordx = camion_coords.x, coordy = camion_coords.y, coordz = camion_coords.z,id=PlayerId})
    end
end

function RaffineurSpawnCar(result)
    local vehiculeDetected = GetClosestVehicle(result.coordx, result.coordy, result.coordz, 6.0, 0, 70)
    local trailDetected = GetClosestVehicle(remorque_coords.x, remorque_coords.y, remorque_coords.z, 6.0, 0, 70)
    if not DoesEntityExist(vehiculeDetected) and not DoesEntityExist(trailDetected) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        -- CAMION
		local id=result.id
		local plateNb = math.random(10000000, 90000000)
		local Prefix= "RAFF"
		if id < 10 then 
			plateNb = (Prefix.." 00"..id)
		elseif id < 100 then 
			plateNb = (Prefix.." 0"..id)
		elseif id < 1000 then 
			plateNb = (Prefix.." "..id)
		elseif id < 10000  then
			plateNb = (Prefix..id)
		end
        local vehicle = GetHashKey(result.model)
		
        RequestModel(vehicle)
        while not HasModelLoaded(vehicle) do
            Wait(1)
        end
        local existingVeh = CreateVehicle(vehicle, result.coordx, result.coordy, result.coordz, 90.0, true, false)
		SetVehicleNumberPlateText(existingVeh,plateNb)
        SetVehicleHasBeenOwnedByPlayer(existingVeh, true)
        local id = NetworkGetNetworkIdFromEntity(existingVeh)
        SetNetworkIdCanMigrate(id, true)
        SetEntityInvincible(existingVeh, false)
        SetVehicleOnGroundProperly(existingVeh)
        SetEntityAsMissionEntity(existingVeh, true, true)
        SetVehicleFuelLevel(existingVeh, 100)
        local plate = GetVehicleNumberPlateText(existingVeh)
        SetPedIntoVehicle(GetPlayerPed(-1), existingVeh, -1)
        TriggerServerEvent('ls:recevoircles', string.lower(plate), existingVeh)
        --
        -- REMORQUE
        local remorque = GetHashKey('Tanker')
		if id < 10 then 
			plateNb = ("00"..id.." "..Prefix)
		elseif id < 100 then 
			plateNb = ("0"..id.." "..Prefix)
		elseif id < 1000 then 
			plateNb = (id.." "..Prefix)
		elseif id<10000  then
			plateNb = (id..Prefix)
		end
        RequestModel(remorque)
        while not HasModelLoaded(remorque) do
            Wait(1)
        end
        local spawn_remorque = CreateVehicle(remorque, remorque_coords.x, remorque_coords.y, remorque_coords.z, 0.0, true, false)
		SetVehicleNumberPlateText(spawn_remorque,plateNb)
        SetVehicleHasBeenOwnedByPlayer(spawn_remorque, true)
        local id2 = NetworkGetNetworkIdFromEntity(spawn_remorque)
        SetNetworkIdCanMigrate(id2, true)
        SetEntityInvincible(spawn_remorque, false)
        SetVehicleOnGroundProperly(spawn_remorque)
        SetEntityAsMissionEntity(spawn_remorque, true, true)
        --
        Menu.hidden = true
    else
        DisplayHelpText('Zone Encombrée', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        Menu.hidden = true
        Citizen.Wait(2000)
        SetEntityAsMissionEntity(vehiculeDetected, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
    end
end

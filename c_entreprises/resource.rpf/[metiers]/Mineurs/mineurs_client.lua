local isInServiceMineur = false

function isInServiceMineurBool()
    return isInServiceMineur
end
function GetServiceMineur()
    local playerPed = GetPlayerPed(-1)
    if isInServiceMineur then
        DisplayHelpText('Fin du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        TriggerServerEvent("skin_customization:SpawnPlayer")
        isInServiceMineur = not isInServiceMineur
    else
        DisplayHelpText('Début du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        GetSkinMineur()
        isInServiceMineur = true
    end
end

function GetSkinMineur()
    local hashSkin = GetHashKey("mp_m_freemode_01")
    Citizen.CreateThread(function()
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 0, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 0, 12, 2) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 34, 0, 2) -- under skin
        else
            SetPedComponentVariation(GetPlayerPed(-1), 11, 11, 2, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 35, 0, 2) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 26, 0, 2) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2) -- under skin
        end
    end)
end

function GetVehicleMineur(x, y, z, vehicules,PlayerId)
    ClearMenu()
    options.menu_title = "Mineurs"
    options.menu_subtitle = "Vehicules"
    Menu.selection = 1
    for k, v in pairs(vehicules) do
        Menu.addButton(v.nom, "MineurSpawnCar", {model = v.model, coordx = x, coordy = y, coordz = z,id=PlayerId})
    end
end

function MineurSpawnCar(result)
    local vehiculeDetected = GetClosestVehicle(result.coordx, result.coordy, result.coordz, 6.0, 0, 70)
    if not DoesEntityExist(vehiculeDetected) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local myPed = GetPlayerPed(-1)
        local vehicle = GetHashKey(result.model)
		local id=result.id
		local plateNb = math.random(10000000, 90000000)
		local Prefix= "MINE"
		if id < 10 then 
			plateNb = (Prefix.." 00"..id)
		elseif id < 100 then 
			plateNb = (Prefix.." 0"..id)
		elseif id < 1000 then 
			plateNb = (Prefix.." "..id)
		elseif id < 10000  then
			plateNb = (Prefix..id)
		end
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
        SetPedIntoVehicle(myPed, existingVeh, -1)
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

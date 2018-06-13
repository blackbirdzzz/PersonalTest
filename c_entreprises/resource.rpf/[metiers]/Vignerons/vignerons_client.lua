local isInServiceVigneron = false

function isInServiceVigneronBool()
    return isInServiceVigneron
end
function GetServiceVigneron()
    local playerPed = GetPlayerPed(-1)
    if isInServiceVigneron then
        DisplayHelpText('Fin du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        TriggerServerEvent("skin_customization:SpawnPlayer")
        isInServiceVigneron = not isInServiceVigneron
    else
        DisplayHelpText('Début du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        GetSkinVigneron()
        isInServiceVigneron = true
    end
end

function GetSkinVigneron()
    local hashSkin = GetHashKey("mp_m_freemode_01")
    Citizen.CreateThread(function()
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedPropIndex(GetPlayerPed(-1), 0, 13, 0, 2) -- chapo
            SetPedComponentVariation(GetPlayerPed(-1), 11, 95, 0, 2) -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8,57, 0, 2)
            SetPedComponentVariation(GetPlayerPed(-1), 4, 0, 4, 2) -- Pantalon
            SetPedComponentVariation(GetPlayerPed(-1), 6, 15, 10, 2) -- chaussures
            --SetPedComponentVariation(GetPlayerPed(-1), 3, 67, 0, 2)   -- mains/gants/bras etc. ... (shirt)
            SetPedComponentVariation(GetPlayerPed(-1), 3, 26, 0, 2)
        else
			SetPedPropIndex(GetPlayerPed(-1), 0, 20, 2, 2) -- chapo
            SetPedComponentVariation(GetPlayerPed(-1), 11, 9, 0, 2) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 3, 0, 2) -- under coat 73 ?
            SetPedComponentVariation(GetPlayerPed(-1), 4, 25, 0, 2) -- Pantalon
            SetPedComponentVariation(GetPlayerPed(-1), 6, 9, 0, 2) -- chaussures
            SetPedComponentVariation(GetPlayerPed(-1), 3, 28, 0, 2) -- mains/gants/bras etc. ... (shirt)
        end
    end)
end

function GetVehicleVigneron(x, y, z, vehicules,PlayerId)
    ClearMenu()
    options.menu_title = "Vignerons"
    options.menu_subtitle = "Vehicules"
    Menu.selection = 1
    for k, v in pairs(vehicules) do
        Menu.addButton(v.nom, "VigneronSpawnCar", {model = v.model, coordx = x, coordy = y, coordz = z,id=PlayerId})
    end
end

function VigneronSpawnCar(result)
    local vehiculeDetected = GetClosestVehicle(result.coordx, result.coordy, result.coordz, 6.0, 0, 70)

	local id=result.id
	local plateNb = math.random(10000000, 90000000)
	local Prefix= "VIGN"
	if id < 10 then
		plateNb = (Prefix.." 00"..id)
	elseif id < 100 then
		plateNb = (Prefix.." 0"..id)
	elseif id < 1000 then
		plateNb = (Prefix.." "..id)
	elseif id < 10000  then
		plateNb = (Prefix..id)
	end

    if not DoesEntityExist(vehiculeDetected) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local myPed = GetPlayerPed(-1)
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

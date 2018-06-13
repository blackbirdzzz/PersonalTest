local isInServiceFermier = false

function isInServiceFermierBool()
    return isInServiceFermier
end
function GetServiceFermier()
    local playerPed = GetPlayerPed(-1)
    if isInServiceFermier then
        DisplayHelpText('Fin du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        TriggerServerEvent("skin_customization:SpawnPlayer")
        isInServiceFermier = not isInServiceFermier
    else
        DisplayHelpText('Début du service', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        GetSkinFermier()
        isInServiceFermier = true
    end
end

function GetSkinFermier()
    local hashSkin = GetHashKey("mp_m_freemode_01")
    Citizen.CreateThread(function()
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 11, 56, 0, 0) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 0) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 90, 0, 0) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 66, 2, 0) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0) -- under skin
        else
            SetPedComponentVariation(GetPlayerPed(-1), 11, 171, 1, 0) -- Top
            SetPedComponentVariation(GetPlayerPed(-1), 8, 6, 0, 0) -- under coat
            SetPedComponentVariation(GetPlayerPed(-1), 4, 4, 12, 0) -- Pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 3, 0, 0) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 0) -- under skin
        end
    end)
end

function GetVehicleFermier(x, y, z, vehicules,PlayerId)
    ClearMenu()
    options.menu_title = "Fermiers"
    options.menu_subtitle = "Vehicules"
    Menu.selection = 1
    for k, v in pairs(vehicules) do
        Menu.addButton(v.nom, "FermierSpawnCar", {model = v.model, coordx = x, coordy = y, coordz = z,id=PlayerId})
    end
    Menu.addButton("Supprimer le Camion", "SupprimerCamionFermier", {coordx = x, coordy = y, coordz = z})
end

function SupprimerCamionFermier(result)
    local vehiculeDetected = GetClosestVehicle(result.coordx, result.coordy, result.coordz, 6.0, 0, 70)
    if DoesEntityExist(vehiculeDetected) then
        SetEntityAsMissionEntity(vehiculeDetected, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehiculeDetected))
        DisplayHelpText('Véhicule supprimé', 0, 1, 0.5, 0.8, 0.6, 155, 105, 95, 255)
        Menu.hidden = true
        Citizen.Wait(2000)
    end
end

function FermierSpawnCar(result,PlayerId)
    local vehiculeDetected = GetClosestVehicle(result.coordx, result.coordy, result.coordz, 6.0, 0, 70)
    if not DoesEntityExist(vehiculeDetected) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local myPed = GetPlayerPed(-1)
        local vehicle = GetHashKey(result.model)
		local id=result.id
		local plateNb = math.random(10000000, 90000000)
		local Prefix= "FERM"
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

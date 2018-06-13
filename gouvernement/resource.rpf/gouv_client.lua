-- Decor
DecorRegister("_gouv", 2)

IsInService = false
local MissionStatus = TEXT.NO_INFO
local listMissions = {}
local currentMission = nil
local call_accept = 0
local nbStaffInService = 0
local nbStaffAvailable = 0
local markerBool = false
local blipsTemp
existingVeh = nil
haveOutfit = false
isGouverneur = false -- true pour désactiver l'obligation du vestiaire

	-- VEHICLE MENU INIT --
heliMenu = Menu.new("Hélicoptères", TEXT.HELP_MENU, 0.15, 0.14, 0.28, 0.4, 0)
heliMenu.config.pcontrol = false
heliMenu:addButton("Whitehawk", TEXT.VEH_WHITEHAWK)
heliMenu:addButton(TEXT.STOW_HELI, TEXT.STOW)

garageMenu = Menu.new("Vehicules de service", TEXT.HELP_MENU, 0.15, 0.14, 0.28, 0.4, 0)
garageMenu.config.pcontrol = false
garageMenu:addButton("Onebeast", TEXT.VEH_ONEBEAST)
garageMenu:addButton("Escalade", TEXT.VEH_ESCALADE)
garageMenu:addButton(TEXT.STOW_VEH, TEXT.STOW)

parkingMenu = Menu.new("Vehicules de service", TEXT.HELP_MENU, 0.15, 0.14, 0.28, 0.4, 0)
parkingMenu.config.pcontrol = false
parkingMenu:addButton("Escalade", TEXT.VEH_ESCALADE)
parkingMenu:addButton(TEXT.STOW_VEH, TEXT.STOW)

hangarMenu = Menu.new("Avions", TEXT.HELP_MENU, 0.15, 0.14, 0.28, 0.4, 0)
hangarMenu.config.pcontrol = false
hangarMenu:addButton("Luxor", TEXT.VEH_LUXOR)
hangarMenu:addButton(TEXT.STOW_AVION, TEXT.STOW)


	-- VEHICLE MENU --
function parkingMenu:onButtonSelected(name,btn)
	if name == "Escalade" then
		spawnVehicle(spawn.parking, "escalade")
	elseif name == TEXT.STOW_VEH then
		deleteVeh()
	end
	parkingMenu:Close()
end

function heliMenu:onButtonSelected(name,btn)
	if name == "Whitehawk" then
		spawnVehicle(spawn.helipad, "whitehawk")
	elseif name == TEXT.STOW_HELI then
		deleteVeh()
	end
	heliMenu:Close()
end

function garageMenu:onButtonSelected(name,btn)
	if name == "Onebeast" then
		spawnVehicle(spawn.garage, "onebeast")
	elseif name == "Escalade" then
		spawnVehicle(spawn.garage, "escalade")
	elseif name == TEXT.STOW_VEH then
		deleteVeh()
	end
	garageMenu:Close()
end

function hangarMenu:onButtonSelected(name,btn)
	if name == "Luxor" then
		spawnVehicle(spawn.hangar, "luxor3")
	elseif name == TEXT.STOW_AVION then
		deleteVeh()
	end
	heliMenu:Close()
end

	-- VEH --

function vehicleBlip(vehEntity)
	local ped = GetPlayerPed(-1)
	if GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehEntity)) > 1.0 then
		SetBlipSprite(blipveh, 195)
	end
	if not IsVehicleDriveable(vehEntity, 0) then
		SetBlipSprite(blipveh, 195)
	end
end

function deleteVeh()
    if vehEntity ~= nil then
        local plate = GetVehicleNumberPlateText(vehEntity)
        DeleteVehicle(vehEntity)
        vehEntity = nil
		ShowNotif(TEXT.VEH_DESPAWN)
    end
end

function spawnVehicle(pos, type)
	local ped = GetPlayerPed(-1)
	local pedpos = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pedpos.x, pedpos.y, pedpos.z, 5.0, 0, 70)
    if DoesEntityExist(veh) then
		ShowNotif(TEXT.VEH_SPAWN_IMPOSSIBLE)
	else
        RequestModel(type)
        while not HasModelLoaded(type) do
            Wait(10)
        end
        local plate = math.random(100, 900)
        vehEntity = CreateVehicle(type, pos.x, pos.y, pos.z, pos.h, true, false)
		DecorSetBool(vehEntity, "_gouv", true)
		local blipveh = AddBlipForEntity(vehEntity)
		local class = GetVehicleClass(vehEntity)
		if type == "onebeast" or type == "escalade" then
			SetBlipSprite(blipveh, 225)
		elseif class == 15 then
			SetBlipSprite(blipveh, 43)
		elseif class == 16 then
			SetBlipSprite(blipveh, 90)
		else
			SetBlipSprite(blipveh, 225) -- default
		end
        SetVehicleNumberPlateText(vehEntity, TEXT.PLATE .. plate)
        SetVehicleOnGroundProperly(vehEntity)
		SetEntityAsMissionEntity(vehEntity, true, true)
		plate = GetVehicleNumberPlateText(vehEntity)
		TriggerServerEvent("ls:refreshid", plate, vehEntity)
        local ObjectId = NetworkGetNetworkIdFromEntity(vehEntity)
        SetNetworkIdExistsOnAllMachines(ObjectId, true)
        local p = GetEntityCoords(vehEntity, 0)
        local h = GetEntityHeading(vehEntity)
        SetModelAsNoLongerNeeded(type)
		ShowNotif(TEXT.VEH_SPAWN)
        return
	end
end

	-- OUTFIT MENU INIT --
outfitMenu = Menu.new("Tenues de travail", TEXT.HELP_MENU, 0.15, 0.14, 0.28, 0.4, 0)
outfitMenu.config.pcontrol = false
outfitMenu:addButton("Gouverneur", TEXT.OUTFIT_GOVERNOR)
outfitMenu:addButton("Garde du corps", TEXT.OUTFIT_BODYGUARD)

	-- OUTFIT MENU --
function reset_skin(ped)
	SetPedDefaultComponentVariation(ped)
	ClearAllPedProps(ped)
	TriggerServerEvent('skin:reloadSkin')
end

function outfitMenu:onButtonSelected(name,btn)
	local ped = GetPlayerPed(-1)
	--if (GetEntityModel(ped) == "mp_m_freemode_01") then
		if name == "Gouverneur" then
			reset_skin(ped)
			SetPedPropIndex(ped, 0, 27, 3, 2) 			-- Chapeau haut de forme
			SetPedComponentVariation(ped, 3, 1, 0, 2)   -- Bras
			SetPedComponentVariation(ped, 4, 22, 0, 2)  -- Pantalon
			SetPedComponentVariation(ped, 6, 40, 4, 2)  -- Chaussures
			SetPedComponentVariation(ped, 7, 22, 4, 2) 	-- Cravate
			SetPedComponentVariation(ped, 8, 26, 0, 2)  -- Chemise
			SetPedComponentVariation(ped, 11,24, 0, 2)	-- Veste
			haveOutfit = true
			ShowNotif(TEXT.CONFIRM_OUTFIT_CHANGE)
		elseif name == "Garde du corps" then
			reset_skin(ped)
			SetPedPropIndex(ped, 1, 5, 4, 2) 			-- Rayban miroir
			SetPedPropIndex(ped, 2, 0, 0, 2) 			-- Oreillette Bluetooth
			SetPedComponentVariation(ped, 3, 1, 0, 2)  	-- Mains
			SetPedComponentVariation(ped, 4, 25, 0, 2) 	-- Pantalon
			SetPedComponentVariation(ped, 6, 10, 0, 2)  -- Chaussures
			SetPedComponentVariation(ped, 7, 28, 4, 2)  -- Cravate
			SetPedComponentVariation(ped, 8, 31, 0, 2) 	-- Chemise
			SetPedComponentVariation(ped, 11, 32, 0, 2) -- Veste
			haveOutfit = true
			ShowNotif(TEXT.CONFIRM_OUTFIT_CHANGE)
		elseif name == "Tenue d'origine" then
			reset_skin(ped)
			TriggerServerEvent("skin_customization:SpawnPlayer")
			haveOutfit = false
			ShowNotif(TEXT.CONFIRM_OUTFIT_ORIGIN)
		end
	--elseif (GetEntityModel(ped) == "mp_f_freemode_01") then
	--end
	outfitMenu:Close()
end

	-- JOB CHECK --
AddEventHandler("playerSpawned", function()
  TriggerServerEvent("Gouverneur:checkIsGouverneur")
end)

RegisterNetEvent('Gouverneur:receiveIsGouverneur')
AddEventHandler('Gouverneur:receiveIsGouverneur', function(result)
  if (result == '0') then
    isGouverneur = false
  else
    isGouverneur = true
  end
end)

	-- GESTION SERVICE --
function toogleService()
    IsInService = not IsInService
    if IsInService then
        TriggerServerEvent('Gouverneur:takeService')
        TriggerServerEvent('Gouverneur:requestMission')
		TriggerServerEvent('Gouverneur:setService', true)
		ShowNotif(TEXT.CONFIRM_START_SERVICE)
    else
        TriggerServerEvent('Gouverneur:endService')
		TriggerServerEvent('Gouverneur:setService', false)
		ShowNotif(TEXT.CONFIRM_STOP_SERVICE)
    end
end

function gestionService()
	local ped = GetPlayerPed(-1)
	local pedpos = GetEntityCoords(ped)
    if GetDistanceBetweenCoords(pedpos, blips[TEXT.OFFICE].x, blips[TEXT.OFFICE].y, blips[TEXT.OFFICE].z, true) <= blips[TEXT.OFFICE].d then
        ShowMarker(blips[TEXT.OFFICE].x, blips[TEXT.OFFICE].y, blips[TEXT.OFFICE].z, blips[TEXT.OFFICE].r, 255, 224, 51)
		Show3DText(blips[TEXT.OFFICE].x, blips[TEXT.OFFICE].y, blips[TEXT.OFFICE].z, TEXT.OFFICE)
		if GetDistanceBetweenCoords(pedpos, blips[TEXT.OFFICE].x, blips[TEXT.OFFICE].y, blips[TEXT.OFFICE].z, true) <= blips[TEXT.OFFICE].a then
			if IsInService then
				ShowHelp(TEXT.START_SERVICE)
			else
				ShowHelp(TEXT.STOP_SERVICE)
			end
			if IsControlJustPressed(1, KEY.E) then
				if haveOutfit == false then
					ShowNotif(TEXT.OUTFIT_MANDATORY)
				else
					toogleService()
				end
			end
		end
    end
	if GetDistanceBetweenCoords(pedpos, blips[TEXT.OUTFIT].x, blips[TEXT.OUTFIT].y, blips[TEXT.OUTFIT].z, true) <= blips[TEXT.OUTFIT].d then
		ShowMarker(blips[TEXT.OUTFIT].x, blips[TEXT.OUTFIT].y, blips[TEXT.OUTFIT].z, blips[TEXT.OUTFIT].r, 124, 96, 210)
		Show3DText(blips[TEXT.OUTFIT].x, blips[TEXT.OUTFIT].y, blips[TEXT.OUTFIT].z, TEXT.OUTFIT)
		if GetDistanceBetweenCoords(pedpos, blips[TEXT.OUTFIT].x, blips[TEXT.OUTFIT].y, blips[TEXT.OUTFIT].z, true) <= blips[TEXT.OUTFIT].a then
			if not IsControlJustPressed(1, KEY.E) then
				ShowHelp(TEXT.PICKUP_OUTFIT)
			elseif IsControlJustPressed(1, KEY.E) then
				if GetDistanceBetweenCoords(pedpos, blips[TEXT.OUTFIT].x, blips[TEXT.OUTFIT].y, blips[TEXT.OUTFIT].z, true) <= blips[TEXT.OUTFIT].d then
					outfitMenu:Close()
				end
				outfitMenu:Open()
				ShowHelp(TEXT.INFO_MENU)
				Citizen.Wait(2000)
			end
			if IsControlJustPressed(1, KEY.BACKSPACE) then
				--FreezeEntityPosition(ped, false)
				outfitMenu:Close()
			end
		end
	end
	if IsInService then
        if GetDistanceBetweenCoords(pedpos, blips[TEXT.GARAGE].x, blips[TEXT.GARAGE].y, blips[TEXT.GARAGE].z, true) <= blips[TEXT.GARAGE].d then
            ShowMarker(blips[TEXT.GARAGE].x, blips[TEXT.GARAGE].y, blips[TEXT.GARAGE].z, blips[TEXT.GARAGE].r, 242, 135, 64)
			Show3DText(blips[TEXT.GARAGE].x, blips[TEXT.GARAGE].y, blips[TEXT.GARAGE].z, TEXT.GARAGE)
			if GetDistanceBetweenCoords(pedpos, blips[TEXT.GARAGE].x, blips[TEXT.GARAGE].y, blips[TEXT.GARAGE].z, true) <= blips[TEXT.GARAGE].a then
				if not IsControlJustPressed(1, KEY.E) then
					ShowHelp(TEXT.PICKUP_GARAGE)
				elseif IsControlJustPressed(1, KEY.E) then
					--FreezeEntityPosition(ped, true)
					garageMenu:Open()
					ShowHelp(TEXT.INFO_MENU)
					Citizen.Wait(2000)
				end
				if IsControlJustPressed(1, KEY.BACKSPACE) or IsControlJustPressed(1, KEY.ENTER) then
					--FreezeEntityPosition(ped, false)
					garageMenu:Close()
				end
			end
        end
		if GetDistanceBetweenCoords(pedpos, blips[TEXT.PARKING].x, blips[TEXT.PARKING].y, blips[TEXT.PARKING].z, true) <= blips[TEXT.GARAGE].d then
			ShowMarker(blips[TEXT.PARKING].x, blips[TEXT.PARKING].y, blips[TEXT.PARKING].z, blips[TEXT.PARKING].r, 0, 128, 224)
			Show3DText(blips[TEXT.PARKING].x, blips[TEXT.PARKING].y, blips[TEXT.PARKING].z, TEXT.PARKING)
			if GetDistanceBetweenCoords(pedpos, blips[TEXT.PARKING].x, blips[TEXT.PARKING].y, blips[TEXT.PARKING].z, true) <= blips[TEXT.GARAGE].a then
				if not IsControlJustPressed(1, KEY.E) then
					ShowHelp(TEXT.PICKUP_PARKING)
				elseif IsControlJustPressed(1, KEY.E) then
					--FreezeEntityPosition(ped, true)
					parkingMenu:Open()
					ShowHelp(TEXT.INFO_MENU)
					Citizen.Wait(2000)
				end
				if IsControlJustPressed(1, KEY.BACKSPACE) or IsControlJustPressed(1, KEY.ENTER) then
					--FreezeEntityPosition(ped, false)
					parkingMenu:Close()
				end
			end
		end
		if GetDistanceBetweenCoords(pedpos, blips[TEXT.HELIPAD].x, blips[TEXT.HELIPAD].y, blips[TEXT.HELIPAD].z, true) <= blips[TEXT.GARAGE].d then
			ShowMarker(blips[TEXT.HELIPAD].x, blips[TEXT.HELIPAD].y, blips[TEXT.HELIPAD].z, blips[TEXT.HELIPAD].r, 50, 227, 4)
			Show3DText(blips[TEXT.HELIPAD].x, blips[TEXT.HELIPAD].y, blips[TEXT.HELIPAD].z, TEXT.HELIPAD)
			if GetDistanceBetweenCoords(pedpos, blips[TEXT.HELIPAD].x, blips[TEXT.HELIPAD].y, blips[TEXT.HELIPAD].z, true) <= blips[TEXT.GARAGE].a then
				if not IsControlJustPressed(1, KEY.E) then
					ShowHelp(TEXT.PICKUP_HELI)
				elseif IsControlJustPressed(1, KEY.E) then
					--FreezeEntityPosition(ped, true)
					heliMenu:Open()
					ShowHelp(TEXT.INFO_MENU)
					Citizen.Wait(2000)
				end
				if IsControlJustPressed(1, KEY.BACKSPACE) or IsControlJustPressed(1, KEY.ENTER) then
					--FreezeEntityPosition(ped, false)
					heliMenu:Close()
				end
			end
		end
		if GetDistanceBetweenCoords(pedpos, blips[TEXT.HANGAR].x, blips[TEXT.HANGAR].y, blips[TEXT.HANGAR].z, true) <= blips[TEXT.GARAGE].d then
			ShowMarker(blips[TEXT.HANGAR].x, blips[TEXT.HANGAR].y, blips[TEXT.HANGAR].z, blips[TEXT.HANGAR].r, 0, 31, 215)
			Show3DText(blips[TEXT.HANGAR].x, blips[TEXT.HANGAR].y, blips[TEXT.HANGAR].z, TEXT.HANGAR)
			if GetDistanceBetweenCoords(pedpos, blips[TEXT.HANGAR].x, blips[TEXT.HANGAR].y, blips[TEXT.HANGAR].z, true) <= blips[TEXT.GARAGE].a then
				if not IsControlJustPressed(1, KEY.E) then
					ShowHelp(TEXT.PICKUP_HANGAR)
				elseif IsControlJustPressed(1, KEY.E) then
					--FreezeEntityPosition(ped, true)
					hangarMenu:Open()
					ShowHelp(TEXT.INFO_MENU)
					Citizen.Wait(2000)
				end
				if IsControlJustPressed(1, KEY.BACKSPACE) or IsControlJustPressed(1, KEY.ENTER) then
					--FreezeEntityPosition(ped, false)
					hangarMenu:Close()
				end
			end
		end
    end
end

	-- SYSTEME D'APPELS --
function jobsSystemGouverneur()
	local ped = GetPlayerPed(-1)
    if currentMission == nil then
        return
    end
    RemoveBlip(blip_currentMission)
    local clientPed = GetPlayerPed(GetPlayerFromServerId(currentMission.id));
     local posClient = currentMission.positionBackUp
    if clientPed ~= nil and clientPed~= 0 and clientPed ~= ped then
        posClient = GetEntityCoords(clientPed)
    end
    blip_currentMission = AddBlipForCoord(posClient.x, posClient.y, posClient.z)
	SetBlipAsShortRange(blip_currentMission, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Appel")
	EndTextCommandSetBlipName(blip_currentMission)
    local pedpos = GetEntityCoords(ped)
    local dist = GetDistanceBetweenCoords(mypos, posClient.x, posClient.y, posClient.z, false)
	if dist < 13.0 then
        DrawMarker(1, posClient.x, posClient.y, 0.0 , 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 350.0, 0, 155, 255, 64, 0, 0, 0, 0)
    end
    if dist < 3.0 then
        finishMission()
    end
end

function startMission(missions)
    currentMission = missions
    local posClient = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(currentMission.id)))
    SetNewWaypoint(posClient.x, posClient.y)
end

function finishMission()
    TriggerServerEvent('Gouverneur:FinishMission', currentMission.id)
    RemoveBlip(blip_currentMission)
    currentMission = nil
end

	-- INFO WINDOWS --
function showInfoClient()
    if call_accept ~= 0 then
        local offsetX = 0.87
        local offsetY = 0.22
        DrawRect(offsetX, offsetY, 0.23, 0.035, 0, 0, 0, 215)
        SetTextFont(1)
        SetTextScale(0.0,0.5)
        SetTextCentre(true)
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        if call_accept == 1 then
            AddTextComponentString(TEXT.CALL_INFO_OK)
        else
            if nbStaffInService == 0 then
                AddTextComponentString(TEXT.CALL_INFO_NO_PERSONNEL)
            elseif nbStaffAvailable == 0 then
                AddTextComponentString(TEXT.CALL_INFO_ALL_BUSY)
            else
                AddTextComponentString(TEXT.CALL_INFO_WAIT)
            end
        end
        DrawText(offsetX, offsetY - 0.015 )
    end
end

function showInfoJobs()
    local offsetX = 0.9
    local offsetY = 0.280
    DrawRect(offsetX, offsetY, 0.15, 0.07, 0, 0, 0, 215)
    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString('~o~Gouverneur Info')
    DrawText(offsetX, offsetY - 0.03)
    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(MissionStatus)
    DrawText(offsetX - 0.065, offsetY -0.002)
end

	-- MAIN --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
		local statusHUD = exports["Players"]:getStatusHUD()
	    if isGouverneur then
    	    gestionService()
        	jobsSystemGouverneur()
            if IsInService and not statusHUD then
                showInfoJobs()
			end
		end
	    if call_accept ~= 0  and not statusHUD then
    	    showInfoClient()
		end
	end
end)

	-- INITIALISATION --
RegisterNetEvent('Gouverneur:drawMarker')
AddEventHandler('Gouverneur:drawMarker', function(boolean)
	isGouverneur = boolean
	IsInService = false
end)

RegisterNetEvent('Gouverneur:drawBlips')
AddEventHandler('Gouverneur:drawBlips', function()
	for key, item in pairs(blips) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(key)
		EndTextCommandSetBlipName(item.blip)
	end
	blipsTemp = blips
end)

RegisterNetEvent('Gouverneur:marker')
AddEventHandler('Gouverneur:marker', function()
end)

RegisterNetEvent('Gouverneur:deleteBlips')
AddEventHandler('Gouverneur:deleteBlips', function()
	isGouverneur = false
	TriggerServerEvent('Gouverneur:endService')
	--[[for _, item in pairs(blipsTemp) do
		RemoveBlip(item.blip)
	end]]--
end)

	-- MISSIONS --
function acceptMission(data)
    local mission = data.mission
    TriggerServerEvent('Gouverneur:AcceptMission', mission.id)
end

function needGouverneur(type)
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	TriggerServerEvent('Gouverneur:Call', type, {x = pos.x, y = pos.y, z = pos.z})
end

RegisterNetEvent("Gouverneur:PersonnelMessage")
AddEventHandler("Gouverneur:PersonnelMessage", function(message)
    if IsInService then
        ShowNotif(message)
    end
end)

RegisterNetEvent("Gouverneur:ClientMessage")
AddEventHandler("Gouverneur:ClientMessage", function(message)
    ShowNotif(message)
end)

function updateMenuMission()
    local items = {}
    local ped = GetPlayerPed(-1)
	local pedpos = GetEntityCoords(ped)

    for _,m in pairs(listMissions) do
		local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(m.id), 0))
        local item = {
            Title = m.type .. ' ' .. m.id .. ' (' .. math.floor(GetDistanceBetweenCoords(pedpos, targetCoords["x"], targetCoords["y"], targetCoords["z"], true)) .. 'm)',
            mission = m,
            Function = acceptMission
        }
        if #m.acceptBy ~= 0 then
            item.Title = item.Title .. ' (En cours)'
            item.TextColor = {39, 174, 96, 255}
        end
        table.insert(items, item)
    end
    if currentMission ~= nil then
        table.insert(items, {['Title'] = TEXT.MISSION_ABANDON, ['Function'] = finishMission})
    end
    table.insert(items, {['Title'] = 'Prendre une caméra', ['Function'] = posercamera})
    table.insert(items, {['Title'] = TEXT.CLOSE})
    updateMenu(items)
end

RegisterNetEvent('Gouverneur:MissionAccept')
AddEventHandler('Gouverneur:MissionAccept', function(mission)
    startMission(mission)
end)

RegisterNetEvent('Gouverneur:MissionChange')
AddEventHandler('Gouverneur:MissionChange', function(missions)
    if not IsInService then
        return
    end
    listMissions = missions
    local nbMissonPending = 0
    for _,m in pairs(listMissions) do
		if #m.acceptBy == 0 then
            nbMissonPending = nbMissonPending + 1
        end
    end
    if nbMissonPending == 0 then
        MissionStatus = TEXT.NO_PENDING_CALL
    else
        MissionStatus = '~g~ ' .. nbMissonPending .. ' ' .. TEXT.CALL_PENDING
    end
    updateMenuMission()
end)

RegisterNetEvent('Gouverneur:openMenu')
AddEventHandler('Gouverneur:openMenu', function()
	if IsInService then
		TriggerServerEvent('Gouverneur:requestMission')
		openMenuGeneralGouverneur()
	else
        ShowNotif(TEXT.NEED_IN_SERVICE)
    end
end)

RegisterNetEvent('Gouverneur:callGouverneur')
AddEventHandler('Gouverneur:callGouverneur',function(data)
    needGouverneur(data.type)
end)

RegisterNetEvent('Gouverneur:callStatus')
AddEventHandler('Gouverneur:callStatus',function(status)
    call_accept = status
end)

RegisterNetEvent('Gouverneur:personnelChange')
AddEventHandler('Gouverneur:personnelChange',function(nbStaff, nbAvailable)
    nbStaffInService = nbStaff
    nbStaffAvailable = nbAvailable
end)

RegisterNetEvent('Gouverneur:cancelCall')
AddEventHandler('Gouverneur:cancelCall', function(data)
    TriggerServerEvent('Gouverneur:cancelCall')
end)

RegisterNetEvent('Gouverneur:selfRespawn')
AddEventHandler('Gouverneur:selfRespawn', function()
    TriggerServerEvent('Gouverneur:askSelfRespawn')
end)

TriggerServerEvent('Gouverneur:requestPersonnel')
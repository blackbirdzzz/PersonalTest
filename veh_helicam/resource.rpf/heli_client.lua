-- CE SCRIPT EST A REFAIRE ENTIEREMENT CEST UN BEAU BORDEL -Tango

local helicam = false
local polmav_hash = GetHashKey("polmav")
local buzzard2_hash = GetHashKey("buzzard2")
local helinews_hash = GetHashKey("helinews")
local helinews2_hash = GetHashKey("helinews2")
local frogger_hash = GetHashKey("frogger")
local frogger2_hash = GetHashKey("frogger2")
local frogger6_hash = GetHashKey("frogger6")
local fov = (fov_max+fov_min)*0.5
local vision_state = 1 -- 0 is normal, 1 is nightmode, 2 is thermal vision
local lsdp = false
local news = false
local scaleform = nil

function IsPlayerInHeliModel(hash)
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped)
	return IsVehicleModel(vehicle, hash)
end

-- News
local firstline = ""
local secondline = ""
local thirdline = ""

function loadBreakBanner()
	local scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(secondline)
	PushScaleformMovieFunctionParameterString(thirdline)
	PopScaleformMovieFunctionVoid()
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(firstline)
	PopScaleformMovieFunctionVoid()
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()

	SetTimecycleModifier("heliGunCam")
	SetTimecycleModifierStrength(0.3)

	return scaleform
end

function StartSettingsBreakBanner()
	--
	AddTextEntry('FT_TEXT', "Entrer la première phrase en haut de la bannière")
	DisplayOnscreenKeyboard(false, "FT_TEXT", "", firstline, "", "", "", 64)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		firstline = GetOnscreenKeyboardResult()
	end
	--
	AddTextEntry('FT_TEXT', "Entrer la seconde phrase au milieu de la bannière")
	DisplayOnscreenKeyboard(false, "FT_TEXT", "", secondline, "", "", "", 64)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		secondline = GetOnscreenKeyboardResult()
	end
	--
	AddTextEntry('FT_TEXT', "Entrer la troisième phrase en bas de la bannière")
	DisplayOnscreenKeyboard(false, "FT_TEXT", "", thirdline, "", "", "", 64)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		thirdline = GetOnscreenKeyboardResult()
	end
	return loadBreakBanner()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsPlayerInHeliModel(polmav_hash) or IsPlayerInHeliModel(buzzard2_hash) or IsPlayerInHeliModel(helinews_hash) or
		IsPlayerInHeliModel(helinews2_hash) or IsPlayerInHeliModel(frogger_hash) or IsPlayerInHeliModel(frogger2_hash) or IsPlayerInHeliModel(frogger6_hash) then

			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)
			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0, toggle_helicam) and GetLastInputMethod(2) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = true
					exports["Players"]:setStatusHUD(true)

					if DecorExistOn(heli, "_lspd") then
						lspd = DecorGetBool(heli, "_lspd")
					else
						lspd = false
					end

					if DecorExistOn(heli, "_news") then
						news = DecorGetBool(heli, "_news")
					else
						news = false
					end

				end
				showHelpMessage("~INPUT_CONTEXT~ Camera\n~INPUT_CELLPHONE_CAMERA_GRID~ Projecteur\n~INPUT_PARACHUTE_SMOKE~ Rappel")
				if IsControlJustPressed(0, toggle_rappel) and GetLastInputMethod(2) and IsPlayerInHeliModel(polmav_hash) then -- Initiate rappel
					if GetPedInVehicleSeat(heli, 1) == lPed or GetPedInVehicleSeat(heli, 2) == lPed then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						TaskRappelFromHeli(GetPlayerPed(-1), 1)
					else
						SetNotificationTextEntry( "STRING" )
						AddTextComponentString("~r~Impossible de procéder a une descente en rappel depuis ce siège.")
						DrawNotification(false, false )
						PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
					end
				end

			end

			if (IsControlJustPressed(0, toggle_spotlight) and GetLastInputMethod(2)) and GetPedInVehicleSeat(heli, -1) == lPed then
				spotlight_state = not spotlight_state
				TriggerServerEvent("heli:spotlight", spotlight_state)
				PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
			end

		elseif IsPlayerInHeliModel(polmav_hash) or IsPlayerInHeliModel(buzzard2_hash) or IsPlayerInHeliModel(helinews_hash) or
		IsPlayerInHeliModel(helinews2_hash) or IsPlayerInHeliModel(frogger_hash) or IsPlayerInHeliModel(frogger2_hash) or IsPlayerInHeliModel(frogger6_hash) then

			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)

			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0, toggle_helicam) and GetLastInputMethod(2) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = true
					exports["Players"]:toogleHud(true)
				end
			end
		end
		if helicam then

			if not news then
				scaleform = RequestScaleformMovie("HELI_CAM")
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(0)
				end

				if lspd then
					PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
					PushScaleformMovieFunctionParameterInt(1) -- 0 for nothing, 1 for LSPD logo
					SetTimecycleModifier("heliGunCam")
					SetTimecycleModifierStrength(0.3)
				else
					PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
				end
			else
				scaleform = loadBreakBanner()
			end

			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
			AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
			SetCamRot(cam, 0.0, 0.0, GetEntityHeading(heli))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)

			PopScaleformMovieFunctionVoid()
			local locked_on_vehicle = nil
			if lspd then
				showHelpMessage("\n~INPUT_VEH_JUMP~ Suivre véhicule\n~INPUT_AIM~ Mode de vue")
			elseif news then
				showHelpMessage("~INPUT_VEH_JUMP~ Suivre véhicule\n~INPUT_AIM~ Mode de vue\n~INPUT_CHARACTER_WHEEL~ Changer le texte")
			end

			while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(0, toggle_helicam) and GetLastInputMethod(2) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = false
				end
				if (IsControlJustPressed(0, toggle_vision) and GetLastInputMethod(2)) and (lspd or news) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ChangeVision()
				end

				if news then
					if IsControlJustPressed(0, 19) and GetLastInputMethod(2) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						StartSettingsBreakBanner()
					end
				end

				if locked_on_vehicle then
					if DoesEntityExist(locked_on_vehicle) then
						PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
						if lspd then
							RenderVehicleInfo(locked_on_vehicle)
						end
						if IsControlJustPressed(0, toggle_lock_on) and GetLastInputMethod(2) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							locked_on_vehicle = nil
							local rot = GetCamRot(cam, 2) -- All this because I can't seem to get the camera unlocked from the entity
							local fov = GetCamFov(cam)
							local old cam = cam
							DestroyCam(old_cam, false)
							cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
							AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
							SetCamRot(cam, rot, 2)
							SetCamFov(cam, fov)
							RenderScriptCams(true, false, 0, 1, 0)
						end
					else
						locked_on_vehicle = nil -- Cam will auto unlock when entity doesn't exist anyway
					end
				else
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)

					local entity_detected = GetVehicleInView(cam)
					if DoesEntityExist(entity_detected) then
						if lspd then
							RenderVehicleInfo(entity_detected)
						end
						if IsControlJustPressed(0, toggle_lock_on) and GetLastInputMethod(2) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							locked_on_vehicle = entity_detected
						end
					end
				end
				HandleZoom(cam)
				PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam, 2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(10)
			end
			helicam = false
			exports["Players"]:setStatusHUD(false)
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5 -- reset to starting zoom level
			RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
			SetScaleformMovieAsNoLongerNeeded(scaleform) -- Cleanly release the scaleform
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

RegisterNetEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(serverID, state)
	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	SetVehicleSearchlight(heli, state, false)
	Citizen.Trace("Set heli light state to "..tostring(state).." for serverID: "..serverID)
end)

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end

function ChangeVision()
	if lspd then
		if vision_state == 0 then
			SetNightvision(true)
			vision_state = 1
		elseif vision_state == 1 then
			SetNightvision(false)
			vision_state = 2
		else
			SetSeethrough(false)
			vision_state = 0
		end
	elseif news then
		if vision_state == 0 then
			vision_state = 1
			loadBreakBanner()
		elseif vision_state == 1 then
			ClearTimecycleModifier()
			vision_state = 2
		else
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			vision_state = 0
		end
	end
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) and GetLastInputMethod(2) then -- Scrollup
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0,242) and GetLastInputMethod(2) then
		fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(GetPlayerPed(-1)), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	return entityHit
end

function RenderVehicleInfo(vehicle)
	if vehicle > 0 and IsEntityAVehicle(vehicle) then
		local model = GetEntityModel(vehicle)
		local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
		local licenseplate = GetVehicleNumberPlateText(vehicle)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.55)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("Model: "..vehname.."\nPlate: "..licenseplate)
		DrawText(0.45, 0.9)
	end
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

function showHelpMessage(message)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(message)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end
-- FiveM Heli Cam by mraes
-- Version 1.3 2017-06-12

--CONFIG--
local fov_max = 80.0
local fov_min = 10.0
local zoomspeed = 2.0 -- camera zoom speed
local speed_lr = 3.0 -- speed by which the camera pans left-right 
local speed_ud = 3.0 -- speed by which the camera pans up-down

local incamera = false
local fov = (fov_max+fov_min)*0.5
local vision_state = 1 -- 0 is normal, 1 is nightmode, 2 is thermal vision
local scaleform = nil
local Camera = nil

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

--THREADS--
local cameraactive=false
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
        if cameraactive then
        	if IsControlJustPressed(0, 51) and GetLastInputMethod(2) then
        		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
				incamera = true
				exports["Players"]:setStatusHUD(true)
			end
			showHelpMessage("~INPUT_CONTEXT~ Filmer\n~INPUT_MP_TEXT_CHAT_TEAM~ Ranger la caméra")
			if incamera then
				local lPed = GetPlayerPed(-1)
				if DoesEntityExist(lPed) and not IsEntityDead(lPed) and not IsPedSittingInAnyVehicle(lPed) and GetSeatPedIsTryingToEnter(lPed) ~= -1 and GetPedParachuteState(lPed) == -1 and not IsPedSwimming(lPed) then
			        RequestAnimDict("misscarsteal4@meltdown")
					while not HasAnimDictLoaded("misscarsteal4@meltdown") do
						Citizen.Wait(100)
					end
					TaskPlayAnim(lPed, "misscarsteal4@meltdown", "_rehearsal_camera_man", 1.0, 0, -1, 62, 0.0, 0, 0, 0)
					Wait(500)
					DoScreenFadeOut(500)
					Wait(400)
					DoScreenFadeIn(500)
					scaleform = loadBreakBanner()
					while not HasScaleformMovieLoaded(scaleform) do
						Citizen.Wait(10)
					end
					local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
					AttachCamToEntity(cam, Camera, 0.7,0.0,0.0, true)
					SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
					SetCamFov(cam, fov)
					RenderScriptCams(true, false, 0, 1, 0)
					PopScaleformMovieFunctionVoid()
					local locked_on_vehicle = nil
					showHelpMessage("~INPUT_VEH_JUMP~ Suivre véhicule\n~INPUT_AIM~ Mode de vue\n~INPUT_CHARACTER_WHEEL~ Changer le texte")

					while incamera and not IsEntityDead(lPed) and true do
						--if not IsEntityPlayingAnim(lPed, "misscarsteal4@meltdown", "_rehearsal_camera_man", 63) then
						--	TaskPlayAnim(lPed, "misscarsteal4@meltdown", "_rehearsal_camera_man", 1.0, 0, -1, 63, 1.0, 0, 0, 0)
						--end
						SetEntityHeading(lPed, GetCamRot(cam, 2).z)
						if IsControlJustPressed(0, 51) and GetLastInputMethod(2) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							DoScreenFadeOut(500)
							Wait(500)
							incamera = false
						end
						if IsControlJustPressed(0, 25) and GetLastInputMethod(2) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							ChangeVision()
						end
						if IsControlJustPressed(0, 19) and GetLastInputMethod(2) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							StartSettingsBreakBanner()
						end
						--if IsControlPressed(0, 32) and GetLastInputMethod(2) then
						--	entitycoords = GetOffsetFromEntityInWorldCoords(lPed, 0.0, 0.0, 0.0)
						--	SetEntityCoords(lPed, entitycoords.x, entitycoords.y, entitycoords.z, false, false, false, false)
						--end
						if locked_on_vehicle then
							if DoesEntityExist(locked_on_vehicle) then
								PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
								if IsControlJustPressed(0, 22) and GetLastInputMethod(2) then
									PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
									locked_on_vehicle = nil
									local rot = GetCamRot(cam, 2) -- All this because I can't seem to get the camera unlocked from the entity
									local fov = GetCamFov(cam)
									local old_cam = cam
									DestroyCam(old_cam, false)
									cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
									AttachCamToEntity(cam, Camera, 0.6,0.0,0.0, true)
									SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
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
								if IsControlJustPressed(0, 22) and GetLastInputMethod(2) then
									PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
									locked_on_vehicle = entity_detected
								end
							end
						end
						HandleZoom(cam)
						DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
						Citizen.Wait(10)
					end
				end
				incamera = false
				DoScreenFadeIn(750)
				ClearTimecycleModifier()
				exports["Players"]:setStatusHUD(false)
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false, false, 0, 1, 0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam, false)
				SetNightvision(false)
				SetSeethrough(false)
				Wait(2000)
				ClearPedTasksImmediately(lPed)
			else
				if IsControlJustPressed(0, 246) and GetLastInputMethod(2) then
					DeleteObject(Camera)
					cameraactive = false
				end
			end
		end
	end
end)


--FUNCTIONS--
function ChangeVision()
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

function showHelpMessage(message)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(message)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(GetPlayerPed(-1)), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	return entityHit
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

--Utiliser Camera
function posercamera()
	if not cameraactive then
		RequestModel(-1689979033)
		while not HasModelLoaded(-1689979033) do
			Wait(1)
		end
		Camera = CreateObject(-1689979033, 0.0, 0.0, 0.0, true, true, true)
		local playerPed = GetPlayerPed(-1)
		local boneIndex = GetPedBoneIndex(playerPed, 57005)
		local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)
		AttachEntityToEntity(Camera, playerPed, boneIndex, -0.0--[[descendre]], 0.0--[[reculer]], -0.0--[[latéral]], -85.0, 90.0, 10.0, false, false, false, false, 2, true)
		cameraactive = true
	end
end

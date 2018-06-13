-- FiveM Heli Cam by mraes
-- Version 1.3 2017-06-12

--CONFIG--
local fov_max = 50.0
local fov_min = 7.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right 
local speed_ud = 8.0 -- speed by which the camera pans up-down

local injumelles = false
local fov = (fov_max+fov_min)*0.5
local vision_state = 0 -- 0 is normal, 1 is nightmode

--THREADS--

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
		if injumelles then
			local lPed = GetPlayerPed(-1)
			if DoesEntityExist(lPed) and not IsEntityDead(lPed) and not IsPedSittingInAnyVehicle(lPed) and GetSeatPedIsTryingToEnter(lPed) ~= -1 and GetPedParachuteState(lPed) == -1 and not IsPedSwimming(lPed) then
		        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BINOCULARS", 0, 1)
		        Wait(500)
				DoScreenFadeOut(500)
				Wait(500)
				DoScreenFadeIn(750)
				HideHUD(0)
				local scaleform = RequestScaleformMovie("BINOCULARS")
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(10)
				end
				local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
				AttachCamToEntity(cam, lPed, 0.0,0.5,0.85, true)
				SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
				SetCamFov(cam, fov)
				RenderScriptCams(true, false, 0, 1, 0)
				while injumelles and not IsEntityDead(lPed) and true do
					if not IsPedUsingScenario(lPed, "WORLD_HUMAN_BINOCULARS") then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BINOCULARS", 0, 0)
					end
					SetEntityHeading(lPed, GetCamRot(cam, 2).z)
					if IsControlJustPressed(0, 177) then -- Toggle Helicam
						DoScreenFadeOut(500)
						Wait(500)
						ClearPedTasks(GetPlayerPed(-1))
						injumelles = false
					end
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)
					HideHudComponentThisFrame(7)
					HideHudComponentThisFrame(8)
					HideHudComponentThisFrame(9)
					HideHudComponentThisFrame(6)
					HideHudComponentThisFrame(19)
					HideHudAndRadarThisFrame()
					HandleZoom(cam)
					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					Citizen.Wait(10)
				end
				DoScreenFadeIn(750)
				HideHUD(1)
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false, false, 0, 1, 0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam, false)
				SetNightvision(false)
			end
			injumelles = false
		end
	end
end)

--EVENTS--

RegisterNetEvent('jumelles:Active') --Just added the event to activate the binoculars
AddEventHandler('jumelles:Active', function()
	injumelles = not injumelles
end)

--FUNCTIONS--

function ChangeVision()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	else
		SetNightvision(false)
		vision_state = 0
	end
end

function HideHUD(display)
	TriggerEvent('gabs:opacity', display)
	TriggerEvent('es:setMoneyDisplay', display)
	TriggerEvent('metiers:opacity', display)
	TriggerEvent('alcool:opacity', display)
	TriggerEvent('compass:hide', display)
	TriggerEvent('streetname:hide', display)
	TriggerEvent("speedometer:view", display)
	TriggerEvent("ambulancier:maskinfo", display)
	TriggerEvent("journaliste:maskinfo", display)
	TriggerEvent("mecano:maskinfo", display)
	TriggerEvent("police:maskinfo", display)
	TriggerEvent("taxi:maskinfo", display)
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(40.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = GetPlayerPed(-1)
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,32) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,8) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	else
		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end

local timepressed = 0
local currentStance = 0 -- 0 -> Standing, 1 -> crouch, 2 -> Prone
local dureeappuictrl = 20
local isoktodetect = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedSittingInAnyVehicle(ped) and GetSeatPedIsTryingToEnter(ped) ~= -1 and GetPedParachuteState(ped) == -1 then
            DisableControlAction(0, 36, true) -- INPUT_DUCK
            if not IsPauseMenuActive() then
                if IsDisabledControlJustReleased(0, 36) and isoktodetect == true then
                    if currentStance ~= 0 then
                        SetStance(0)
                    else
                        SetStance(1)
                    end
                end
                if IsDisabledControlJustPressed(0, 36) then
                    isoktodetect = true
                end
                if IsDisabledControlPressed(0, 36) then
                    timepressed = timepressed + 1
                else
                    timepressed = 0
                end
                if timepressed == dureeappuictrl then
                    if not IsEntityInWater(ped) then
                        if currentStance ~= 2 then
                            isoktodetect = false
                            if IsPedRunning(ped) or IsPedSprinting(ped) then
                                RequestAnimDict("move_jump")
                                while not HasAnimDictLoaded("move_jump") do
                                    Wait(10)
                                end
                                TaskPlayAnim(ped, "move_jump", "dive_start_run", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
                                Wait(1000)
                            end
                            SetStance(2)
                        end
                    else
                        ResetPedMovementClipset(ped, 0.3)
                        ClearPedTasks(ped)
                    end
                end
                if currentStance == 2 then
                    if IsEntityInWater(ped) then
                        SetStance(1)
                    else
                        ProneMovement()
                    end
                end
            end
        end
    end
end)

function ProneMovement()
    local ped = GetPlayerPed(-1)
    if IsControlPressed(0, 34) then
        SetEntityHeading(ped, (GetEntityHeading(ped) + 2.0))
    elseif IsControlPressed(0, 35) then
        SetEntityHeading(ped, (GetEntityHeading(ped) - 2.0))
    end
    if IsControlPressed(0, 32) then
        if not IsEntityPlayingAnim(ped, "move_crawl", "onfront_fwd", 3) then
            RequestAnimDict("move_crawl")
            while not HasAnimDictLoaded("move_crawl") do
                Wait(10)
            end
            TaskPlayAnim(ped, "move_crawl", "onfront_fwd", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
        end
    elseif IsControlPressed(0, 33) then
        if not IsEntityPlayingAnim(ped, "move_crawl", "onfront_bwd", 3) then
            RequestAnimDict("move_crawl")
            while not HasAnimDictLoaded("move_crawl") do
                Wait(10)
            end
            TaskPlayAnim(ped, "move_crawl", "onfront_bwd", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
        end
    elseif IsControlJustReleased(0, 32) or IsControlJustReleased(0, 33) then
        ClearPedTasks(ped)
        --TaskAimGunScripted(ped, GetHashKey("SCRIPTED_GUN_TASK_PLANE_WING"), true, true)
        if not IsEntityPlayingAnim(ped, "amb@lo_res_idles@", "lying_face_down_lo_res_base", 3) then
            RequestAnimDict("amb@lo_res_idles@")
            while not HasAnimDictLoaded("amb@lo_res_idles@") do
                Wait(10)
            end
            TaskPlayAnim(ped, "amb@lo_res_idles@", "lying_face_down_lo_res_base", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
        end
    elseif IsControlJustPressed(0, 21) then
        if not IsEntityPlayingAnim(ped, "amb@lo_res_idles@", "lying_face_up_lo_res_base", 3) then
            RequestAnimDict("amb@lo_res_idles@")
            while not HasAnimDictLoaded("amb@lo_res_idles@") do
                Wait(10)
            end
            TaskPlayAnim(ped, "amb@lo_res_idles@", "lying_face_up_lo_res_base", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
        elseif not IsEntityPlayingAnim(ped, "amb@lo_res_idles@", "lying_face_down_lo_res_base", 3) then
            RequestAnimDict("amb@lo_res_idles@")
            while not HasAnimDictLoaded("amb@lo_res_idles@") do
                Wait(10)
            end
            TaskPlayAnim(ped, "amb@lo_res_idles@", "lying_face_down_lo_res_base", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
        end
    end
end

function SetStance(stance)
    local ped = GetPlayerPed(-1)
    if stance == 0 then
        ResetPedMovementClipset(ped, 0.3)
        ClearPedTasks(ped)
        currentStance = 0
        TriggerEvent('police_radio:animonoff', true)
    elseif stance == 1 then
        RequestAnimSet("move_ped_crouched")
        while (not HasAnimSetLoaded("move_ped_crouched")) do
            Citizen.Wait(100)
        end
        SetPedMovementClipset(ped, "move_ped_crouched", 0.3)
        ClearPedTasks(ped)
        currentStance = 1
        TriggerEvent('police_radio:animonoff', false)
    elseif stance == 2 then
--        if IsPedArmed(ped, 6) then
            ClearPedTasks(ped)
            if not IsEntityPlayingAnim(ped, "amb@lo_res_idles@", "lying_face_down_lo_res_base", 3) then
                RequestAnimDict("amb@lo_res_idles@")
                while not HasAnimDictLoaded("amb@lo_res_idles@") do
                    Wait(10)
                end
                TaskPlayAnim(ped, "amb@lo_res_idles@", "lying_face_down_lo_res_base", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
            end
            currentStance = 2
            TriggerEvent('police_radio:animonoff', false)
--        else
--            RequestAnimDict("move_crawlprone2crawlfront")
--            while not HasAnimDictLoaded("move_crawlprone2crawlfront") do
--                Wait(10)
--            end
--            TaskPlayAnim(ped, "move_crawlprone2crawlfront", "front", 8.0, -4.0, -1, 9, 0.0, 0, 0, 0)
--        end
    end
end


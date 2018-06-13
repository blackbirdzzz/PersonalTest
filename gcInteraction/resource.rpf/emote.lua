local emotePlay = false

function playEmote(data)
    TriggerEvent('gc:playEmote', data.EmoteName, data.diminuerhauteur)
end

function playAnimation(data)
    TriggerEvent('gc:playAnimation', data.dictionaries, data.clip)
end

function playAnimationLoop(data)
    TriggerEvent('gc:playAnimationAdv', data.dictionaries, data.clip, true)
end

RegisterNetEvent("gc:playEmote")
AddEventHandler("gc:playEmote", function(emoteNane, diminuerhauteur)
    if emotePlay then
        stopEmote()
    else
        local ped = GetPlayerPed(-1)
        if ped then
            if diminuerhauteur then
                local playerx, playery, playerz = table.unpack(GetEntityCoords(ped, true))
                local head = GetEntityHeading(ped)
                TaskStartScenarioAtPosition(ped, emoteNane, playerx, playery, playerz-0.5, head, 0, 1, false)
            else
                TaskStartScenarioInPlace(ped, emoteNane, 0, false)
            end
            emotePlay = true
        end
    end
end)
 
RegisterNetEvent("gc:playAnimation")
AddEventHandler("gc:playAnimation", function(dictionaries, clip)
    local lPed = GetPlayerPed(-1)
    if DoesEntityExist(lPed) then
        Citizen.CreateThread(function()
            RequestAnimDict(dictionaries)
            while not HasAnimDictLoaded(dictionaries) do
                Citizen.Wait(100)
            end
           
            if IsEntityPlayingAnim(lPed, dictionaries, clip, 3) then
                ClearPedSecondaryTask(lPed)
--                SetEnableYes(lPed, false)
            else
                TaskPlayAnim(lPed, dictionaries, clip, 8.0, -8, -1, 16, 0, 0, 0, 0)
--                SetEnableYes(lPed, true)
            end    
        end)
    end
end)
 
RegisterNetEvent("gc:playAnimationAdv")
AddEventHandler("gc:playAnimationAdv", function(dictionaries, clip, loop)
    local lPed = GetPlayerPed(-1)
    if DoesEntityExist(lPed) then
        Citizen.CreateThread(function()
            RequestAnimDict(dictionaries)
            while not HasAnimDictLoaded(dictionaries) do
                Citizen.Wait(100)
            end
           
            if IsEntityPlayingAnim(lPed, dictionaries, clip, 3) then
                ClearPedSecondaryTask(lPed)
--                SetEnableYes(lPed, false)
            else
                local flag = 16
                if loop == true then
                    flag = 49
                end
                TaskPlayAnim(lPed, dictionaries, clip, 8.0, -8, -1, flag, 0, 0, 0, 0)
--                SetEnableYes(lPed, true)
            end    
        end)
    end
end)

RegisterNetEvent("gc:clearAnimation")
AddEventHandler("gc:clearAnimation", function()
    local lPed = GetPlayerPed(-1)
    if DoesEntityExist(lPed) then
        stopEmote()
    end
end)

function playdemarche(data)
    local lPed = GetPlayerPed(-1)
    if DoesEntityExist(lPed) then
        RequestAnimSet(data.demarchname)
        while not HasAnimSetLoaded(data.demarchname) do
            Wait(10)
        end
        SetPedMovementClipset(lPed, data.demarchname, 1.0)
    end
end

function stopdemarche()
    local lPed = GetPlayerPed(-1)
    if DoesEntityExist(lPed) then
        ResetPedMovementClipset(lPed, 1.0)
    end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent( 'gc:KneelHU' )
AddEventHandler( 'gc:KneelHU', function()
    local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "random@arrests" )
		loadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end     
    end
end )

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(0,21,true)
		end
	end
end)

function stopEmote()
  ClearPedTasks(GetPlayerPed(-1))
  emotePlay = false
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if emotePlay then
      if IsControlJustPressed(1, 22) or IsControlJustPressed(1, 30) or IsControlJustPressed(1, 31) then -- INPUT_JUMP
        stopEmote()
      end
    end
  end
end)
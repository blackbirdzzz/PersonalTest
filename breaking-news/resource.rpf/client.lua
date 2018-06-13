local ShowBreakingBanner = false
local scaleform = nil
RegisterNetEvent('breaknews:showBanner')
AddEventHandler('breaknews:showBanner', function(first_line, second_line, third_line)
    ShowBannerWithLines(first_line, second_line, third_line)
end)

function ShowBannerWithLines(first_line, second_line, third_line)
    Citizen.CreateThread(function()
        ShowBreakingBanner = false
        Citizen.Wait(1000)
        local CountDown = 30
        ShowBreakingBanner = true
        
        while CountDown > 0 do
            Citizen.Wait(1000)
            CountDown = CountDown - 1
        end
        ShowBreakingBanner = false
    end)
    
    Citizen.CreateThread(function()
        function Initialize(scaleform)
            Citizen.Wait(5000)
            local scaleform = RequestScaleformMovie(scaleform)
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
            end
            PushScaleformMovieFunction(scaleform, "SET_TEXT")
            PushScaleformMovieFunctionParameterString(second_line)
            PushScaleformMovieFunctionParameterString(third_line)
            PopScaleformMovieFunctionVoid()
            PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterString(first_line)
            PopScaleformMovieFunctionVoid()
            PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(0)
            PopScaleformMovieFunctionVoid()
            
            return scaleform
        end
        scaleform = Initialize("breaking_news")
        while ShowBreakingBanner do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
        SetScaleformMovieAsNoLongerNeeded(scaleform)
    end)
end

RegisterNetEvent('breaknews:receiveCommand')
AddEventHandler('breaknews:receiveCommand', function(result)
    StartSettingsBreakBanner()
end)

function StartSettingsBreakBanner()
    DisplayHelpText("Entrer ~r~la première phrase~w~ en haut de la bannière")
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result_firstline = GetOnscreenKeyboardResult()
        if(result_firstline ~= nil and result_firstline ~= "") then
            --
            DisplayHelpText("Entrer ~r~la seconde phrase~w~ au milieu de la bannière")
            DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                local result_secondline = GetOnscreenKeyboardResult()
                if(result_secondline ~= nil and result_secondline ~= "") then
                    DisplayHelpText("Entrer ~r~la troisième phrase~w~ en bas de la bannière")
                    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result_thirdline = GetOnscreenKeyboardResult()
                        if(result_thirdline ~= nil and result_thirdline ~= "") then
                            TriggerServerEvent("breaknews:receiveInfosBanner", result_firstline, result_secondline, result_thirdline)
                            DisplayHelpText("Envoi des infos de la bannière aux citoyens...")
                        end
                    end
                end
            end
        end
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

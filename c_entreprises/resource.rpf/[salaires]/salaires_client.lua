Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(freqSal)
        while IsEntityDead(GetPlayerPed(-1)) do
        	Citizen.Wait(1000)
        end
        TriggerServerEvent('salaires:salary')
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(fraqSauv)
        TriggerServerEvent('salaires:saveMoney')
    end
end)

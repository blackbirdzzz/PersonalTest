function metier_callSE(id)
    Menu.hidden = not Menu.hidden
    TriggerServerEvent("metiers:jobs", id)
end

function menuJobsChomeurSelect()
    MenuTitle = "Jobs"
    ClearMenu()
    Menu.addButton("Jobs publics", "menuJobsPublic")
    Menu.addButton("Jobs privés", "menuJobsPrivees")
end

function menuJobsPublic()
    MenuTitle = "Jobs Publics"
    ClearMenu()
    for _, item in pairs(metiersList) do
        if item.WL == 0 and item.Aff == 1 then
            Menu.addButton(item.vnom, "metier_callSE", item.id)
        end
    end
    Menu.addButton("retour", "menuJobsChomeurSelect")
end

function menuJobsPrivees()
    MenuTitle = "Jobs Prives"
    ClearMenu()
    for _, item in pairs(metiersList) do
        if item.WL == 1 and item.Aff == 1 then
            Menu.addButton(item.vnom, "metier_callSE", item.id)
        end
    end
    Menu.addButton("retour", "menuJobsChomeurSelect")
end

function menuJobs()
    local MenujobsDem = {
    {name = "Démissionner", id = 1}}
    MenuTitle = "Jobs"
    ClearMenu()
    for _, item in pairs(MenujobsDem) do
        Menu.addButton(item.name, "metier_callSE", item.id)
    end
end

--[[function IsNearPlaces()
local playerCoords = GetEntityCoords(GetPlayerPed(-1), 0)
for _, item in pairs(metiers_blips) do
if(GetDistanceBetweenCoords(item.x, item.y, item.z, playerCoords["x"], playerCoords["y"], playerCoords["z"], true) <= item.distanceBetweenCoords) then
DrawMarker(1, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
return true
end
end
end]]--

RegisterNetEvent('metiers:defineJobMenu')
AddEventHandler('metiers:defineJobMenu', function(jobId)
    if jobId == 1 then
        menuJobsChomeurSelect()
    else 
        menuJobs()
    end
end)

RegisterNetEvent('metiers:getmyjob')
AddEventHandler('metiers:getmyjob', function(id)
    TriggerServerEvent("metiers:jobs", id)
end)

RegisterNetEvent('metiers:jobadmintriumnontuv')
AddEventHandler('metiers:jobadmintriumnontuv', function(id)
    TriggerServerEvent("metiers:jobsadminadmin", id)
end)

RegisterNetEvent('metiers:updateJob')
AddEventHandler('metiers:updateJob', function(nameJob)
    local id = PlayerId()
    local playerName = GetPlayerName(id)

    SendNUIMessage({
        updateJob = true, 
        job = nameJob, 
        player = playerName
    })
end)

RegisterNetEvent('metiers:opacity')
AddEventHandler('metiers:opacity', function(show)
    local id = PlayerId()
    local playerName = GetPlayerName(id)
    SendNUIMessage({
        setOpacity = true, 
        opacity = show, 
        player = playerName
    })
end)

--[[Citizen.CreateThread(function()
    for key, item in pairs(metiers_blips) do
        local blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(blip, item.id)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(key)
        EndTextCommandSetBlipName(blip)
    end
    while true do
        Citizen.Wait(2)
        if (IsNearPlaces() == true) then
            BeginTextCommandDisplayHelp("STRING")
            AddTextComponentSubstringPlayerName("Appuyez sur ~INPUT_CONTEXT~ pour sélectionner un ~b~job")
            EndTextCommandDisplayHelp(0, 0, 1, -1)
            if IsControlJustPressed(1, 51) then
                Menu.hidden = not Menu.hidden 
                TriggerServerEvent('metiers:isChomeur')
            end
            Menu.renderGUI()
        end
    end
end)]]--

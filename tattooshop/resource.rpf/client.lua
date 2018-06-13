
local options = {
    x = 0.15,
    y = 0.15,
    width = 0.25,
    height = 0.035,
    scale = 0.2,
    font = 0,
    menu_title = "Tatoueur",
    menu_subtitle = "Categories",
    color_r = 50,
    color_g = 0,
    color_b = 10
}

local currentTattoos = {}
local cam = -1

local TattooStores = {
    {x=1322.645, y=-1651.976, z=52.275, markerWidth = 1.5, activationDist = 2.0},
    {x=-1153.676, y=-1425.68, z=4.954, markerWidth = 1.5, activationDist = 2.0},
    {x=322.139, y=180.467, z=103.587, markerWidth = 1.5, activationDist = 2.0},
    {x=-3170.071, y=1075.059, z=20.829, markerWidth = 1.5, activationDist = 2.0},
    {x=1864.633, y=3747.738, z=33.032, markerWidth = 1.5, activationDist = 2.0},
    {x=-293.713, y=6200.04, z=31.487, markerWidth = 1.5, activationDist = 2.0}
}

AddEventHandler("playerSpawned", function()
    Citizen.Wait(5000)
    TriggerServerEvent("tattooshop:spawn")
end)

RegisterNetEvent("tattooshop:notifs")
AddEventHandler("tattooshop:notifs", function(msg)
    notifs(msg)
end)

function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

local TATTOOS_LIST = {}

RegisterNetEvent('tattooshop:setTattoosList')
AddEventHandler('tattooshop:setTattoosList', function(list)
    TATTOOS_LIST = {}
    TATTOOS_LIST = list
end)

RegisterNetEvent("tattooshop:getPlayerTattoos")
AddEventHandler("tattooshop:getPlayerTattoos", function(playerTattoosList)
    ClearPedDecorations(GetPlayerPed(-1))
    for _,k in pairs(playerTattoosList) do
        SetPedDecoration(GetPlayerPed(-1), GetHashKey(k.category), GetHashKey(k.nameHash))
    end
    currentTattoos = playerTattoosList
end)

---------------------------------------------------- FUNCTIONS ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Check if player is near a bank
function isNearShop()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(TattooStores) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= item.activationDist ) then
            return true
        end
    end
end

function setMapMarker(stores, blipIcon, blipColor, blipName)
    for k,v in ipairs(stores)do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, blipIcon)
        SetBlipColour(blip, blipColor)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipName)
        EndTextCommandSetBlipName(blip)
    end
end

------------------------------------------------------- NUI ------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

local intatoomenu = {}

function Main()
    options.menu_title = "Tatoueur"
    options.menu_subtitle = "Accueil"
    ClearMenu()
    Menu.selection = 1
    intatoomenu = {}
    Menu.addButton("Voir les Tatouages (~r~Tout tatouage est définitif et ineffaçable~s~)", "Categories", nil)
end

function Categories()
    options.menu_subtitle = "Tatouages (~r~définitif et ineffaçable~s~)"
    ClearMenu()
    Menu.previous = "Main"
    intatoomenu = {}
    local categ = {}
    local categexist = false
    for i,c in pairs(TATTOOS_LIST) do
        for k, v in pairs(categ) do
            if v.item_position == c.item_position then
                categexist = true
            end
        end
        if categexist == false then
            table.insert(categ, c)
            Menu.addButton(c.item_position, "BuyTattoos", c.item_position)
        end
        categexist = false
    end
end

function BuyTattoos(categorie)
    options.menu_subtitle = "Tatouages " .. categorie .. " (~r~définitif et ineffaçable~s~)"
    ClearMenu()
    Menu.previous = "Categories"
    for k, v in pairs(TATTOOS_LIST) do
        if v.item_position == categorie and (v.model == nil or GetHashKey(v.model) == GetEntityModel(GetPlayerPed(-1))) then
            table.insert(intatoomenu, v)
        end
    end
    for i,c in pairs(intatoomenu) do
        local name = "Tatouage n°" .. intatoomenu[Menu.buttonCount+1].id
        Menu.addButton(name .. " - " .. comma_value(intatoomenu[Menu.buttonCount+1].price) .. "$", "buyatattoo", intatoomenu[Menu.buttonCount+1])
    end
end

-- Close Gui
function closeGui()
    intatoomenu = {}
    Menu.hidden = true
    FreezeEntityPosition(GetPlayerPed(-1), false)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    ClearPedDecorations(GetPlayerPed(-1))
    TriggerServerEvent("skin_customization:SpawnPlayer")
    TriggerServerEvent("tattooshop:spawn")
end

function buyatattoo(tattoo)
    TriggerServerEvent('tattooshop:buyTattoo', currentTattoos, tattoo.price, {['category'] = tattoo.category, ['nameHash'] = tattoo.nameHash})
    closeGui()
end

function drawTattoo(category, nameHash)
    ClearPedDecorations(GetPlayerPed(-1))
    for _,k in pairs(currentTattoos) do
        SetPedDecoration(GetPlayerPed(-1), GetHashKey(k.category), GetHashKey(k.nameHash))
    end
    if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
        SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 16,0, 2)
    else                                                      -- BOY SKIN
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 14,0, 2)
    end

    SetPedDecoration(GetPlayerPed(-1), GetHashKey(category), GetHashKey(nameHash))
end

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

------------------------------------------------------ THREAD ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    setMapMarker(TattooStores, 75, 4, "Tatoueur")
    while true do
        Citizen.Wait(0)
        if isNearShop() then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Appuyez sur la touche ~INPUT_CONTEXT~ pour vous faire un tatouage.")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('tattooshop:getModelAndList')
                if Menu.hidden == true then
                    Menu.hidden = false
                    Main()
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                else
                    closeGui()
                end
            end
        end
        if  #intatoomenu > 0 then
            if Menu.selection > 0 then
                local category = intatoomenu[Menu.selection].category
                local nameHash = intatoomenu[Menu.selection].nameHash
                drawTattoo(category, nameHash)
            end
        end
        if Menu.hidden == false then
            Menu.renderGUI(options)
            DisableControlAction(0, 24, active) -- Attack
            DisablePlayerFiring( GetPlayerPed(-1), true) -- Disable weapon firing
            DisableControlAction(0, 142, active) -- MeleeAttackAlternate
            DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
        end

    end
end)


local options = {
    x = 0.15,
    y = 0.15,
    width = 0.25,
    height = 0.035,
    scale = 0.2,
    font = 0,
    menu_title = "Magasin de chapeaux",
    menu_subtitle = "Categories",
    color_r = 50,
    color_g = 0,
    color_b = 10
}

local HatStores = {
    { x = 1695.09, y = 4829.24, z = 42.06, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 120.135, y = -221.712, z = 54.55, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = -712.762, y = -149.47, z = 37.41, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = -829.235, y = -1074.91, z = 11.32, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = -1189.7, y = -773.001, z = 17.32, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 10.9918, y = 6515.26, z = 31.87, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 427.651, y = -799.476, z = 29.49, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 1189.85, y = 2712.26, z = 38.22, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 }
}

RegisterNetEvent("hatshop:notifs")
AddEventHandler("hatshop:notifs", function(msg)
    notifs(msg)
end)
function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

local HATS_LIST = {}
local DRESSING_HATS_LIST = {}

RegisterNetEvent('hatshop:setHatsList')
AddEventHandler('hatshop:setHatsList', function(list)
    HATS_LIST = {}
    HATS_LIST = list
end)

RegisterNetEvent('hatshop:setDressingHatsList')
AddEventHandler('hatshop:setDressingHatsList', function(list)
    DRESSING_HATS_LIST = {}
    for k,hat in ipairs(list) do
        DRESSING_HATS_LIST[k] = hat
    end
end)

---------------------------------------------------- FUNCTIONS ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Check if player is near a bank
function isNearShop()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(HatStores) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= item.markerView) then
            DrawMarker(1, item.x, item.y, item.z - 1, 0, 0, 0, 0, 0, 0, item.markerWidth, item.markerWidth, 0.5001, 0, 0, 200,165, 0, 0, 0,0)
            if(distance <= item.activationDist ) then
                return true
            end
        end
    end
end

------------------------------------------------------- NUI ------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local inhatmenu = {}

function Main()
--    print(GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 0) .. " - ")
    options.menu_title = "Magasin de chapeaux"
    options.menu_subtitle = "Accueil"
    ClearMenu()
    Menu.selection = 1
    inhatmenu = {}
    Menu.addButton("Acheter un chapeau", "BuyHats", nil)
    Menu.addButton("Changer de chapeau", "ChangeHat", nil)
end

function BuyHats()
    options.menu_subtitle = "Acheter un chapeau"
    ClearMenu()
    Menu.previous = "Main"
    for k, v in pairs(HATS_LIST) do
        if v.model == nil or GetHashKey(v.model) == GetEntityModel(GetPlayerPed(-1)) then
            table.insert(inhatmenu, v)
        end
    end
    for i,c in pairs(inhatmenu) do
        local name = "Chapeau n°" .. inhatmenu[Menu.buttonCount+1].id
        if inhatmenu[Menu.buttonCount+1].item_name ~= nil then
            name = inhatmenu[Menu.buttonCount+1].item_name
        end
        Menu.addButton(name .. " - " .. comma_value(inhatmenu[Menu.buttonCount+1].price) .. "$", "buyahat", inhatmenu[Menu.buttonCount+1])
    end
end

function ChangeHat()
    options.menu_subtitle = "Changer de chapeau"
    ClearMenu()
    Menu.previous = "Main"
    if #DRESSING_HATS_LIST > 0 then
        inhatmenu = DRESSING_HATS_LIST
        for i,c in pairs(DRESSING_HATS_LIST) do
            local name = "Chapeau n°" .. DRESSING_HATS_LIST[Menu.buttonCount+1].id
            if DRESSING_HATS_LIST[Menu.buttonCount+1].item_name ~= nil then
                name = DRESSING_HATS_LIST[Menu.buttonCount+1].item_name
            end
            Menu.addButton(name, "changeahat", {prop_id = DRESSING_HATS_LIST[Menu.buttonCount+1].prop_id, prop_txt = DRESSING_HATS_LIST[Menu.buttonCount+1].prop_txt})
        end
    end
end

-- Close Gui
function closeGui()
    ClearPedProp(GetPlayerPed(-1), 0)
    inhatmenu = {}
    Menu.hidden=true
    FreezeEntityPosition(GetPlayerPed(-1), false)
end

function buyahat(hat)
    TriggerServerEvent('hatshop:buyProp',{price = hat.price, category = hat.category, item_id = hat.prop_id, txt = hat.prop_txt})
end

function changeahat(prop)
    TriggerServerEvent('hatshop:wearHatProp', prop.prop_id, prop.prop_txt)
    closeGui()
end

function hatsSelector(hatID, hatVariation)
--  print(GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), 0, hatID))
  SetPedPropIndex(GetPlayerPed(-1), 0, hatID, hatVariation)
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
    while true do
        Citizen.Wait(0)
        if isNearShop() then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Appuyez sur la touche ~INPUT_CONTEXT~ pour ouvrir le magasin de chapeaux.")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('hatshop:getModelAndList')
                if Menu.hidden == true then
                    Menu.hidden = false
                    Main()
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                else
                    closeGui()
                end
            end
        end
        if #inhatmenu > 0 then
            if Menu.selection > 0 then
                local propid = inhatmenu[Menu.selection].prop_id
                local proptxt = inhatmenu[Menu.selection].prop_txt
                hatsSelector(propid, proptxt)
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

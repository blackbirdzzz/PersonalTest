
local options = {
    x = 0.15,
    y = 0.15,
    width = 0.25,
    height = 0.035,
    scale = 0.2,
    font = 0,
    menu_title = "Magasin de lunettes",
    menu_subtitle = "Categories",
    color_r = 50,
    color_g = 0,
    color_b = 10
}

local GlasseStores = {
    { x = 1694.39, y = 4821.07, z = 42.06, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 126.916, y = -220.83, z = 54.55, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = -707.08, y = -159.372, z = 37.41, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = -820.184, y = -1072.3, z = 11.32, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = -1195.76, y = -769.975, z = 17.31, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 3.17478, y = 6510.88, z = 31.87, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 425.637, y = -808.3, z = 29.49, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 },
    { x = 1198.86, y = 2710.13, z = 38.22, markerWidth = 2.0001, activationDist = 2.5, markerView = 15 }
}

RegisterNetEvent("glasseshop:notifs")
AddEventHandler("glasseshop:notifs", function(msg)
    notifs(msg)
end)
function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

local GLASSES_LIST = {}
local DRESSING_GLASSES_LIST = {}

RegisterNetEvent('glasseshop:setGlassesList')
AddEventHandler('glasseshop:setGlassesList', function(list)
    GLASSES_LIST = {}
    GLASSES_LIST = list
end)

RegisterNetEvent('glasseshop:setDressingGlassesList')
AddEventHandler('glasseshop:setDressingGlassesList', function(list)
    DRESSING_GLASSES_LIST = {}
    for k,glasse in ipairs(list) do
        DRESSING_GLASSES_LIST[k] = glasse
    end
end)

---------------------------------------------------- FUNCTIONS ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Check if player is near a bank
function isNearShop()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(GlasseStores) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= item.markerView ) then
            DrawMarker(1, item.x, item.y, item.z - 1, 0, 0, 0, 0, 0, 0, item.markerWidth, item.markerWidth, 0.5001, 0, 200, 0,165, 0, 0, 0,0)
            if(distance <= item.activationDist ) then
                return true
            end
        end
    end
end

------------------------------------------------------- NUI ------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local inglassemenu = {}

function Main()
--    print(GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 1) .. " - ")
    options.menu_title = "Magasin de lunettes"
    options.menu_subtitle = "Accueil"
    ClearMenu()
    Menu.selection = 1
    inglassemenu = {}
    Menu.addButton("Acheter des lunettes", "BuyGlasses", nil)
    Menu.addButton("Changer de lunettes", "ChangeGlasse", nil)
end

function BuyGlasses()
    options.menu_subtitle = "Acheter des lunettes"
    ClearMenu()
    Menu.previous = "Main"
    for k, v in pairs(GLASSES_LIST) do
        if v.model == nil or GetHashKey(v.model) == GetEntityModel(GetPlayerPed(-1)) then
            table.insert(inglassemenu, v)
        end
    end
    for i,c in pairs(inglassemenu) do
        local name = "Lunettes n°" .. inglassemenu[Menu.buttonCount+1].id
        if inglassemenu[Menu.buttonCount+1].item_name ~= nil then
            name = inglassemenu[Menu.buttonCount+1].item_name
        end
        Menu.addButton(name .. " - " .. comma_value(inglassemenu[Menu.buttonCount+1].price) .. "$", "buyaglasse", inglassemenu[Menu.buttonCount+1])
    end
end

function ChangeGlasse()
    options.menu_subtitle = "Changer de lunettes"
    ClearMenu()
    Menu.previous = "Main"
    if #DRESSING_GLASSES_LIST > 0 then
        inglassemenu = DRESSING_GLASSES_LIST
        for i,c in pairs(DRESSING_GLASSES_LIST) do
            local name = "Lunettes n°" .. DRESSING_GLASSES_LIST[Menu.buttonCount+1].id
            if DRESSING_GLASSES_LIST[Menu.buttonCount+1].item_name ~= nil then
                name = DRESSING_GLASSES_LIST[Menu.buttonCount+1].item_name
            end
            Menu.addButton(name, "changeaglasse", {prop_id = DRESSING_GLASSES_LIST[Menu.buttonCount+1].prop_id, prop_txt = DRESSING_GLASSES_LIST[Menu.buttonCount+1].prop_txt})
        end
    end
end

-- Close Gui
function closeGui()
    ClearPedProp(GetPlayerPed(-1), 1)
    inglassemenu = {}
    Menu.hidden=true
    FreezeEntityPosition(GetPlayerPed(-1), false)
end

function buyaglasse(glasse)
    TriggerServerEvent('glasseshop:buyProp',{price = glasse.price, category = glasse.category, item_id = glasse.prop_id, txt = glasse.prop_txt})
end

function changeaglasse(prop)
    TriggerServerEvent('glasseshop:wearGlasseProp', prop.prop_id, prop.prop_txt)
    closeGui()
end

function glassesSelector(glasseID, glasseVariation)
--  print(GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), 1, glasseID))
  SetPedPropIndex(GetPlayerPed(-1), 1, glasseID, glasseVariation)
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
            AddTextComponentString("Appuyez sur la touche ~INPUT_CONTEXT~ pour ouvrir le magasin de lunettes.")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('glasseshop:getModelAndList')
                if Menu.hidden == true then
                    Menu.hidden = false
                    Main()
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                else
                    closeGui()
                end
            end
        end
        if #inglassemenu > 0 then
            if Menu.selection > 0 then
                local propid = inglassemenu[Menu.selection].prop_id
                local proptxt = inglassemenu[Menu.selection].prop_txt
                glassesSelector(propid, proptxt)
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
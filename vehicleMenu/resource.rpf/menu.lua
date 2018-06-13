
Menu = {}
Menu.item = {
    ['Title'] = 'Véhicule',
    ['Items'] = {
		{['Title'] = 'Démarrer/Eteindre le moteur', ['Function'] = EngineToggle},
		{['Title'] = 'Ouvrir/Fermer portes', ['SubMenu'] = {
            ['Title'] = 'Ouvrir/Fermer portes', ['Items'] = {
                {['Title'] = 'Porte conducteur', ['Function'] = ToggleDoorData, ['Porte'] = 0, ['Close'] = false},
                {['Title'] = 'Porte passager', ['Function'] = ToggleDoorData, ['Porte'] = 1, ['Close'] = false},
                {['Title'] = 'Porte conducteur arrière', ['Function'] = ToggleDoorData, ['Porte'] = 2, ['Close'] = false},
                {['Title'] = 'Porte passager arrière', ['Function'] = ToggleDoorData, ['Porte'] = 3, ['Close'] = false},
                {['Title'] = 'Capot', ['Function'] = ToggleDoorData, ['Porte'] = 4, ['Close'] = false},
                {['Title'] = 'Coffre', ['Function'] = ToggleDoorData, ['Porte'] = 5, ['Close'] = false},
                {['Title'] = 'Porte camion droite', ['Function'] = ToggleDoorData, ['Porte'] = 6, ['Close'] = false},
                {['Title'] = 'Porte camion gauche', ['Function'] = ToggleDoorData, ['Porte'] = 7, ['Close'] = false}
            }
		}},
        {['Title'] = 'Réparer soi-même le vehicule', ['Function'] = repair},
		{['Title'] = 'Vérrouiller/Dévérrouiller le vehicule', ['Function'] = lockunlock},
        {['Title'] = 'Clés', ['SubMenu'] = {
            ['Title'] = 'Clés', ['Items'] = {
                {['Title'] = 'Aucune clé sur soi'}
            }
        }},
        {['Title'] = 'Activer/Désactiver le drift mode', ['Event'] = 'dsmoke:Switch'},
    }
}
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 0, 0, 10, 190 }
Menu.backgroundColorActive = { 255, 255, 255, 190 }
Menu.tileTextColor = { 255, 255, 255, 190 }
Menu.tileBackgroundColor = { 50, 0, 10, 190 }
Menu.textColor = { 255, 255, 255, 190 }
Menu.textColorActive = { 0, 0, 10, 190 }

Menu.keyOpenMenu = 288 -- F1
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

Menu.posX = 0.05
Menu.posY = 0.05

Menu.ItemWidth = 0.26
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 4
    scale = scale or 0.43
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw()
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)
    Menu.initText(Menu.tileTextColor, 7, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY+0.01)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end

end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    for i,v in ipairs(Menu.item.Items)do
            if( v['Title'] == 'Ambulancier')then
                table.remove(Menu.item.Items,i)

            end
    end
    TriggerEvent("ambulancier:menu")
    Menu.currentPos = {1}

end

function Menu.keyControl()
    if IsControlJustPressed(1, Menu.keyDown) then
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].Function ~= nil then
                cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Event ~= nil then
                TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                Menu.isOpen = false
            end
        end
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.initMenu()
            Menu.isOpen = not Menu.isOpen
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
    end
end)

RegisterNetEvent('vehicleMenu:addkey')
AddEventHandler('vehicleMenu:addkey', function(plate, isDouble)
    local newmenu = {}
    if isDouble then
        newmenu = {['Title'] = 'Double : ' .. string.upper(plate), ['SubMenu'] = {
            ['Title'] = 'Double : ' .. string.upper(plate), ['Items'] = {
                {['Title'] = "Supprimer", ['Function'] = delkey, ['Plate'] = string.lower(plate)}
            }
        }, ['Plate'] = string.lower(plate) }
    else
        newmenu = {['Title'] = string.upper(plate), ['SubMenu'] = {
            ['Title'] = string.upper(plate), ['Items'] = {
                {['Title'] = "Donner un double", ['Function'] = givekey, ['Plate'] = string.lower(plate)}
            }
        }, ['Plate'] = string.lower(plate) }
    end
    if Menu.item.Items[5].SubMenu.Items[1].Title == 'Aucune clé sur soi' then
        Menu.item.Items[5].SubMenu.Items[1] = newmenu
    else
        local isexist = false
        for k, v in pairs(Menu.item.Items[5].SubMenu.Items) do
            if v == newmenu then
                isexist = true
                break
            end
        end
        if not isexist then
            table.insert(Menu.item.Items[5].SubMenu.Items, newmenu)
        end
    end
end)

RegisterNetEvent('vehicleMenu:delkey')
AddEventHandler('vehicleMenu:delkey', function(plate)
    for k, v in pairs(Menu.item.Items[5].SubMenu.Items) do
        if v.Plate == string.lower(plate) then
            if #Menu.item.Items[5].SubMenu.Items > 1 then
                table.remove(Menu.item.Items[5].SubMenu.Items, k)
            else
                Menu.item.Items[5].SubMenu.Items = { {['Title'] = 'Aucune clé sur soi'} }
            end
            break
        end
    end
end)

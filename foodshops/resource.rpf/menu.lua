--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================





--===================================================================================================================================================--
--                Build Menu -- playAmination = joue l'aniamtion une fois et playAminationLoop pour jouer l'animation en boucle.                     -- 
-- site des emotes = http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm#amb@code_human_wander_idles_cop@male@staticSection --
--===================================================================================================================================================--
Menu = {}
Menu.item = {
    ['Title'] = 'Magasin',
    ['Items'] = {
        {['Title'] = 'Sandwich 50$', ['Event'] = 'food:selection',['itemid']=30,['price']=50,['Close']= false},
        {['Title'] = 'Barre chocolatée 20$', ['Event'] = 'food:selection',['itemid']=110,['price']=20,['Close']= false},
        {['Title'] = 'Eau 10$', ['Event'] = 'food:selection',['itemid']=6,['price']=10,['Close']= false},
        {['Title'] = 'Jus d\'orange 11$', ['Event'] = 'food:selection',['itemid']=108,['price']=11,['Close']= false},
        {['Title'] = 'Ice tea 12$', ['Event'] = 'food:selection',['itemid']=109,['price']=12,['Close']= false}
    }
}
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 0, 0, 10, 190 }
Menu.backgroundColorActive = { 255, 255, 255, 190 }
Menu.titleTextColor = { 255, 255, 255, 190 }
Menu.titleBackgroundColor = { 50, 0, 10, 190 }
Menu.textColor = { 255, 255, 255, 190 }
Menu.textColorActive = { 0, 0, 10, 190 }

Menu.keyOpenMenu = 170 -- F3    
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

Menu.posX = 0.05
Menu.posY = 0.15

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
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(1)
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
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.titleBackgroundColor)    
    Menu.initText(Menu.titleTextColor, 7, 0.7)
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


Menu = {}
Menu.GUI = {}
Menu.buttonCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Menu"
Menu.previous = "" -- to remplace the return button
Menu.selector = true
MaxMenuShow = 10 -- max item show in the menu
curplagemin = 1 -- current value of the min item 
curplagemax = MaxMenuShow -- -- current value of the maxitem

-- when the user up or down in the menu we move the current value min and max to scroll in the list

function Menu.addButton(name, func,args)
    Menu.GUI[Menu.buttonCount+1] = {}
    Menu.GUI[Menu.buttonCount+1]["name"] = name
    Menu.GUI[Menu.buttonCount+1]["func"] = func
    Menu.GUI[Menu.buttonCount+1]["args"] = args
    Menu.GUI[Menu.buttonCount+1]["active"] = false
    Menu.buttonCount = Menu.buttonCount+1
end

function Menu.updateSelection() 
if IsControlJustPressed(1, 173) then        ----- DOWN
  if(Menu.selection < Menu.buttonCount )then
    Menu.selection = Menu.selection +1
    if(Menu.selection>MaxMenuShow)then
      if(curplagemax~=Menu.buttonCount)then
          curplagemin=curplagemin+1
          curplagemax=curplagemax+1
      end
    end
  else
    Menu.selection = 1
    curplagemin = 1
    curplagemax = MaxMenuShow
  end
elseif IsControlJustPressed(1, 27) then   ------- UP

  if(Menu.selection > 1)then
    Menu.selection = Menu.selection -1
    if(Menu.selection<curplagemin)then
      if(curplagemin~=1)then
        curplagemin=curplagemin-1
        curplagemax=curplagemax-1
      end
    end
  else
    Menu.selection = Menu.buttonCount
    curplagemin = (Menu.buttonCount-MaxMenuShow)+1
    curplagemax = Menu.buttonCount
  end
elseif IsControlJustPressed(1, 201) then       --- ENTER
  if(Menu.buttonCount ~=0)then
    if(Menu.selection ~=0)then
      MenuCallFunction(Menu.GUI[Menu.selection]["func"], Menu.GUI[Menu.selection]["args"])
      if(Menu.selection == 0)then
        Menu.selection = 1
      end
    else
      MenuCallFunction(Menu.GUI[Menu.selection]["func"], Menu.GUI[Menu.selection]["args"])
      Menu.selection = 1
    end
  end 
elseif IsControlJustPressed(1, 177) then    --- BACKSPACE
  if(Menu.previous=="")then 
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    Menu.hidden = true
  else 
    MenuCallFunction(Menu.previous,"")
    Menu.selection = 1
  end

end

if(Menu.selector)then
local iterator = 1
  for id, settings in ipairs(Menu.GUI) do
    Menu.GUI[id]["active"] = false
      if(iterator == Menu.selection ) then
        Menu.GUI[iterator]["active"] = true
      end
    iterator = iterator +1
  end
end
end

function Menu.renderGUI(options)
    if not Menu.hidden then
        Menu.renderButtons(options)
        Menu.updateSelection()
    end
end

function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
    DrawRect(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function Menu:setTitle(options)
  SetTextFont(7)
  SetTextProportional(1)
  SetTextScale(0.7, 0.7)
  SetTextColour(255, 255, 255, 190)
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(options.menu_title)
  DrawText(options.x, options.y+0.04)
end

function Menu:setSubTitle(options)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.3, 0.3)
    SetTextColour(255, 255, 255, 190)
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(options.menu_subtitle)
    DrawRect(options.x,(options.y +0.0675),options.width,(options.height+0.035),options.color_r,options.color_g,options.color_b,150)
    DrawText(options.x, (options.y+ 0.09) - options.height/2 + 0.0028)

    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.2, 0.2)
    SetTextColour(255, 255, 255, 190)
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(options.rightText)
    DrawText((options.x + options.width/2 - 0.0385) , options.y + 0.067)
end
-- if the number of item is inferior of the maxitemshow we just do anything different
-- else we just do a loop on the current min and current max
function Menu:drawButtons(options)
  local y = options.y + 0.12
  if (Menu.buttonCount<=MaxMenuShow)then
    for id, settings in pairs(Menu.GUI) do
      SetTextFont(4)
      SetTextProportional(1)
      SetTextScale(0.43, 0.43)
      if(settings["active"]) then
        SetTextColour(0, 0, 0, 190)
      else
        SetTextColour(255, 255, 255, 190)
      end
      SetTextCentre(0)
      SetTextEntry("STRING")
      AddTextComponentString(settings["name"])
      if(settings["active"]) then
        DrawRect(options.x,y,options.width,options.height,255,255,255,190)
      else
        DrawRect(options.x,y,options.width,options.height,0,0,0,190)
      end
      DrawText(options.x - options.width/2 + 0.005,y - 0.04/2 + 0.0028)
      y = y + 0.035
    end
  else 
    for i = curplagemin, curplagemax do
      local settings=Menu.GUI[i] 
      SetTextFont(4)
      SetTextProportional(1)
      SetTextScale(0.43, 0.43)
      if(settings["active"]) then
        SetTextColour(0, 0, 0, 190)
      else
        SetTextColour(255, 255, 255, 190)
      end
      SetTextCentre(0)
      SetTextEntry("STRING")
      AddTextComponentString(settings["name"])
      if(settings["active"]) then
        DrawRect(options.x,y,options.width,options.height,255,255,255,190)
      else
        DrawRect(options.x,y,options.width,options.height,0,0,0,190)
      end

      DrawText(options.x - options.width/2 + 0.01, y - 0.04/2 + 0.0028)
      y = y + 0.035
    end
  end
end

function Menu.renderButtons(options)

    Menu:setTitle(options)
    Menu:setSubTitle(options)
    Menu:drawButtons(options)

end

-- the new clear menu to clear current min/max and previous
function ClearMenu()
  Menu.GUI = {}
  Menu.buttonCount = 0
  Menu.previous = ""
  Menu.selection = 0
  Menu.selector = true
  curplagemin = 1
  curplagemax = MaxMenuShow
end

function MenuCallFunction(fnc, arg)
    _G[fnc](arg)
end
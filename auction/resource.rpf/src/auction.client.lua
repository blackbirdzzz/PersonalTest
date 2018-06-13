--
-- @Project: Trium
-- @License: No License
--

local name = "auction"

function spawnVehicle(data)

  local car = GetHashKey(data.vehicle_model)
  local plate = data.vehicle_plate
  local state = data.vehicle_state
  local primarycolor = tonumber(data.vehicle_primarycolor)
  local secondarycolor = tonumber(data.vehicle_secondarycolor)
  local pearlescentcolor = tonumber(data.vehicle_pearlescentcolor)
  local wheelcolor = tonumber(data.vehicle_wheelcolor)
  local mods = json.decode(data.mods)
  local neoncolor = json.decode(data.neoncolor)
  local neon = tonumber(data.neon)
  local xenon = tonumber(data.xenon)
  local colorsmoke = json.decode(data.colorsmoke)
  local windowtint = tonumber(data.windowtint)
  local wheeltype = tonumber(data.wheeltype)
  local smoke = tonumber(data.smoke)
  local pneu = tonumber(data.pneu)
  local pneum = tonumber(data.pneum)
  local plac =tonumber(data.plac)
  local turbo = tonumber(data.turbo)
  local health = tonumber(data.health)

  local playerPed = GetPlayerPed(-1)
  local currentPos = GetEntityCoords(playerPed)

  RequestModel(car)
  while not HasModelLoaded(car) do
    Wait(1)
  end
  local caisseo = GetClosestVehicle(currentPos.x, currentPos.y, currentPos.z, 3.000, 0, 70)

  if DoesEntityExist(caisseo) then
    exports.ft_libs:Notification("La zone est encombrée")
  else
    if state == "Sorti" then
      exports.ft_libs:Notification("Ce véhicule n'est pas dans le garage")
    else

      local veh = CreateVehicle(car, currentPos.x, currentPos.y, currentPos.z, 0.0, true, false)
      SetVehicleModKit(veh,0)
      number = (GetVehicleModKit(veh) - 1 )

      if number <= 24 then
        number = 24
      end
      SetVehicleWheelType(veh, wheeltype)
      for i = 0 , number  do
        if mods[""..i] ~= nil then
          SetVehicleModKit(veh,0)
          SetVehicleMod(veh,i,mods[""..i])
        else
          SetVehicleModKit(veh,0)
          SetVehicleMod(veh,i,-1)
        end
      end
      SetVehicleWindowTint(veh, windowtint)
      SetVehicleColours(veh, primarycolor, secondarycolor)
      SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
      if neon == 1 then
        SetVehicleNeonLightsColour(veh,neoncolor[1],neoncolor[2],neoncolor[3])
        SetVehicleNeonLightEnabled(veh,0,true)
        SetVehicleNeonLightEnabled(veh,1,true)
        SetVehicleNeonLightEnabled(veh,2,true)
        SetVehicleNeonLightEnabled(veh,3,true)
      end
      if xenon == 1 then
        ToggleVehicleMod(veh,22,true)
      else
        ToggleVehicleMod(veh,22,false)
      end

      if pneu == 1 then
        SetVehicleMod(veh,23,mods["23"],true)
      else
        SetVehicleMod(veh,23,mods["23"],false)
      end
      if pneum == 1 then
        SetVehicleMod(veh,24,mods["24"],true)
      else
        SetVehicleMod(veh,24,mods["24"],false)
      end
      if smoke == 1 then
        ToggleVehicleMod(veh,20,true)
        SetVehicleTyreSmokeColor(veh,colorsmoke[1],colorsmoke[2],colorsmoke[3])
      else
        ToggleVehicleMod(veh,20,false)
        SetVehicleTyreSmokeColor(veh,0,0,0)
      end
      if turbo == 1 then
        ToggleVehicleMod(veh,18,true)
      else
        ToggleVehicleMod(veh,18,false)
      end
      SetVehicleNumberPlateTextIndex(veh, plac)
      SetVehicleNumberPlateText(veh, plate)
      SetVehicleOnGroundProperly(veh)
      SetVehicleHasBeenOwnedByPlayer(veh,true)
      local id = NetworkGetNetworkIdFromEntity(veh)
      SetNetworkIdCanMigrate(id, true)
      SetEntityInvincible(veh, false)
      local myPed = GetPlayerPed(-1)
      SetPedIntoVehicle(myPed, veh, - 1)
      SetVehicleEngineHealth(veh, health + 0.001)
      exports.ft_libs:Notification("Véhicule sorti")
      TriggerServerEvent('ls:recevoircles', plate, veh)

      SetEntityAsMissionEntity(veh, true, true)
      -- Update in bd
      TriggerServerEvent("auction:changeStatus", data.vehicle_plate, "Sorti", name)
    end
  end


  -- Close menu
  if exports.ft_libs:PrimaryMenu() == "auction_menu" then
    exports.ft_libs:CloseMenu()
  end

end

function stroreVehicule(changeOwner)
  local playerPed = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsUsing(playerPed)
  if vehicle ~= nil then
    local vehicle_plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent("auction:stroreVehicule", vehicle_plate, "Rentré", name)
  end
end

RegisterNetEvent('auction:stroreVehicule')
AddEventHandler('auction:stroreVehicule', function()

  local playerPed = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsUsing(playerPed)
  if vehicle ~= nil then
    SetEntityAsMissionEntity(vehicle, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
  end

end)

function triggerAction()
  if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
    exports.ft_libs:HelpPromt("Appuyez sur ~INPUT_CONTEXT~ pour rentré le véhicule")
    if IsControlJustReleased(1, 51) and GetLastInputMethod(2) then
  		stroreVehicule()
  	end
  else
    exports.ft_libs:HelpPromt("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu des enchères")
    if IsControlJustReleased(1, 51) and GetLastInputMethod(2) then
  		TriggerServerEvent("auction:openMenu")
  	end
  end
end

function closeMenu()
  if exports.ft_libs:PrimaryMenu() == "auction_menu" then
    exports.ft_libs:CloseMenu()
  end
end

function giveKeys(data)

  if data.vehicle_state == "Rentré" then

    local number = exports.ft_libs:OpenTextInput({ maxInputLength = 10 })

    if tonumber(number) ~= nil then
      number = tonumber(number)
      Citizen.Trace(data.vehicle_plate)
      TriggerServerEvent("auction:changeOwner", data.vehicle_plate, number)
      closeMenu()
    else
      exports.ft_libs:Notification("Uniquement des nombres !")
    end

  else
      exports.ft_libs:Notification("Ce vehicule n'est pas dans le garage")
  end

end

function openMenuAction(data)
  exports.ft_libs:SetMenuButtons("auction_menu_action", {
    { text = "Sortir", exec = { callback = spawnVehicle }, data = data },
    { text = "Donner", exec = { callback = giveKeys }, data = data },
  })
  exports.ft_libs:NextMenu("auction_menu_action")

end

RegisterNetEvent('auction:openMenu')
AddEventHandler('auction:openMenu', function(vehicules)

  local vehicules_liste = {}
  for _, vehicule in pairs(vehicules) do
    table.insert(vehicules_liste, { text =  vehicule.vehicle_model .. " (" .. vehicule.vehicle_plate .. ")",  subText = vehicule.ID, data = vehicule, exec = { callback = openMenuAction }  })
  end

  exports.ft_libs:SetMenuButtons("auction_menu", vehicules_liste)
  exports.ft_libs:OpenMenu("auction_menu")

end)

RegisterNetEvent("ft_libs:OnClientReady")
AddEventHandler('ft_libs:OnClientReady', function()

  -- Affichage véhicule
  -- x : -606.60
  -- y : -127.65
  -- z : 39.01

  exports.ft_libs:AddBlip("auction_sell", {
    x = -606.60,
    y = -127.65,
    z = 39.01,
    imageId = 409,
    text = "Place des enchères",
  })

  exports.ft_libs:AddMarker("auction_sell", {
    x = -606.60,
    y = -127.65,
    z = 39.01,
    weight = 6,
    height = 0.5,
  })

  exports.ft_libs:AddTrigger("auction_sell", {
    x = -606.60,
    y = -127.65,
    z = 39.01,
    weight = 6,
    active = {
      callback = triggerAction,
    },
    exit = {
      callback = closeMenu,
    },
  })

  exports.ft_libs:AddMenu("auction_menu", {

    title = "Enchères",
    menuTitle = "Liste des voitures",
    buttons = {}

  })

  exports.ft_libs:AddMenu("auction_menu_action", {

    title = "Enchères",
    menuTitle = "Action",
    buttons = {}

  })

  -- Mis en vente du véhicule
  -- x : -643.397
  -- y : -112.281
  -- z : 37.9242

  exports.ft_libs:AddBlip("auction_garage", {
    x = -643.397,
    y = -112.281,
    z = 37.9242,
    imageId = 50,
    text = "Garage des enchères",
  })

  exports.ft_libs:AddMarker("auction_garage", {
    x = -643.397,
    y = -112.281,
    z = 37.9242,
    weight = 6,
    height = 0.5,
  })

  exports.ft_libs:AddTrigger("auction_garage", {
    x = -643.397,
    y = -112.281,
    z = 37.9242,
    weight = 6,
    active = {
      callback = triggerAction,
    },
    exit = {
      callback = closeMenu,
    },
  })


end)

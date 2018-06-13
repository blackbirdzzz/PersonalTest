CARITEMS = {}

local maxcap = 2


RegisterNetEvent("car:hoodContent")
AddEventHandler("car:hoodContent", function(items)
    if items then
        CARITEMS = items
        CoffreMenu()
    else
        CARITEMS = {}
    end
end)


RegisterNetEvent("car:invContent")
AddEventHandler("car:invContent", function(items)
    if items then
        CARITEMS = items
--		print(json.encode(CARITEMS))
        PlayerMenu()
    else
        CARITEMS = {}
    end
end)


function round(args)
	local i = args * 100
	local to = math.ceil(i)
	local es = to/100
	return es
end

local vehMenuIsOpen = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsControlJustPressed(1, 182) then
            local vehFront = VehicleInFront()
            if vehFront ~= 0 then
                local vehLockStatus = GetVehicleDoorLockStatus(vehFront)
                if vehLockStatus ~= 2 then
                    if Menu.hidden then
                        ClearMenu()
                        SetVehicleDoorOpen(vehFront, 5, false, false)
                        SelectMenu(vehFront)
                    else
                        SetVehicleDoorShut(vehFront, 5, false)
                    end
                    Menu.hidden = not Menu.hidden
                    vehMenuIsOpen = true
                end
            end
        end

        if vehMenuIsOpen then
            local vehFront = VehicleInFront(vehFront)
            if Menu.hidden or vehFront == 0 then
                vehMenuIsOpen = false
                Menu.hidden = true
                TriggerEvent("players:stoppointing")
            else
                Menu.renderGUI()
            end
        end

    end
end)


function SelectMenu(veh)
	local veh = veh
	local i = 0
	local isthat = false
	for _, v in pairs(cargoCar) do
		local towmodel = GetHashKey(v.model)
		isVehicleTow = IsVehicleModel(veh, towmodel)
--		print(isVehicleTow)
		if isVehicleTow then
			maxcap = v.maxCapacity
			isthat = true
		end
	end
	if isthat == false then
		maxcap = 2
	end

	ClearMenu()
	MenuTitle = "Emplacements : ".. maxcap
	Menu.addButton("Mettre dans le coffre", "OpenPlayerMenu")
	Menu.addButton("Prendre objects du coffre", "OpenCoffreMenu", veh)
end


function OpenPlayerMenu()
    TriggerServerEvent("car:PgetItems")
end


function OpenCoffreMenu(veh)
	local veh = veh
    TriggerServerEvent("car:getItems", GetVehicleNumberPlateText(veh))
end


function CoffreMenu()
	ClearMenu()
    MenuTitle = "Emplacements : ".. maxcap
	local vehFront = VehicleInFront()
	local total_cap = 0
    for ind, value in pairs(CARITEMS) do
        if (value.quantity > 0) then
			total_cap = total_cap + value.quantity
            Menu.addButton(value.libelle .. " : " .. tostring(value.quantity), "GetItem", {ind, value.libelle})
        end
		-- Verifier la capacité max
		if(total_cap > maxcap) then
			if(value.quantity > maxcap) then
				local calculmax = value.quantity - maxcap
				TriggerServerEvent("car:looseGlitchItem", {GetVehicleNumberPlateText(vehFront), ind, calculmax, value.libelle, vehFront})
			else
				local calculmax = value.quantity / 2
				TriggerServerEvent("car:looseGlitchItem", {GetVehicleNumberPlateText(vehFront), ind, calculmax, value.libelle, vehFront})
			end
		end
		--
		-- Verifier le contenu du véhicule
		for k, v in pairs(cargocontain) do
			if v.id == ind and v.maxuserinv < value.quantity then
				TriggerServerEvent("car:looseGlitchItem", {GetVehicleNumberPlateText(vehFront), ind, v.maxuserinv, value.libelle, vehFront})
				--value.quantity = v.maxuserinv
			end
		end
    end
end


function PlayerMenu()
	ClearMenu()
	MenuTitle = "Emplacements : ".. maxcap
	for ind, value in pairs(CARITEMS) do
        if (value.quantity > 0) then
            Menu.addButton(value.libelle .. " : " .. tostring(value.quantity), "PutItem", {ind, value.libelle})
        end
    end
end


function GetItem(arg)
    local vehFront = VehicleInFront()
    if vehFront > 0 then
        local qty = DisplayInput()
		local qtyn = tonumber(qty)
		if qtyn ~= nil  and qtyn >= 1 then
			local qty = round(math.abs(qtyn), 0)
        	TriggerServerEvent("car:looseItem", {GetVehicleNumberPlateText(vehFront), arg[1], qty, arg[2], vehFront})
        	SelectMenu(vehFront)
		end
	end
end


function PutItem(arg)
    local vehFront = VehicleInFront()
    if vehFront > 0 then
        local qty = DisplayInput()
		local qtyn = tonumber(qty)
		if qtyn ~= nil and qtyn >= 1 then
			local qty = round(math.abs(qtyn), 0)
        	TriggerServerEvent("car:receiveItem",{GetVehicleNumberPlateText(vehFront), arg[1], qty, arg[2], vehFront, maxcap})
        	SelectMenu(vehFront)
		end
    end
end


function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end


function DisplayInput()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(1)
    end
    if GetOnscreenKeyboardResult() then
        return tonumber(GetOnscreenKeyboardResult())
    end
end


function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

local vestpolice = {
	opened = false,
	title = "Cop Locker",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }, -- ???
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,  --Nombre de bouton
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Take your service", description = ""},
				{name = "Break your service", description = ""},
				{name = "Bulletproof jacket", description = ""},
				{name = "Take offbulletproof jacket", description = ""},
				{name = "High-visibility clothing", description = ""},
				{name = "Take off High-visibility clothing", description = ""},
			}
		},
	}
}

local hashSkin = GetHashKey("mp_m_freemode_01")
function giveUniforme()
	TriggerServerEvent("police:setService",true)
	if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
		SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2)			-- pas de collier
		SetPedPropIndex(GetPlayerPed(-1), 1, 5, 0, 2)             --Lunette Soleil
		SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)             --Ecouteur Bluetooh
		SetPedComponentVariation(GetPlayerPed(-1), 11, 55, 0, 2)  --Chemise Police
		SetPedComponentVariation(GetPlayerPed(-1), 8, 58, 0, 2)   --Ceinture+matraque Police 
		SetPedComponentVariation(GetPlayerPed(-1), 4, 31, 0, 2)   --Pantalon Police 35,0
		SetPedComponentVariation(GetPlayerPed(-1), 6, 24, 0, 2)   --Chaussure Police
		SetPedComponentVariation(GetPlayerPed(-1), 10, 8, 0, 2)   --grade 0
		SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)   -- under skin
		
	else
		SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)		-- pas de collier
		SetPedPropIndex(GetPlayerPed(-1), 1, 11, 3, 2)           --Lunette Soleil
		SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)            --Ecouteur Bluetooh
		SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)  --Tshirt non bug
		SetPedComponentVariation(GetPlayerPed(-1), 11, 48, 0, 2) --Chemise Police
		SetPedComponentVariation(GetPlayerPed(-1), 8, 35, 0, 2)  --Ceinture+matraque Police 
		SetPedComponentVariation(GetPlayerPed(-1), 4, 30, 0, 2)  --Pantalon Police
		SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)  -- Chaussure Police
		SetPedComponentVariation(GetPlayerPed(-1), 10, 7, 0, 2)  --grade 0
		SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)   -- under skin
	
	end
	
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 200, true, true)

    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FIREEXTINGUISHER"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), 200, true, true)
    GiveWeaponComponentToPed(GetPlayerPed(-1),GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH")) -- Ajout de la torche
end


function removeUniforme()
	TriggerServerEvent("police:setService",false)
	TriggerServerEvent("skin_customization:SpawnPlayer")
	SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)
	--RemoveAllPedWeapons(GetPlayerPed(-1))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FIREEXTINGUISHER"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"))
end

function takeService()
    ServiceOn()
    giveUniforme()
    TriggerServerEvent("police:setService",true)
    drawNotification("Vous etes en Service")
end

function takeServiceInvestigation()
	ServiceOn()
	TriggerServerEvent("police:setService",true)
  	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 200, true, true)
  --  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 200, true, true)
  --  GiveWeaponComponentToPed(GetPlayerPed(-1),GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH")) -- Ajout de la torche
  --  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 200, true, true)
  --  GiveWeaponComponentToPed(GetPlayerPed(-1),GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH")) -- Ajout de la torche
  --  GiveWeaponComponentToPed(GetPlayerPed(-1),GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP")) -- Ajout du grip
  --  GiveWeaponComponentToPed(GetPlayerPed(-1),GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM")) -- Ajout du scope
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FIREEXTINGUISHER"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 200, true, true)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), 200, true, true)
    GiveWeaponComponentToPed(GetPlayerPed(-1),GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH")) -- Ajout de la torche
--    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), 200, true, true)
--    GiveWeaponComponentToPed(GetPlayerPed(-1),GetHashKey("WEAPON_SNIPERRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_LARGE")) -- Ajout du scope
	drawNotification("Vous etes en Service")
end
--== ARMURERIE + NOTIF ==--
function mettreaccessoire(data)
    GiveWeaponComponentToPed(GetPlayerPed(-1), data.weapon, data.component)
    ShowNotif("Vous avez reçu ~g~" .. data.text)
end
function mettrearme(data)
    GiveWeaponToPed(GetPlayerPed(-1), data.weapon, data.ammo, false, true)
    ShowNotif("Vous avez reçu ~g~" .. data.text)
end
function removeweapon()
    
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"))
	RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"))
    ShowNotif("Vous avez ~g~ rendu vos armes")
end
function ShowNotif(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function finishService()
    ServiceOff()
    removeUniforme()
    TriggerServerEvent('police:setService', false)                                      
    drawNotification("Service Terminé")
end

RegisterNetEvent('police:finishService')
AddEventHandler('police:finishService', function()
	ServiceOff()
    removeUniforme()
    TriggerServerEvent('police:setService', false)     
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function equipeVest(data)
    local type = data.type
    if type == "Bulletproof jacket" then
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 9, 4, 1, 2)  --Bulletproof jacket
			SetPedArmour(GetPlayerPed(-1), 100)
        else
            SetPedComponentVariation(GetPlayerPed(-1), 9, 6, 1, 2)
        end
    elseif type == "Take offbulletproof jacket" then
            SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)  --Remove Bulletproof jacket
			SetPedArmour(GetPlayerPed(-1), 0)
    elseif type == "High-visibility clothing" then
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2) --High-visibility clothing
        else
            SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2)
        end
    elseif type == "Take off High-visibility clothing" then
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 8, 58, 0, 2) --Remove High-visibility clothing + Remet la ceinture
        else
            SetPedComponentVariation(GetPlayerPed(-1), 8, 35, 0, 2)
        end
    end
end
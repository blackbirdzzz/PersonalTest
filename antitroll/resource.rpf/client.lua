local isNewbie = false
local Explodetect = true
local posRespawn = {
    {x = 256.69, y = -1344.96, z = 25.51}
}
local posGouvInt = {
	{x = -1578.94, y = -569.18, z = 108.52}
}
local posGouvExt = {
	{ x = -428.92, y = 1111.05, z = 327.69}
}
local posWeazelInt = {
	{x = -1077.38,y = -244.61,z = 44.05}
}
local posWeazelExt = {
  {x = -598.56, y = -929.88,z = 23.86}
 }

--#############################################
--################# INIT ######################
--#############################################

AddEventHandler('playerSpawned', function()
    Citizen.CreateThread(function()
        Citizen.Wait(15000)
        print("#######################################")
        print("###### INITIALISATION ANTI TROLL ######")
        print("#######################################")
        CheckHack()
        NewbieAccount()
        DetectKill()
        while true do
            TriggerServerEvent('antitroll:checkNewbie')
            Citizen.Wait(120000)
        end
    end)
end)

--#############################################
--################ BANK ACCOUNT ###############
--#############################################
function NewbieAccount()
    Citizen.CreateThread(function()
        local MyPed = GetPlayerPed(-1)
        while true do
            Citizen.Wait(1)
            if isNewbie then
                DisablePlayerFiring(MyPed, true) -- Désactive les attaques
                SetPlayerForceSkipAimIntro(MyPed, true) -- Désactive le Aiming
                if(IsPedInAnyVehicle(MyPed, false)) then -- Désactive le vol de véhicule moldu
                    local vehicule = GetVehiclePedIsIn(MyPed, false)
                    if GetPedInVehicleSeat(vehicule, -1) then
                        if not IsEntityAMissionEntity(vehicule) then
                            SetVehicleUndriveable(vehicule, true) -- Rend le véhicule inutilisable
                            SetVehicleAsNoLongerNeeded(vehicule)
                            drawNotification("[Sécurité] Il me semble que tu as déjà un véhicule dans ton garage !")
                            drawNotification("[Sécurité] Tu peux même appeler un Taxi via ton smartphone (touche F2)")
                        end
                    end
                end
            end
            if(IsConversationPedDead(MyPed)) then
                drawNotification("[Attention] Il est interdit de parler ici et sur Discord pendant un coma !")
                drawNotification("Il est interdit de réapparaitre à l'hôpital si des Ambulanciers sont présents en ville.")
            end
        end
    end)
end
--#############################################
--#############################################
--#############################################


--#############################################
--################# ANTI-HACK #################
--#############################################


function CheckHack()
    Citizen.CreateThread(function()
	Citizen.Wait(10000)
	local oldPos = GetEntityCoords(GetPlayerPed(-1), true)
    local MyPed = GetPlayerPed(-1)
        while true do
            Citizen.Wait(20)
            SetPedInfiniteAmmoClip(MyPed, false)
            SetEntityInvincible(MyPed, false)
            ResetEntityAlpha(MyPed)
            local fallin = IsPedFalling(MyPed)
            local ragg = IsPedRagdoll(MyPed)
            local parac = GetPedParachuteState(MyPed)

            if parac >= 0 or ragg or fallin then
                SetEntityMaxSpeed(MyPed, 80.0)
            else
                SetEntityMaxSpeed(MyPed, 7.1)
            end

            if(GetPedArmour(MyPed) > 100) then
                TriggerServerEvent('antitroll:ArmorDetected', GetPedArmour(MyPed))
                Citizen.Wait(2000)
            end
            if(GetPedMaxHealth(MyPed) > 200) then
                TriggerServerEvent('antitroll:LifeDetected', GetPedMaxHealth(MyPed))
                Citizen.Wait(2000)
            end
            --Citizen.InvokeNative(0xF46CDC33180FDA94,1.0)
            if(GetWeaponDamageType(GetSelectedPedWeapon(MyPed)) == 5) then
                TriggerServerEvent('antitroll:ExplosiveDetected')
                Citizen.Wait(1000)
            end

			if IsSeethroughActive(MyPed) then
				TriggerServerEvent('antitroll:Seethrough')
				Citizen.Wait(1000)
			end
			if NetworkIsInSpectatorMode(MyPed) then
				TriggerServerEvent('antitroll:SpectatorDetected')
				Citizen.Wait(1000)
			end

            if GetPlayerInvincible(MyPed) then
                TriggerServerEvent('antitroll:InvincibleDetected')
                Citizen.Wait(30000)
            end
        end
    end)
end

--#############################################
--#############################################
--#############################################

--[[
Citizen.CreateThread(function()
local curPed = GetPlayerPed(-1)
while true do
Citizen.Wait(60000)
local curHealth = GetEntityHealth( curPed )
SetEntityHealth( curPed, curHealth-2)
local curWait = math.random(20,350)
-- this will substract 2hp from the current player, wait 50ms and then add it back, this is to check for hacks that force HP at 200
Citizen.Wait(curWait)

if GetEntityHealth(curPed) >= curHealth+2 then
TriggerServerEvent('antitroll:InvincibleDetected')
Citizen.Wait(30000)
elseif GetEntityHealth(curPed) == curHealth-2 then
SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
end
end
end)
end
]]--

--#############################################
--#############################################
--#############################################

RegisterNetEvent('antitroll:isNewbie')
AddEventHandler('antitroll:isNewbie', function(Result)
    if Result < 1 then
        isNewbie = true
    else
        isNewbie = false
    end
end)

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

--#############################################
--#############################################
--#############################################

--#############################################
--############ DETECTEUR DE MORT ##############
--#############################################

local WeaponNames = {
    [tostring(GetHashKey('WEAPON_UNARMED'))] = 'Unarmed',
    [tostring(GetHashKey('WEAPON_KNIFE'))] = 'Knife',
    [tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Nightstick',
    [tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hammer',
    [tostring(GetHashKey('WEAPON_BAT'))] = 'Baseball Bat',
    [tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
    [tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
    [tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
    [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
    [tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
    [tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50',
    [tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
    [tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
    [tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
    [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
    [tostring(GetHashKey('WEAPON_MG'))] = 'MG',
    [tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG',
    [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
    [tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-Off Shotgun',
    [tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
    [tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
    [tostring(GetHashKey('WEAPON_STUNGUN'))] = 'Stun Gun',
    [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
    [tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
    [tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
    [tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
    [tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
    [tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
    [tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [Vehicle]',
    [tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
    [tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
    [tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
    [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas', 
    [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
    [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
    [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
    [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
    [tostring(GetHashKey('OBJECT'))] = 'Object',
    [tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
    [tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',
    [tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank Cannon',
    [tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Rockets',
    [tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
    [tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
    [tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
    [tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
    [tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
    [tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
    [tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
    [tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Bottle',
    [tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg Sweeper',
    [tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistol',
    [tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistol',
	[tostring(GetHashKey('WEAPON_PISTOL_MK2'))] = 'Pistol',
    [tostring(GetHashKey('WEAPON_DAGGER'))] = 'Antique Cavalry Dagger',
    [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
    [tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
    [tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
    [tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
    [tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
    [tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
    [tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
    [tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
    [tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
    [tostring(GetHashKey('WEAPON_HATCHET'))] = 'Hatchet',
    [tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
    [tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Knuckle Duster',
    [tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
    [tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
    [tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machine Pistol',
    [tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Flashlight',
    [tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
    [tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',
    [tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switchblade',
    [tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Heavy Revolver',
    [tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
    [tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Heli Crash',
    [tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
    [tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
    [tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exhaustion',
    [tostring(GetHashKey('WEAPON_FALL'))] = 'Fall',
    [tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosion',
    [tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Electric Fence',
    [tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bleeding',
    [tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
    [tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
    [tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
    [tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
    [tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
    [tostring(GetHashKey('WEAPON_ASSAULTSNIPER'))] = 'Assault Sniper',
    [tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
    [tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
    [tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Air Defence Gun',
    [tostring(GetHashKey('WEAPON_AUTOSHOTGUN'))] = 'Automatic Shotgun',
    [tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Battle Axe',
    [tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
    [tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
    [tostring(GetHashKey('WEAPON_PIPEBOMB'))] = 'Pipebomb',
    [tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Poolcue',
    [tostring(GetHashKey('WEAPON_WRENCH'))] = 'Wrench',
    [tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
    [tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
    [tostring(GetHashKey('WEAPON_COUGAR'))] = 'Cougar',
	[tostring(GetHashKey('WEAPON_SMG_MK2'))] = 'Mitraillette',
	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE_MK2'))] = 'Assault Rifle 2',
	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN_MK2'))] = 'Fusil à pompe',
	[tostring(GetHashKey('WEAPON_DOUBLEACTION'))] = 'Revolver'
}

function DetectKill()
    Citizen.CreateThread(function()
        local DeathReason, Killer, DeathCauseHash, Weapon

        while true do
            Citizen.Wait(0)
            if IsEntityDead(GetPlayerPed(-1)) then
                Citizen.Wait(500)
                local PedKiller = GetPedSourceOfDeath(GetPlayerPed(-1))
                DeathCauseHash = GetPedCauseOfDeath(GetPlayerPed(-1))
                Weapon = WeaponNames[tostring(DeathCauseHash)]

                if IsPedAPlayer(PedKiller) then
                    Killer = NetworkGetPlayerIndexFromPed(PedKiller)
                else
                    Killer = nil
                end

                if (Killer == PlayerId()) then
                    DeathReason = 'committed suicide'
                elseif (Killer == nil) then
                    DeathReason = 'died'
                else
                    if IsMelee(DeathCauseHash) then
                        DeathReason = 'murdered'
                    elseif IsTorch(DeathCauseHash) then
                        DeathReason = 'torched'
                    elseif IsKnife(DeathCauseHash) then
                        DeathReason = 'knifed'
                    elseif IsPistol(DeathCauseHash) then
                        DeathReason = 'pistoled'
                    elseif IsSub(DeathCauseHash) then
                        DeathReason = 'riddled'
                    elseif IsRifle(DeathCauseHash) then
                        DeathReason = 'rifled'
                    elseif IsLight(DeathCauseHash) then
                        DeathReason = 'machine gunned'
                    elseif IsShotgun(DeathCauseHash) then
                        DeathReason = 'pulverized'
                    elseif IsSniper(DeathCauseHash) then
                        DeathReason = 'sniped'
                    elseif IsHeavy(DeathCauseHash) then
                        DeathReason = 'obliterated'
                    elseif IsMinigun(DeathCauseHash) then
                        DeathReason = 'shredded'
                    elseif IsBomb(DeathCauseHash) then
                        DeathReason = 'bombed'
                    elseif IsVeh(DeathCauseHash) then
                        DeathReason = 'mowed over'
                    elseif IsVK(DeathCauseHash) then
                        DeathReason = 'flattened'
                    else
                        DeathReason = 'killed'
                    end
                end

                if DeathReason == 'committed suicide' or DeathReason == 'died' then
                    TriggerServerEvent('antitroll:CauseOfDeath', GetPlayerServerId(PlayerId()), DeathReason, Weapon, nil)
                else
                    TriggerServerEvent('antitroll:CauseOfDeath', GetPlayerServerId(PlayerId()), DeathReason, Weapon, GetPlayerServerId(Killer))
                end
                Killer = nil
                DeathReason = nil
                DeathCauseHash = nil
                Weapon = nil
            end
            while IsEntityDead(GetPlayerPed(-1)) do
                Citizen.Wait(0)
            end
        end
    end)
end

function IsMelee(Weapon)
    local Weapons = {'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsTorch(Weapon)
    local Weapons = {'WEAPON_MOLOTOV'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsKnife(Weapon)
    local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsPistol(Weapon)
    local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL', 'WEAPON_VINTAGEPISTOL','WEAPON_PISTOL_MK2'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSub(Weapon)
    local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsRifle(Weapon)
    local Weapons = {'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsLight(Weapon)
    local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsShotgun(Weapon)
    local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSniper(Weapon)
    local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsHeavy(Weapon)
    local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsMinigun(Weapon)
    local Weapons = {'WEAPON_MINIGUN'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsBomb(Weapon)
    local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsVeh(Weapon)
    local Weapons = {'VEHICLE_WEAPON_ROTORS'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsVK(Weapon)
    local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end




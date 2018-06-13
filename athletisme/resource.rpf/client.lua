------------
-- Config --
------------
Pos100md = {
{ ['x'] = -1778.35, ['y'] = 175.03, ['z'] = 64.3717 },
{ ['x'] = -1779.13, ['y'] = 174.516, ['z'] = 64.3717 },
{ ['x'] = -1779.76, ['y'] = 173.98, ['z'] = 64.3717 },
{ ['x'] = -1780.48, ['y'] = 173.498, ['z'] = 64.3717 },
{ ['x'] = -1781.15, ['y'] = 173.106, ['z'] = 64.3717 },
{ ['x'] = -1781.82, ['y'] = 172.582, ['z'] = 64.3717 },
{ ['x'] = -1782.54, ['y'] = 172.116, ['z'] = 64.3717 },
{ ['x'] = -1783.2058, ['y'] = 171.5721, ['z'] = 64.3717 }
}

Pos200md = {
{ ['x'] = -1732.58, ['y'] = 191.31, ['z'] = 64.3717 },
{ ['x'] = -1734.13, ['y'] = 193.36, ['z'] = 64.3717 },
{ ['x'] = -1736.56, ['y'] = 195.369, ['z'] = 64.3717 },
{ ['x'] = -1738.75, ['y'] = 196.986, ['z'] = 64.3717 },
{ ['x'] = -1741.44, ['y'] = 198.481, ['z'] = 64.3717 },
{ ['x'] = -1744.77, ['y'] = 199.793, ['z'] = 64.3717 },
{ ['x'] = -1747.47, ['y'] = 200.607, ['z'] = 64.3717 },
{ ['x'] = -1751.06, ['y'] = 201.139, ['z'] = 64.3717 }
}
Pos200mchk = {
{ ['x'] = -1768.93, ['y'] = 179.994, ['z'] = 64.3717 },
{ ['x'] = -1769.88, ['y'] = 179.824, ['z'] = 64.3717 },
{ ['x'] = -1770.88, ['y'] = 179.637, ['z'] = 64.3717 },
{ ['x'] = -1771.87, ['y'] = 179.303, ['z'] = 64.3717 },
{ ['x'] = -1772.88, ['y'] = 178.847, ['z'] = 64.3717 },
{ ['x'] = -1773.88, ['y'] = 178.382, ['z'] = 64.3717 },
{ ['x'] = -1773.9, ['y'] = 177.955, ['z'] = 64.3717 },
{ ['x'] = -1775.74, ['y'] = 177.537, ['z'] = 64.3717 }
}

Posarrive = {
{ ['x'] = -1749.21, ['y'] = 133.356, ['z'] = 64.3717 },
{ ['x'] = -1749.92, ['y'] = 132.818, ['z'] = 64.3717 },
{ ['x'] = -1750.59, ['y'] = 132.332, ['z'] = 64.3717 },
{ ['x'] = -1751.3, ['y'] = 131.919, ['z'] = 64.3717 },
{ ['x'] = -1752.02, ['y'] = 131.355, ['z'] = 64.3717 },
{ ['x'] = -1752.69, ['y'] = 130.89, ['z'] = 64.3717 },
{ ['x'] = -1753.38, ['y'] = 130.405, ['z'] = 64.3717 },
{ ['x'] = -1754.08, ['y'] = 129.946, ['z'] = 64.3717 }
}
------------
------------

local incourse = { ['cent'] = nil, ['deuxcent'] = nil }
local duree = nil
local ctrb = false
local decompte
local base = nil

Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
	local playerPed = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)
	
	if incourse.cent or incourse.deuxcent then
		if incourse.cent then
			DrawMarker(1, Posarrive[incourse.cent].x, Posarrive[incourse.cent].y, Posarrive[incourse.cent].z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 20, 0, 255, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, Posarrive[incourse.cent].x, Posarrive[incourse.cent].y, Posarrive[incourse.cent].z, true) < 0.5 then
				SetTextEntry_2("STRING")
				AddTextComponentString("Vous avez parcouru les 100m en ~g~" .. (duree - base) / 1000 .. " secondes.")
				DrawSubtitleTimed(5000, 1)
				incourse.cent = nil
				duree = nil
			end
		elseif incourse.deuxcent then
			if ok then
				DrawMarker(1, Posarrive[incourse.deuxcent].x, Posarrive[incourse.deuxcent].y, Posarrive[incourse.deuxcent].z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 20, 0, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, Posarrive[incourse.deuxcent].x, Posarrive[incourse.deuxcent].y, Posarrive[incourse.deuxcent].z, true) < 0.5 then
					SetTextEntry_2("STRING")
					AddTextComponentString("Vous avez parcouru les 200m en ~g~" .. (duree - base) / 1000 .. " secondes.")
					DrawSubtitleTimed(5000, 1)
					duree=nil
					incourse.deuxcent = nil
					ok = false
				end
			else
				DrawMarker(1, Pos200mchk[incourse.deuxcent].x, Pos200mchk[incourse.deuxcent].y, Pos200mchk[incourse.deuxcent].z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 20, 0, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, Pos200mchk[incourse.deuxcent].x, Pos200mchk[incourse.deuxcent].y, Pos200mchk[incourse.deuxcent].z, true) < 0.5 then
					ok=true
				end
			end
		end
	else
		for k, v in pairs(Pos100md) do
			if GetDistanceBetweenCoords(coords, Pos100md[k].x, Pos100md[k].y, Pos100md[k].z, true) < 100 then
				DrawMarker(1, Pos100md[k].x, Pos100md[k].y, Pos100md[k].z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 20, 0, 255, 100, false, true, 2, false, false, false, false)
			end
			if GetDistanceBetweenCoords(coords, Pos100md[k].x, Pos100md[k].y, Pos100md[k].z, true) < 0.5 then
				showHelpNotification("Appuyez sur ~b~E ~w~pour commencer un 100m")
				if IsControlJustReleased(0, 38) then
					incourse.cent = k
					SetEntityCoords(playerPed, Pos100md[k].x, Pos100md[k].y, Pos100md[k].z-1)
					SetEntityHeading(playerPed, 210.0)
					go()
				end
			end
		end
		
		for k, v in pairs(Pos200md) do
			if GetDistanceBetweenCoords(coords, Pos200md[k].x, Pos200md[k].y, Pos200md[k].z, true) < 100 then
				DrawMarker(1, Pos200md[k].x, Pos200md[k].y, Pos200md[k].z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 20, 0, 255, 100, false, true, 2, false, false, false, false)
			end
			if GetDistanceBetweenCoords(coords, Pos200md[k].x, Pos200md[k].y, Pos200md[k].z, true) < 0.5 then
				showHelpNotification("Appuyez sur ~b~E ~w~pour commencer un 200m")
				if IsControlJustReleased(0, 38) then
					incourse.deuxcent = k
					SetEntityCoords(playerPed, Pos200md[k].x, Pos200md[k].y, Pos200md[k].z-1)
					SetEntityHeading(playerPed, 55.0+(k*5))
					go()
				end
			end
		end
		
	end
  end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-1740.0, 150.0, 65.0)
    SetBlipSprite(blip, 126)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Terrain d'athlétisme")
    EndTextCommandSetBlipName(blip)
  while true do
	Citizen.Wait(0)
	if ctrb then
		DrawSprite("monspeedmeter", "speed_digits_" .. decompte, 0.5,0.5,0.050,0.12, 0.0, 255, 200, 0, 255)
	end
  end
end)

Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
	if duree then
		duree = GetGameTimer()
	end
  end
end)

function go()
	FreezeEntityPosition(GetPlayerPed(-1), true)
	ctrb = true
	decompte = "3"
	Citizen.Wait(1000)
	decompte = "2"
	Citizen.Wait(1000)
	decompte = "1"
	Citizen.Wait(1000)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	duree = GetGameTimer()
	base = duree
	decompte = "0"
	Citizen.Wait(300)
	ctrb = false
end

function showHelpNotification(str)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

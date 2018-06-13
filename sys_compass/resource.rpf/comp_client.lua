function minimap_compass()
	if compass.show then
		local pxDegree = compass.width / compass.fov
		local playerHeadingDegrees = 0
		if compass.followGameplayCam then
			-- Converts [-180, 180] to [0, 360] where E = 90 and W = 270 GetGameplayCamRot
			local camRot = Citizen.InvokeNative(0x837765A25378F0BB, 0, Citizen.ResultAsVector()) 
			playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
		else
			playerHeadingDegrees = 360.0 - GetEntityHeading(ped)
		end
		local tickDegree = playerHeadingDegrees - compass.fov / 2
		local tickDegreeRemainder = compass.ticksBetweenCardinals - (tickDegree % compass.ticksBetweenCardinals)
		local tickPosition = compass.position.x + tickDegreeRemainder * pxDegree
		tickDegree = tickDegree + tickDegreeRemainder

		while tickPosition < compass.position.x + compass.width do
			if (tickDegree % 90.0) == 0 then
				if compass.cardinal.tickShow then
					DrawRect(tickPosition, compass.position.y, compass.cardinal.tickSize.w, compass.cardinal.tickSize.h, compass.cardinal.tickColour.r, compass.cardinal.tickColour.g, compass.cardinal.tickColour.b, compass.cardinal.tickColour.a)
				end
				drawText3(degreesToIntercardinalDirection(tickDegree), tickPosition, compass.position.y + compass.cardinal.textOffset, {
					size = compass.cardinal.textSize,
					colour = compass.cardinal.textColour,
					outline = true,
					centered = true
				})
				streetname()
			elseif (tickDegree % 45.0) == 0 and compass.intercardinal.show then
				if compass.intercardinal.tickShow then
					DrawRect(tickPosition, compass.position.y, compass.intercardinal.tickSize.w, compass.intercardinal.tickSize.h, compass.intercardinal.tickColour.r, compass.intercardinal.tickColour.g, compass.intercardinal.tickColour.b, compass.intercardinal.tickColour.a)
				end
				if compass.intercardinal.textShow then
					drawText3(degreesToIntercardinalDirection(tickDegree), tickPosition, compass.position.y + compass.intercardinal.textOffset, {
						size = compass.intercardinal.textSize,
						colour = compass.intercardinal.textColour,
						outline = true,
						centered = true
					})
					streetname()
				end
			else
				DrawRect(tickPosition, compass.position.y, compass.tickSize.w, compass.tickSize.h, compass.tickColour.r, compass.tickColour.g, compass.tickColour.b, compass.tickColour.a)
			end
			tickDegree = tickDegree + compass.ticksBetweenCardinals
			tickPosition = tickPosition + pxDegree * compass.ticksBetweenCardinals
		end
	end
end

function display_street(space, pos, var1, var2, current_zone)
	local bleft = 0.340
	local bright = 0.311
	local txt = 0.290
	drawText(x - bleft, y + 0.66, 1.0, 1.5, 1.4, " | ", border_r, border_g, border_b, border_a, size)
	drawText(x - bright, y + 0.66, 1.0, 1.5, 1.4, " | ", border_r, border_g, border_b, border_a, size)
	drawText(x - space, y + 0.42, 1.0, 1.0, 1.0, direction, dir_r, dir_g, dir_b, dir_a, size)
	if tostring(GetStreetNameFromHashKey(var2)) == "" then
		drawText2(x - txt, y + 0.45, 1.0, 1.0, 0.45, current_zone, town_r, town_g, town_b, town_a, size)
	else 
		drawText2(x - txt, y + 0.45, 1.0, 1.0, 0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a, size)
	end
	drawText2(x - txt, y + 0.42, 1.0, 1.0, 0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a, size)
end

function streetname()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]

	for k,v in pairs(directions)do
		direction = GetEntityHeading(GetPlayerPed(-1))
		if(math.abs(direction - k) < 22.5)then
			direction = v
			break;
		end
	end
	if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z))then
		if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)))then
			if direction == 'N' then
				display_street(0.321, pos, var1, var2, current_zone)
			elseif direction == 'NE' then
				display_street(0.325, pos, var1, var2, current_zone)
			elseif direction == 'E' then 
				display_street(0.319, pos, var1, var2, current_zone)
			elseif direction == 'SE' then 
				display_street(0.324, pos, var1, var2, current_zone)
			elseif direction == 'S' then
				display_street(0.320, pos, var1, var2, current_zone)
			elseif direction == 'SO' then
				display_street(0.325, pos, var1, var2, current_zone)
			elseif direction == 'O' then 
				display_street(0.320, pos, var1, var2, current_zone)
			elseif direction == 'NO' then
				display_street(0.326, pos, var1, var2, current_zone)
			end
		end
	end
end

CreateThread(function()
	ped = GetPlayerPed(-1)
	if compass.position.centered then
		compass.position.x = compass.position.x - compass.width / 2
	end
	while true do
		Wait(10)
		local statusHUD = exports["Players"]:getStatusHUD()
		if not statusHUD then
			streetname()
			minimap_compass()
		end
	end
end)


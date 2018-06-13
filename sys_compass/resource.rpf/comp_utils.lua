directions = { 
[0]   = 'N', 
[45]  = 'NO', 
[90]  = 'O', 
[135] = 'SO', 
[180] = 'S', 
[225] = 'SE', 
[270] = 'E', 
[315] = 'NE', 
[360] = 'N'
}

function degreesToIntercardinalDirection(dgr)
	dgr = dgr % 360.0

	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return directions[0]
	elseif dgr >= 22.5 and dgr < 67.5 then
		return directions[315]
	elseif dgr >= 67.5 and dgr < 112.5 then
		return directions[270]
	elseif dgr >= 112.5 and dgr < 157.5 then
		return directions[225]
	elseif dgr >= 157.5 and dgr < 202.5 then
		return directions[180]
	elseif dgr >= 202.5 and dgr < 247.5 then
		return directions[135]
	elseif dgr >= 247.5 and dgr < 292.5 then
		return directions[90]
	elseif dgr >= 292.5 and dgr < 337.5 then
		return directions[45]
	end
end

function drawText(x, y, width, height, scale, text, r, g, b, a, size)
    SetTextFont(size - 2)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function drawText2(x, y, width, height, scale, text, r, g, b, a, size)
    SetTextFont(size)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function drawText3(str, x, y, style)
	if style == nil then
		style = {}
	end
	SetTextFont( (style.font ~= nil) and style.font or 0 )
	SetTextScale( 0.0, (style.size ~= nil) and style.size or 1.0 )
	SetTextProportional( 1 )
	if style.colour ~= nil then
		SetTextColour( style.colour.r ~= nil and style.colour.r or 255, style.colour.g ~= nil and style.colour.g or 255, style.colour.b ~= nil and style.colour.b or 255, style.colour.a ~= nil and style.colour.a or 255 )
	else
		SetTextColour( 255, 255, 255, 255 )
	end
	if style.shadow ~= nil then
		SetTextDropShadow( style.shadow.distance ~= nil and style.shadow.distance or 0, style.shadow.r ~= nil and style.shadow.r or 0, style.shadow.g ~= nil and style.shadow.g or 0, style.shadow.b ~= nil and style.shadow.b or 0, style.shadow.a ~= nil and style.shadow.a or 255 )
	else
		SetTextDropShadow( 0, 0, 0, 0, 255 )
	end
	if style.border ~= nil then
		SetTextEdge( style.border.size ~= nil and style.border.size or 1, style.border.r ~= nil and style.border.r or 0, style.border.g ~= nil and style.border.g or 0, style.border.b ~= nil and style.border.b or 0, style.border.a ~= nil and style.shadow.a or 255 )
	end
	if style.centered ~= nil and style.centered == true then
		SetTextCentre( true )
	end
	if style.outline ~= nil and style.outline == true then
		SetTextOutline()
	end
	SetTextEntry( "STRING" )
	AddTextComponentString( str )
	DrawText( x, y )
end
-- CONFIG --

-- The watermark text --
servername = "Trium Roleplay | discord.me/trium "

-- The x and y offset (starting at the top left corner) --
-- Default: 0.005, 0.001
offset = {x = 0.500, y = 0.001 } -- x = 0.783 à droite / x = 0.005 à gauche

-- Text RGB Color --
-- Default: 64, 64, 64 (gray)
rgb = {r = 255, g = 255, b = 255}

-- Text transparency --
-- Default: 255
alpha = 255

-- Text scale
-- Default: 0.4
-- NOTE: Number needs to be a float (so instead of 1 do 1.0)
scale = 0.5

-- Text Font --
-- 0 - 5 possible
-- Default: 1
font = 4

-- Rainbow Text --
-- false: Turn off
-- true: Activate rainbow text (overrides color)
bringontherainbows = true

-- CODE --
Citizen.CreateThread(function()
	while true do
		Wait(10)
		SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
		SetTextFont(font)
		SetTextScale(scale, scale)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(true)
		SetTextDropshadow(2, 2, 0, 0, 0)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow( 0, 0, 0, 0, 255 )
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(servername)
		DrawText(offset.x, offset.y)
	end
end)

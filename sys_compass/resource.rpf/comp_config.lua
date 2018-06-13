-- STREETS NAMES
-- Position
	-- x-axis ( - left/ + right) (min=0.85/max=1.75/def=1.0)
	x = 1.0
	-- y-axis ( - top/ + bottom) (min=0.1/max=1.0/def=1.0)
	y = 1.0
	-- If you do not see the HUD after restarting script you adjusted the x/y axis too far.

-- Colors
	-- Font size (def=4)
	size = 6
	-- Border around direction (def=255/255/255/100)
	border_r = 255
	border_g = 0
	border_b = 0
	border_a = 80
	-- Use the following variables to adjust the color of the direction user is facing. (def=255/255/255/255)
	dir_r = 255
	dir_g = 255
	dir_b = 255
	dir_a = 255
	-- Street user is currently on. (def=240/200/80/255)
	curr_street_r = 240
	curr_street_g = 200
	curr_street_b = 80
	curr_street_a = 255
	-- Street around the player (def=255/255/255/255)
	str_around_r = 255
	str_around_g = 255
	str_around_b = 255
	str_around_a = 200
	-- Town (def=255/255/255/255) (appear only if the streets aren't diplaying)
	town_r = 255
	town_g = 255
	town_b = 255
	town_a = 150

-- MINIMAP COMPASS
	compass = { cardinal={}, intercardinal={}}

	-- Cardinal = N, W, E, S
	compass.show = true
	compass.position = {x = 0.085, y = 0.8, centered = true}
	compass.width = 0.14
	compass.fov = 95
	compass.followGameplayCam = true

	compass.ticksBetweenCardinals = 5.0
	compass.tickColour = {r = 255, g = 255, b = 255, a = 100}
	compass.tickSize = {w = 0.001, h = 0.002}

	compass.cardinal.textSize = 0.20
	compass.cardinal.textOffset = 0.005
	compass.cardinal.textColour = {r = 255, g = 255, b = 255, a = 200}

	compass.cardinal.tickShow = true
	compass.cardinal.tickSize = {w = 0.001, h = 0.012}
	compass.cardinal.tickColour = {r = 255, g = 255, b = 255, a = 200}
	-- Intercardinal = NE, NW, SE, SW
	compass.intercardinal.show = true
	compass.intercardinal.textShow = true
	compass.intercardinal.textSize = 0.15
	compass.intercardinal.textOffset = 0.005
	compass.intercardinal.textColour = {r = 255, g = 255, b = 255, a = 200}

	compass.intercardinal.tickShow = true
	compass.intercardinal.tickSize = {w = 0.001, h = 0.006}
	compass.intercardinal.tickColour = {r = 255, g = 255, b = 255, a = 200}
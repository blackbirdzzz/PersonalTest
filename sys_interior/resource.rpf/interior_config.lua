INTERIORS = {
    -- HOPITAL
    [1] = {id = 1, x = 275.46, 	y = -1361.22, z = 24.53, 	h = 48.77, s = 'm', t = 1, name = "Sortie", 		destination = {2}}, -- porte sortie -> porte d'entrée
	[2] = {id = 2, x = 295.4, y = -1449.38,  z = 30.0, 	h = 0.0, s = 'm', t = 1, name = "Hôpital", 		destination = {1}}, -- porte d'entrée -> porte sortie
	[3] = {id = 3, x = 254.16, 	y = -1372.32, z = 29.70, 	h = 0.0, s = 'm', t = 1, name = "Helipad", 		destination = {4}}, -- Hopital to Helipad
    [4] = {id = 4, x = 334.24, y = -1431.29,  z = 46.55, 	h = 140.9, s = 'm', t = 1, name = "Hôpital", 		destination = {3}}, -- Helipad to Hopital
    [5] = {id = 5, x = 239.06,     y = -1361.53, z = 29.65,     h = 320.0, s = 'm', t = 1, name = "Parking",         destination = {6}}, -- Hopital to Parking
    [6] = {id = 6, x = 406.69, y = -1347.67,  z = 41.0,     h = 327.0, s = 'm', t = 1, name = "Hôpital",         destination = {5}}, -- Parking to Hopital
    -- FIB
    [110] = {id = 110, x = 10.15, y = -667.9, z = 33.44,	h = 0.0, s = 'm', t = 1, name = "Lobby",		destination = {111}}, -- parking -> lobby
    [111] = {id = 111, x = 136.1, y = -762.1, z = 45.75,	h = 0.0, s = 'm', t = 1, name = "Parking",		destination = {110}}, -- lobby -> parking
    [112] = {id = 112, x = 138.76,y = -763.25,z = 45.75,	h = 0.0, s = 'm', t = 1, name = "Etage n°49",	destination = {113}}, -- lobby -> 49 asc
	[113] = {id = 113, x = 136.12,y = -761.68,z = 242.15,	h = 0.0, s = 'm', t = 1, name = "Lobby", 		destination = {112}}, -- 49 asc -> lobby
	[114] = {id = 114, x = 126.98,y = -729.1, z = 242.15,	h = 0.0, s = 'm', t = 1, name = "Escalier", 	destination = {115}}, -- 49 porte -> esc
	[115] = {id = 115, x = 128.45,y = -731.93,z = 242.15,	h = 0.0, s = 'm', t = 1, name = "Etage n°49",	destination = {114}}, -- esc -> 49 porte
	[116] = {id = 116, x = 141.03,y = -766.13,z = 45.75,	h = 0.0, s = 'm', t = 1, name = "Etage n°47", 	destination = {117}}, -- lobby -> 47 asc
	[117] = {id = 117, x = 136.13,y = -762.03,z = 234.15,	h = 0.0, s = 'm', t = 1, name = "Lobby", 		destination = {116}}, -- 47 asc -> Lobby
	[118] = {id = 118, x = 138.13,y = -765.14,z = 234.15,	h = 0.0, s = 'm', t = 1, name = "Etage n°49",	destination = {119}}, -- 47 asc -> 49 asc
	[119] = {id = 119, x = 139.51,y = -747.29,z = 242.15,	h = 0.0, s = 'm', t = 1, name = "Etage n°47",	destination = {118}}, -- 49 asc -> 47 asc
	[120] = {id = 120, x = 141.2, y = -735.44,z = 262.85,	h = 0.0, s = 'm', t = 1, name = "Etage n°53", 	destination = {121}}, -- toit -> 53 porte
	[121] = {id = 121, x = 115.01,y = -741.86,z = 258.15,	h = 0.0, s = 'm', t = 1, name = "Toit",			destination = {120}}, -- 53 porte -> toit
	[122] = {id = 122, x = 122.53,y = -757.45,z = 258.15,	h = 0.0, s = 'm', t = 1, name = "Lobby",		destination = {123}}, -- 53 porte -> lobby
	[123] = {id = 123, x = 133.71,y = -768.77,z = 45.75,	h = 0.0, s = 'm', t = 1, name = "Etage n°53",	destination = {122}}, -- lobby -> 53 porte
	[124] = {id = 124, x = 156.77,y = -757.6, z = 258.15,	h = 0.0, s = 'm', t = 1, name = "Etage n°49",	destination = {125}}, -- 53 porte -> 49 asc
	[125] = {id = 125, x = 138.21,y = -764.92,z = 242.15,	h = 0.0, s = 'm', t = 1, name = "Etage n°53",	destination = {124}}, -- 49 asc -> 53 porte
	[126] = {id = 126, x = 136.42,y = -769.85,z = 45.75,	h = 0.0, s = 'm', t = 1, name = "Toit", 		destination = {120}}, -- lobby -> toit
	[127] = {id = 127, x = 132.43,y = -726.47,z = 258.15,	h = 0.0, s = 'm', t = 1, name = "Etage n°47",	destination = {129}}, -- balcon 00 -> 47 porte
	[128] = {id = 128, x = 157.51,y = -764.8, z = 258.15,	h = 0.0, s = 'm', t = 1, name = "Etage n°47", 	destination = {129}}, -- balcon 01 -> 47 porte
	[129] = {id = 129, x = 131.01,y = -762.33,z = 234.15,	h = 0.0, s = 'm', t = 1, name = "Balcon 01", 	destination = {128}}, -- 47 porte -> balcon 01
	[130] = {id = 130, x = 139.52,y = -772.1, z = 250.17,	h = 0.0, s = 'm', t = 1, name = "Etage n°49", 	destination = {132}}, -- balcon 03 -> 49 porte
	[131] = {id = 131, x = 114.63,y = -733.85,z = 250.17,	h = 0.0, s = 'm', t = 1, name = "Etage n°49", 	destination = {132}}, -- balcon 02 -> 49 porte
	[132] = {id = 132, x = 131.01,y = -762.33,z = 242.15,	h = 0.0, s = 'm', t = 1, name = "Balcon 02", 	destination = {131}}, -- 49 porte -> balcon 02
	[133] = {id = 133, x = 150.89,y = -763.53,z = 258.15,	h = 0.0, s = 'm', t = 1, name = "",				destination = {134}}, -- serveur -> 53
	[134] = {id = 134, x = 151.37,y = -761.87,z = 258.15,	h = 0.0, s = 'm', t = 1, name = "Serveurs", 	destination = {133}}, -- 53 -> serveur
	[135] = {id = 135, x = 143.5, y = -769.91,z = 242.15,	h = 0.0, s = 'm', t = 1, name = "", 			destination = {136}}, -- archives -> 49
	[136] = {id = 136, x = 142.01,y = -769.33,z = 242.15,	h = 0.0, s = 'm', t = 1, name = "Archives", 	destination = {135}}, -- 49 -> archives

	-- GRUPPE6
	[150] = {id = 150, x = -195.4, y = -835.19,z = 30.74,	h = 0.0, s = 'm', t = 1, name = "Gruppe 6", 	destination = {154}}, -- alta street porte droite -> asc gauche
	[151] = {id = 151, x = -197.14,y = -831.25,z = 30.74,	h = 0.0, s = 'm', t = 1, name = "Gruppe 6", 	destination = {154}}, -- alta street porte gauche -> asc gauche
	[152] = {id = 152, x = -244.71,y = -814.39,z = 30.71,	h = 0.0, s = 'm', t = 1, name = "Gruppe 6", 	destination = {155}}, -- peaceful street porte droite -> asc droite
	[153] = {id = 153, x = -242.23,y = -813.14,z = 30.71,	h = 0.0, s = 'm', t = 1, name = "Gruppe 6", 	destination = {155}}, -- peaceful street porte gauche -> asc droite
	[154] = {id = 154, x = -141.73,y = -620.9, z = 168.82,	h = 0.0, s = 's', t = 1, name = "Alta Street", 	destination = {math.random(150,151)}}, -- asc gauche -> alta street
	[155] = {id = 155, x = -139.14,y = -620.65,z = 168.82,	h = 0.0, s = 's', t = 1, name = "Peaceful Str",	destination = {math.random(152,153)}}, -- asc droite -> peaceful street
	[156] = {id = 156, x = -142.06,y = -617.66,z = 168.82,	h = 0.0, s = 's', t = 1, name = "Garage", 		destination = {159}}, -- asc gauche fond -> garage
	[157] = {id = 157, x = -139.47,y = -617.4, z = 168.82,	h = 0.0, s = 's', t = 1, name = "Helipad", 		destination = {158}}, -- asc droite fond -> helipad
	[158] = {id = 158, x = -136.91,y = -596.2, z = 206.91,	h = 0.0, s = 'm', t = 1, name = "Gruppe 6", 	destination = {157}}, -- helipad -> asc droite fond
	[159] = {id = 159, x = -121.84,y = -822.4, z = 32.39,	h = 0.0, s = 'm', t = 1, name = "Gruppe 6", 	destination = {156}}, -- garage -> asc gauche fond

	-- NORTH YANKTON
	--[[[310] = {id = 310, x = 3149.15, y = -4840.2, z = 111.88,	h = 0.0, s = 'm', t = 1, name = "Los Santos", 		destination = {311}}, -- NYK -> LSIA
	[311] = {id = 311, x = -1050.86,y = -2742.05,z = 14.59,	h = 0.0, s = 'm', t = 1, name = "North Yankton", 	destination = {310}}, -- LSIA -> NYK
    [312] = {id = 312, x = 5317.97, y = -5183.91,z = 83.51,	h = 0.0, s = 'm', t = 1, name = "Sortie", 			destination = {313}}, -- Sortie Bank -> Entrée Bank
	[313] = {id = 313, x = 5322.14, y = -5188.64,z = 83.51,	h = 0.0, s = 'm', t = 1, name = "Entrée", 			destination = {312}}, -- Entrée Bank -> Sortie Bank]]--
	
	-- BAHMAS MAMAS
    [8] = {id = 8, x = -1388.92, y = -586.08, z = 30.21, h = 35.40, s = 'm', t = 1, name = "Entrée du Bahmas", destination = {9}},
    [9] = {id = 9, x = -1394.50, y = -596.09, z = 30.31, h = 205.42, s = 'm', t = 1, name = "Sortie du Bahmas", destination = {8}},

    -- HUMANE LABS
    --[8] = {id = 8, x = 3540.859375, y = 3675.7958984375, z = 28.121143341064, h = 166.72660827637, s = 'm', t = 1, name = "Etage n°-1", destination = {9}},
    --[9] = {id = 9, x = 3540.8566894531, y = 3676.0424804688, z = 20.991781234741, h = 173.42085266113, s = 'm', t = 1, name = "Etage n°-3", destination = {8}},

	-- LSPD Armurerie
    --[12] = {id = 12, x = 452.61, y = -982.58, z = 30.68, h = 166.72, s = 'm', t = 1, name = "Entrée de l'armurerie", 		destination = {13}},
    --[13] = {id = 13, x = 454.01, y = -982.57, z = 30.68, h = 173.42, s = 'm', t = 1, name = "Sortie de l'armurerie", 		destination = {12}},
	
	-- Mine Orpailleur
    [14] = {id = 14, x = -595.61, y = 2087.36, z = 131.38, h = 166.72, s = 'm', t = 1, name = "Sortie de la mine", 			destination = {15}},
    [15] = {id = 15, x = -596.25, y = 2089.04, z = 131.41, h = 131.41, s = 'm', t = 1, name = "Entrée de la mine", 			destination = {14}},
	
	-- Life Invader
	[16] = {id = 16, x = -1075.42, y = -253.32, z = 37.76, h = 0.0, s = 'm', t = 1, name = "Toit",				destination = {17}},	-- lobby life invader -> toit
	[17] = {id = 17, x = -1072.75, y = -246.62, z = 54.01, h = 0.0, s = 'm', t = 1, name = "LifeInvader", 		destination = {16}},	-- toit lobby -> life invader  
	
	-- Weazel News
    [20] = {id = 20, x = -598.56, y = -929.88,z = 23.86, h = 0.0, s = 'm', t = 1,  name = "Weazel News", 		destination = {21}}, -- porte principale -> escalier
    [21] = {id = 21, x = -1077.38,y = -244.61,z = 44.05, h = 0.0, s = 'x', t = 25, name = "Sortie principale", 	destination = {20}}, -- escalier -> porte principale
	[22] = {id = 22, x = -1046.94,y = -238.22,z = 44.05, h = 0.0, s = 'm', t = 25, name = "", 					destination = {23}}, -- bureau -> salle réunion
    [23] = {id = 23, x = -1047.99,y = -238.78,z = 44.05, h = 0.0, s = 'm', t = 25, name = "Salle de Réunion", 	destination = {22}}, -- salle réunion -> bureaux  
	[26] = {id = 26, x = -569.01, y = -927.73,z = 36.83, h = 0.0, s = 'm', t = 1,  name = "Weazel News", 		destination = {27}}, -- toit -> asc gauche
	[27] = {id = 27, x = -1075.55,y = -253.11,z = 44.05, h = 0.0, s = 'm', t = 25, name = "Toit", 				destination = {26}}, -- asc gauche --> toit
	[28] = {id = 28, x = -589.92, y = -912.45,z = 23.87, h = 0.0, s = 'm', t = 1,  name = "Weazel News", 		destination = {29}}, -- porte employé -> asc droite
	[29] = {id = 29, x = -1078.05,y = -254.39,z = 44.05, h = 0.0, s = 'm', t = 25, name = "Sortie Employé", 	destination = {28}}, -- asc droite -> porte employé 
	[30] = {id = 30, x = -574.94, y = -940.15,z = 23.86, h = 0.0, s = 'm', t = 1,  name = "Weazel News", 		destination = {31}}, -- porte parking -> porte café
	[31] = {id = 31, x = -1068.97,y = -246.8, z = 44.05, h = 0.0, s = 'm', t = 25, name = "Parking", 			destination = {30}}, -- porte café -> porte parking 

	[40] = {id = 40, x = 1994.78,y = 3046.3, z = 47.21, h = 0.0, s = 's', t = 1, name = "Fight Club", 			destination = {41}}, -- porte garage Fight Club -> Yellow Jack
	[41] = {id = 41, x = 1997.28,y = 3039.31,z = 47.05, h = 0.0, s = 'm', t = 1, name = "Yellow Jack", 			destination = {40}}, -- porte Yellow Jack -> porte garage Fight Club
	
	-- Gouvernement
	[50] = {id = 50, x = -430.2,  y = 1110.19,z = 327.68, h = 0.0, s = 'l', t = 1, name = "Entrée Gouvernement",		destination = {51}}, -- porte d'entrée --> porte gauche intérieur
	[51] = {id = 51, x = -1578.94,y = -569.18,z = 108.52, h = 0.0, s = 'm', t = 1, name = "Sortie Gouvernement", 		destination = {50}}, -- porte gauche intérieur --> porte d'entrée
	[52] = {id = 52, x = -420.3,  y = 1066.61,z = 323.84, h = 0.0, s = 'm', t = 1, name = "Gouvernement",				destination = {53}}, -- Porte garage extérieur -> Porte bureau
	[53] = {id = 53, x = -1576.13,y = -582.54,z = 108.52, h = 0.0, s = 'm', t = 1, name = "Garage",						destination = {52}}, -- Porte bureau -> Porte garage extérieur
	[54] = {id = 54, x = -1583.79,y = -559.7, z = 108.52, h = 0.0, s = 'm', t = 1, name = "Terrasse Ouest",				destination = {55}}, -- Porte fond gauche -> Terrasse Ouest
	[55] = {id = 55, x = -461.39, y = 1101.17,z = 327.68, h = 0.0, s = 'm', t = 1, name = "Gouvernement",				destination = {54}}, -- Terrasse Ouest -> Porte fond gauche
	[56] = {id = 56, x = -1581.85,y = -557.7, z = 108.52, h = 0.0, s = 'm', t = 1, name = "Terrasse Est",				destination = {57}}, -- Porte fond droite -> Terrasse Est
	[57] = {id = 57, x = -406.38, y = 1086.01,z = 327.69, h = 0.0, s = 'm', t = 1, name = "Gouvernement",				destination = {56}}, -- Terrasse Est -> Porte fond droite
	[58] = {id = 58, x = -434.89, y = 1089.88,z = 332.53, h = 0.0, s = 'm', t = 1, name = "Gouvernement",				destination = {59}}, -- Toit -> Porte droite
	[59] = {id = 59, x = -1574.26,y = -565.4, z = 108.52, h = 0.0, s = 'm', t = 1, name = "Toit",						destination = {58}}, -- Porte droite -> Toit

}

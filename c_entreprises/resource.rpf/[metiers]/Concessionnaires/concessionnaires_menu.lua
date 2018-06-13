-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MENU Loca'Luxe-------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
local Job_ID = 25
local Job_Name = ""

local compacts = {
    {name = "Blista", costs = 7000, model = "blista", vMax = "72.43", accel = "57.5", frein = "20"}, 
    {name = "Brioso R/A", costs = 8000, model = "brioso", vMax = "72.43", accel = "72.5", frein = "20"}, 
    {name = "Dilettante", costs = 750, model = "Dilettante", vMax = "69.75", accel = "25", frein = "20"}, 
    {name = "Issi", costs = 6000, model = "issi2", vMax = "72.43", accel = "57.5", frein = "20"}, 
    {name = "Panto", costs = 8000, model = "panto", vMax = "70.82", accel = "67.5", frein = "20"}, 
    {name = "Prairie", costs = 4500, model = "prairie", vMax = "72.43", accel = "55", frein = "20"}, 
    {name = "Rhapsody", costs = 6000, model = "rhapsody", vMax = "71.36", accel = "57.5", frein = "20"}, 
}

local coupes = {
    {name = "Ruiner", costs = 31000, model = "ruiner", vMax = "83.17", accel = "82.5", frein = "33.33"}, 
    {name = "Cognoscenti Cabrio", costs = 38000, model = "cogcabrio", vMax = "77.8", accel = "65", frein = "20"}, 
    {name = "Exemplar", costs = 46000, model = "exemplar", vMax = "77.8", accel = "65", frein = "30"}, 
    {name = "F620", costs = 42000, model = "f620", vMax = "77.8", accel = "60", frein = "30"}, 
    {name = "Felon", costs = 38000, model = "felon", vMax = "77.8", accel = "60", frein = "30"}, 
    {name = "Felon GT", costs = 40000, model = "felon2", vMax = "77.8", accel = "60", frein = "30"}, 
    {name = "Jackal", costs = 27000, model = "jackal", vMax = "76.46", accel = "55", frein = "30"}, 
    {name = "Oracle", costs = 38000, model = "oracle", vMax = "80.48", accel = "67.5", frein = "30"}, 
    {name = "Oracle XS", costs = 21000, model = "oracle2", vMax = "80.48", accel = "65", frein = "30"}, 
    {name = "Sentinel XS", costs = 24000, model = "sentinel", vMax = "76.19", accel = "52.5", frein = "30"}, 
    {name = "Sentinel", costs = 21000, model = "sentinel2", vMax = "76.19", accel = "52.5", frein = "30"}, 
    {name = "Windsor", costs = 150000, model = "windsor", vMax = "77.8", accel = "65", frein = "20"}, 
    {name = "Windsor Drop", costs = 175000, model = "windsor2", vMax = "80.48", accel = "69.75", frein = "23.33"}, 
    {name = "Zion", costs = 22000, model = "zion", vMax = "77.8", accel = "55", frein = "30"}, 
    {name = "Zion Cabrio", costs = 23000, model = "zion2", vMax = "77.8", accel = "55", frein = "30"}, 
}

local sports = {
    {name = "9F", costs = 150000, model = "ninef", vMax = "83.17", accel = "82.5", frein = "33.33"}, 
    {name = "9F Cabrio", costs = 165000, model = "ninef2", vMax = "83.17", accel = "82.5", frein = "33.33"}, 
    {name = "Alpha", costs = 250000, model = "alpha", vMax = "83.17", accel = "85", frein = "33.33"}, 
    {name = "Banshee", costs = 215000, model = "banshee", vMax = "79.41", accel = "85", frein = "33.33"}, 
    {name = "Bestia GTS", costs = 195000, model = "bestiagts", vMax = "83.17", accel = "80", frein = "33.33"}, 
    {name = "Blista Compact", costs = 15000, model = "blista", vMax = "70.82", accel = "57.5", frein = "18.33"}, 
    {name = "Buffalo", costs = 45000, model = "buffalo", vMax = "77.8", accel = "67.5", frein = "30"}, 
    {name = "Buffalo S", costs = 55000, model = "buffalo2", vMax = "77.8", accel = "72.5", frein = "30"}, 
    {name = "Carbonizzare", costs = 200000, model = "carbonizzare", vMax = "84.78", accel = "87.5", frein = "26.67"}, 
    {name = "Comet", costs = 195000, model = "comet2", vMax = "81.56", accel = "85", frein = "26.67"}, 
    {name = "Comet Rétro", costs = 270000, model = "comet3", vMax = "80.56", accel = "85", frein = "27"}, 
    {name = "Coquette", costs = 95000, model = "coquette", vMax = "81.56", accel = "82.5", frein = "26.67"}, 
    {name = "Drift Tampa", costs = 365000, model = "tampa2", vMax = "80.48", accel = "82.5", frein = "16.67"}, 
    {name = "Feltzer", costs = 255000, model = "feltzer2", vMax = "82.09", accel = "85", frein = "26.67"}, 
    {name = "Furore GT", costs = 185000, model = "furoregt", vMax = "81.56", accel = "83.75", frein = "26.67"}, 
    {name = "Fusilade", costs = 35000, model = "fusilade", vMax = "79.95", accel = "80", frein = "30"}, 
    {name = "Jester", costs = 210000, model = "jester", vMax = "84.78", accel = "75", frein = "31.67"}, 
    {name = "Jester(Racecar)", costs = 245000, model = "jester2", vMax = "84.78", accel = "77.5", frein = "31.67"}, 
    {name = "Kuruma", costs = 95000, model = "kuruma", vMax = "78.87", accel = "77.5", frein = "16.67"}, 
    {name = "Lynx", costs = 195000, model = "lynx", vMax = "84.24", accel = "78.75", frein = "33.33"}, 
    {name = "Massacro", costs = 205000, model = "massacro", vMax = "82.09", accel = "90.25", frein = "30"}, 
    {name = "Massacro(Racecar)", costs = 235000, model = "massacro2", vMax = "83.81", accel = "91", frein = "30"}, 
    {name = "Elegy", costs = 35000, model = "elegy2", vMax = "81.56", accel = "82.5", frein = "16.67"}, 
    {name = "Elegy Rétro", costs = 190000, model = "elegy", vMax = "79.41", accel = "42.5", frein = "33.33"}, 
    {name = "Khamelion", costs = 235000, model = "khamelion", vMax = "75.12", accel = "37.5", frein = "30"}, 
    {name = "Futo", costs = 25000, model = "futo", vMax = "72.43", accel = "72.5", frein = "16.67"}, 
    {name = "Omnis", costs = 175000, model = "omnis", vMax = "81.56", accel = "76.25", frein = "33.33"}, 
    {name = "Penumbra", costs = 17000, model = "penumbra", vMax = "75.12", accel = "55", frein = "26.67"}, 
    {name = "Rapid GT", costs = 215000, model = "rapidgt", vMax = "81.56", accel = "90", frein = "33.33"}, 
    {name = "Rapid GT Convertible", costs = 215000, model = "rapidgt2", vMax = "81.56", accel = "90", frein = "33.33"}, 
    {name = "Schafter V12", costs = 85000, model = "schafter3", vMax = "80.48", accel = "75", frein = "31.67"}, 
    {name = "Sultan", costs = 55000, model = "sultan", vMax = "77.8", accel = "65", frein = "13.33"}, 
    {name = "Surano", costs = 215000, model = "surano", vMax = "83.17", accel = "85", frein = "33.33"}, 
    {name = "Seven-70", costs = 335000, model = "seven70", vMax = "85.31", accel = "83.75", frein = "33.33"}, 
    {name = "Tropos", costs = 175000, model = "tropos", vMax = "81.56", accel = "56.25", frein = "23.33"}, 
    {name = "Verkierer", costs = 180000, model = "verlierer2", vMax = "80.48", accel = "83.75", frein = "33.33"}, 
    {name = "Specter", costs = 195000, model = "specter", vMax = "80.48", accel = "83.75", frein = "33.33"}, 
    {name = "Specter 2.0", costs = 235000, model = "specter2", vMax = "80.48", accel = "83.75", frein = "33.33"}, 
}

local sportclassics = {
    {name = "Penetrator", costs = 195000, model = "penetrator", vMax = "81.02", accel = "80", frein = "20"}, 
    {name = "Casco", costs = 195000, model = "casco", vMax = "81.02", accel = "80", frein = "20"}, 
    {name = "Coquette Classic", costs = 185000, model = "coquette2", vMax = "81.02", accel = "85", frein = "16.67"}, 
    --{name = "JB 700", costs = 1000000, model = "jb700", vMax="80.48", accel="65", frein= "20"},
    {name = "Pigalle", costs = 60000, model = "pigalle", vMax = "79.95", accel = "66.25", frein = "28.33"}, 
    {name = "Stinger", costs = 125000, model = "stinger", vMax = "77.8", accel = "65", frein = "20"}, 
    {name = "Stinger GT", costs = 145000, model = "stingergt", vMax = "77.8", accel = "65", frein = "20"}, 
    {name = "Stirling GT", costs = 150000, model = "feltzer3", vMax = "74.04", accel = "75", frein = "26.67"}, 
    {name = "Z-Type", costs = 815000, model = "ztype", vMax = "75.12", accel = "55", frein = "13.33"}, 
    {name = "Infernus classique", costs = 290000, model = "infernus2", vMax = "80.21", accel = "82.5", frein = "16.67"}, 
    {name = "Manana", costs = 62000, model = "manana", vMax = "69.75", accel = "40", frein = "8.33"}, 
    {name = "Peyote", costs = 65000, model = "peyote", vMax = "69.75", accel = "40", frein = "8.33"}, 
    {name = "Mamba", costs = 255000, model = "mamba", vMax = "79.41", accel = "85", frein = "16.67"}, 
    {name = "Monroe", costs = 155000, model = "monroe", vMax = "80.48", accel = "70", frein = "22"}, 
    {name = "Roosevelt", costs = 695000, model = "btype3", vMax = "67.07", accel = "67.5", frein = "18.3"}, 
}

local supercars = {
    {name = "811", costs = 1200000, model = "pfister811", vMax = "85.47", accel = "89", frein = "37.3"}, 
    {name = "Ruston", costs = 1300000, model = "ruston", vMax = "85.47", accel = "89", frein = "37.3"}, 
    {name = "Adder", costs = 800000, model = "adder", vMax = "85.85", accel = "80", frein = "33.33"}, 
    {name = "Banshee 900R", costs = 250000, model = "banshee2", vMax = "80.48", accel = "86.88", frein = "33.33"}, 
    {name = "Bullet", costs = 350000, model = "bullet", vMax = "81.56", accel = "82.5", frein = "26.67"}, 
    {name = "Cheetah", costs = 475000, model = "cheetah", vMax = "82.09", accel = "80", frein = "26.67"}, 
    {name = "Entity XF", costs = 675000, model = "entityxf", vMax = "83.17", accel = "82.5", frein = "30"}, 
    {name = "ETR1", costs = 1500000, model = "sheava", vMax = "85.04", accel = "82.5", frein = "38.33"}, 
    {name = "FMJ", costs = 1875000, model = "fmj", vMax = "84.99", accel = "91.38", frein = "36.67"}, 
    {name = "Infernus", costs = 950000, model = "infernus", vMax = "80.48", accel = "85", frein = "16.67"}, 
    {name = "Osiris", costs = 1075000, model = "osiris", vMax = "85.31", accel = "88.5", frein = "33.33"}, 
    {name = "RE-7B", costs = 3100000, model = "le7b", vMax = "86.38", accel = "92.75", frein = "36.67"}, 
    {name = "Nero", costs = 1150000, model = "nero", vMax = "85.85", accel = "84.38", frein = "33.33"}, 
    {name = "Nero 2.0", costs = 1800000, model = "nero2", vMax = "85.85", accel = "84.38", frein = "33.33"}, 
    {name = "Reaper", costs = 1650000, model = "reaper", vMax = "85.31", accel = "91.25", frein = "36.67"}, 
    {name = "Sultan RS", costs = 200000, model = "sultanrs", vMax = "79.41", accel = "82.5", frein = "33.33"}, 
    {name = "T20", costs = 1150000, model = "t20", vMax = "85.31", accel = "88.5", frein = "33.33"}, 
    {name = "Turismo R", costs = 1650000, model = "turismor", vMax = "83.17", accel = "88.25", frein = "40"}, 
    {name = "Tyrus", costs = 2250000, model = "tyrus", vMax = "86.38", accel = "92.75", frein = "40"}, 
    {name = "Tempesta", costs = 650000, model = "tempesta", vMax = "84.24", accel = "90", frein = "33.33"}, 
    {name = "Vacca", costs = 450000, model = "vacca", vMax = "81.56", accel = "75", frein = "33.33"}, 
    {name = "Voltic", costs = 650000, model = "voltic", vMax = "77.8", accel = "90", frein = "33.33"}, 
    {name = "X80 Proto", costs = 5150000, model = "prototipo", vMax = "85.31", accel = "93.75", frein = "36.67"}, 
    {name = "Zentorno", costs = 1250000, model = "zentorno", vMax = "85.31", accel = "88.75", frein = "33.33"}, 
    {name = "Itali GTB", costs = 950000, model = "italigtb", vMax = "85.31", accel = "84.14", frein = "37"}, 
    {name = "Itali GTB 2.0", costs = 1150000, model = "italigtb2", vMax = "85.31", accel = "84.14", frein = "37"}, 
    {name = "GP1", costs = 825000, model = "gp1", vMax = "86.12", accel = "92.5", frein = "40"}, 
    {name = "Ocelot XA21", costs = 2300000, model = "xa21", vMax = "86.12", accel = "92.5", frein = "40"}, 
    {name = "Revolter", costs = 925000, model = "revolter", vMax = "80.48", accel = "83.75", frein = "33.33"}, 
}

local muscle = {
    {name = "Blade", costs = 79500, model = "blade", vMax = "77.8", accel = "81", frein = "26.67"}, 
    {name = "Buccaneer", costs = 82500, model = "buccaneer", vMax = "78.34", accel = "70", frein = "26.67"}, 
    {name = "Chino", costs = 85000, model = "chino", vMax = "75.12", accel = "70", frein = "26.67"}, 
    {name = "Coquette BlackFin", costs = 135000, model = "coquette3", vMax = "81.02", accel = "85", frein = "16.67"}, 
    {name = "Dominator", costs = 95000, model = "dominator", vMax = "77.8", accel = "72.5", frein = "26.67"}, 
    {name = "Dukes", costs = 115000, model = "dukes", vMax = "77.26", accel = "80", frein = "26.67"}, 
    {name = "Gauntlet", costs = 75000, model = "gauntlet", vMax = "77.8", accel = "75", frein = "30"}, 
    {name = "Hotknife", costs = 115000, model = "hotknife", vMax = "75.12", accel = "75", frein = "14.33"}, 
    {name = "Faction", costs = 25000, model = "faction", vMax = "75.12", accel = "70", frein = "26.67"}, 
    {name = "Nightshade", costs = 65000, model = "nightshade", vMax = "77.8", accel = "62.5", frein = "20"}, 
    {name = "Picador", costs = 15000, model = "picador", vMax = "72.43", accel = "55", frein = "26.67"}, 
    {name = "Sabre Turbo", costs = 35000, model = "sabregt", vMax = "75.12", accel = "70", frein = "26.67"}, 
    {name = "Sabre Custom", costs = 320000, model = "sabregt2", vMax = "75.12", accel = "70", frein = "26.67"}, 
    {name = "Tampa", costs = 65000, model = "tampa", vMax = "75.12", accel = "67.5", frein = "26.67"}, 
    {name = "Tornado Rusty", costs = 6500, model = "tornado3", vMax = "75.12", accel = "67.5", frein = "26.67"}, 
    {name = "Tornado2", costs = 20000, model = "tornado2", vMax = "75.12", accel = "67.5", frein = "26.67"}, 
    {name = "Virgo", costs = 25000, model = "virgo", vMax = "75.12", accel = "70", frein = "26.67"}, 
    {name = "Vigero", costs = 25000, model = "vigero", vMax = "75.12", accel = "72.5", frein = "26.67"}, 
}

local toutterrain = {
    {name = "Bifta", costs = 45000, model = "bifta", vMax = "72.97", accel = "65", frein = "23.33"}, 
    {name = "Blazer", costs = 3000, model = "blazer", vMax = "67.07", accel = "62.5", frein = "33.33"}, 
    {name = "Blazer Street", costs = 10000, model = "blazer4", vMax = "67.07", accel = "62.5", frein = "33.33"}, 
    {name = "Brawler", costs = 75000, model = "brawler", vMax = "72.43", accel = "62.5", frein = "20.67"}, 
    {name = "Mesa v3", costs = 95000, model = "mesa3", vMax = "72.43", accel = "62.5", frein = "20.67"}, 
    {name = "Bubsta 6x6", costs = 150000, model = "dubsta3", vMax = "73.51", accel = "70", frein = "20"}, 
    {name = "Dune Buggy", costs = 18000, model = "dune", vMax = "72.43", accel = "62.5", frein = "21"}, 
    {name = "Rebel", costs = 15000, model = "rebel2", vMax = "69.75", accel = "50", frein = "20"}, 
    {name = "Sandking XL", costs = 43000, model = "sandking", vMax = "69.75", accel = "50", frein = "20"}, 
    {name = "Sandking", costs = 32000, model = "sandking2", vMax = "69.75", accel = "50", frein = "20"}, 
    {name = "Contender", costs = 150000, model = "contender", vMax = "69.75", accel = "50", frein = "20"}, 
    --{name = "The Liberator", costs = 6000000, model = "monster", vMax="59.02", accel="100", frein= "21.67"},
    {name = "Trophy Truck", costs = 350000, model = "trophytruck", vMax = "75.12", accel = "84.75", frein = "10"}, 
    {name = "Trophy Truck Dune", costs = 360000, model = "trophytruck2", vMax = "75.12", accel = "84.75", frein = "10"}, 
    --{name = "Motoneige", costs = 5000, model = "snowmob", vMax="80.01", accel="84.75", frein= "30.01"},
}

local suv = {
    {name = "Baller", costs = 20000, model = "baller", vMax = "72.43", accel = "67.5", frein = "20"}, 
    {name = "Baller LE", costs = 100000, model = "baller3", vMax = "72.43", accel = "67.5", frein = "20"}, 
    {name = "Baller LE LWB", costs = 120000, model = "baller4", vMax = "72.43", accel = "67.5", frein = "20"}, 
    {name = "Cavalcade", costs = 25000, model = "cavalcade", vMax = "68.14", accel = "50", frein = "20"}, 
    {name = "Granger", costs = 24000, model = "granger", vMax = "75.12", accel = "47.5", frein = "26.67"}, 
    {name = "Huntley S", costs = 40000, model = "huntley", vMax = "72.97", accel = "66.25", frein = "18.33"}, 
    {name = "Landstalker", costs = 20000, model = "landstalker", vMax = "72.43", accel = "45", frein = "26.67"}, 
    {name = "Radius", costs = 37000, model = "radi", vMax = "75.12", accel = "50", frein = "26.67"}, 
    {name = "Rocoto", costs = 20000, model = "rocoto", vMax = "74.58", accel = "47.5", frein = "8.33"}, 
    {name = "Seminole", costs = 10000, model = "seminole", vMax = "69.75", accel = "45", frein = "26.67"}, 
    {name = "XLS", costs = 20000, model = "xls", vMax = "70.82", accel = "65", frein = "19.33"}, 
}

local vans = {
    {name = "Bison", costs = 25000, model = "bison", vMax = "69.75", accel = "50", frein = "20"}, 
    {name = "Bobcat XL", costs = 20000, model = "bobcatxl", vMax = "69.75", accel = "45", frein = "26.67"}, 
    {name = "Gang Burrito", costs = 20000, model = "gburrito", vMax = "69.75", accel = "40", frein = "20"}, 
    {name = "Journey", costs = 60000, model = "journey", vMax = "53.66", accel = "32.5", frein = "8.33"}, 
    {name = "Minivan", costs = 10500, model = "minivan", vMax = "67.07", accel = "37.5", frein = "13.33"}, 
    {name = "Paradise", costs = 15500, model = "paradise", vMax = "69.75", accel = "42.5", frein = "13.33"}, 
    {name = "Rumpo", costs = 10500, model = "rumpo", vMax = "69.75", accel = "45", frein = "10"}, 
    {name = "Surfer", costs = 17500, model = "surfer", vMax = "53.66", accel = "25", frein = "10"}, 
    {name = "Youga", costs = 10500, model = "youga", vMax = "64.39", accel = "35", frein = "10"}, 
    {name = "FoodTruck", costs = 25500, model = "taco", vMax = "64.39", accel = "35", frein = "10"}, 
}

local sedans = {
    {name = "Asea", costs = 6000, model = "asea", vMax = "77.8", accel = "50", frein = "13.33"}, 
    {name = "Asterope", costs = 8000, model = "asterope", vMax = "77.8", accel = "50", frein = "30"}, 
    {name = "Fugitive", costs = 9000, model = "fugitive", vMax = "77.8", accel = "50", frein = "30"}, 
    {name = "Glendale", costs = 7000, model = "glendale", vMax = "78.87", accel = "58.75", frein = "21.67"}, 
    {name = "Ingot", costs = 6000, model = "ingot", vMax = "67.07", accel = "35", frein = "20"}, 
    {name = "Intruder", costs = 8000, model = "intruder", vMax = "77.8", accel = "50", frein = "30"}, 
    {name = "Premier", costs = 4500, model = "premier", vMax = "77.8", accel = "50", frein = "20"}, 
    {name = "Primo", costs = 5000, model = "primo", vMax = "75.12", accel = "50", frein = "30"}, 
    {name = "Primo Custom", costs = 5000, model = "primo2", vMax = "75.12", accel = "50", frein = "30"}, 
    --{name = "Primo Custom", costs = 12500, model = "primo2", vMax="75.12", accel="50", frein= "30"},
    {name = "Regina", costs = 5000, model = "regina", vMax = "64.39", accel = "35", frein = "20"}, 
    {name = "Schafter", costs = 75000, model = "schafter2", vMax = "77.8", accel = "50", frein = "30"}, 
    {name = "Schafter LWB", costs = 80000, model = "schafter4", vMax = "76.19", accel = "50", frein = "28.33"}, 
    {name = "Stanier", costs = 7000, model = "stanier", vMax = "75.12", accel = "50", frein = "30"}, 
    {name = "Stratum", costs = 5500, model = "stratum", vMax = "72.43", accel = "52.5", frein = "20"}, 
    {name = "Stretch", costs = 470000, model = "stretch", vMax = "72.43", accel = "42.5", frein = "26.67"}, 
    {name = "Super Diamond", costs = 40000, model = "superd", vMax = "77.8", accel = "65", frein = "20"}, 
    {name = "Surge", costs = 10000, model = "surge", vMax = "75.12", accel = "25", frein = "20"}, 
    {name = "Tailgater", costs = 13500, model = "tailgater", vMax = "77.8", accel = "50", frein = "30"}, 
    {name = "Warrener", costs = 9500, model = "warrener", vMax = "75.12", accel = "61.25", frein = "31.67"}, 
    {name = "Washington", costs = 8500, model = "washington", vMax = "75.12", accel = "50", frein = "30"}, 
    {name = "Cognoscenti", costs = 48000, model = "cognoscenti", vMax = "77.8", accel = "66.25", frein = "19"}, 
}

local motos = {
    --{name = "Balais", costs = 0, model = "nimbus16", vMax="75.12", accel="75", frein= "40"},
    {name = "FCR", costs = 30000, model = "fcr", vMax = "77.8", accel = "100", frein = "40"}, 
    {name = "FCR2", costs = 32000, model = "fcr2", vMax = "69.75", accel = "52.5", frein = "40"}, 
    {name = "Akuma", costs = 33000, model = "AKUMA", vMax = "77.8", accel = "100", frein = "40"}, 
    {name = "Bagger", costs = 3000, model = "bagger", vMax = "69.75", accel = "52.5", frein = "40"}, 
    {name = "Bati 801", costs = 25000, model = "bati", vMax = "80.48", accel = "75", frein = "46.67"}, 
    {name = "Bati 801RR", costs = 27000, model = "bati2", vMax = "80.48", accel = "75", frein = "46.67"}, 
    {name = "BF400", costs = 10000, model = "bf400", vMax = "77.8", accel = "72.5", frein = "36.67"}, 
    {name = "Carbon RS", costs = 35000, model = "carbonrs", vMax = "77.8", accel = "75", frein = "43.33"}, 
    {name = "Cliffhanger", costs = 35000, model = "cliffhanger", vMax = "79.14", accel = "79.5", frein = "36.67"}, 
    {name = "Daemon", costs = 6000, model = "daemon", vMax = "72.43", accel = "65", frein = "20"}, 
    {name = "Daemon Custom", costs = 7000, model = "daemon2", vMax = "72.43", accel = "65", frein = "20"}, 
    {name = "Wolfsbane", costs = 7000, model = "wolfsbane", vMax = "69.75", accel = "63.75", frein = "40"}, 
    {name = "Double T", costs = 23000, model = "double", vMax = "78.87", accel = "77.5", frein = "46.67"}, 
    {name = "Enduro", costs = 6000, model = "enduro", vMax = "63.85", accel = "72.5", frein = "36.67"}, 
    {name = "Faggio", costs = 5, model = "faggio2", vMax = "48.29", accel = "25", frein = "13.33"}, 
    {name = "Gargoyle", costs = 45000, model = "gargoyle", vMax = "78.87", accel = "78.13", frein = "36.67"}, 
    {name = "Hakuchou", costs = 30000, model = "hakuchou", vMax = "81.56", accel = "78.75", frein = "46.67"}, 
    {name = "Hexer", costs = 9000, model = "hexer", vMax = "72.43", accel = "65", frein = "33.33"}, 
    {name = "Innovation", costs = 75000, model = "innovation", vMax = "72.43", accel = "80", frein = "33.33"}, 
    {name = "Lectro", costs = 395000, model = "lectro", vMax = "75.12", accel = "70", frein = "40"}, 
    {name = "Nemesis", costs = 3000, model = "nemesis", vMax = "75.12", accel = "75", frein = "40"}, 
    {name = "Nightblade", costs = 28000, model = "nightblade", vMax = "75.12", accel = "75", frein = "40"}, 
    {name = "Diabolus", costs = 25000, model = "diablous", vMax = "76.46", accel = "78", frein = "40"}, 
    {name = "Diabolus 2.0", costs = 65000, model = "diablous2", vMax = "76.46", accel = "78", frein = "40"}, 
    {name = "Esskey", costs = 27000, model = "esskey", vMax = "77.8", accel = "73.75", frein = "40"}, 
    {name = "manchez", costs = 23000, model = "manchez", vMax = "77.8", accel = "73.75", frein = "40"}, 
    {name = "PCJ-600", costs = 5000, model = "pcj", vMax = "69.75", accel = "65", frein = "43.33"}, 
    {name = "Ruffian", costs = 16000, model = "ruffian", vMax = "75.12", accel = "85", frein = "36.67"}, 
    {name = "Sanchez", costs = 17000, model = "sanchez", vMax = "63.31", accel = "70", frein = "36.67"}, 
    {name = "Sovereign", costs = 25000, model = "sovereign", vMax = "72.43", accel = "67.5", frein = "36.67"}, 
    {name = "Thrust", costs = 57000, model = "thrust", vMax = "81.56", accel = "66.25", frein = "50"}, 
    {name = "Vader", costs = 2000, model = "vader", vMax = "75.12", accel = "67.5", frein = "36.67"}, 
    {name = "Zombie Bobber", costs = 8000, model = "zombiea", vMax = "73.51", accel = "72.5", frein = "26.67"}, 
    {name = "Zombie Chopper", costs = 8000, model = "zombieb", vMax = "73.51", accel = "72.5", frein = "26.67"}, 
    {name = "Vindicator", costs = 25000, model = "vindicator", vMax = "81.56", accel = "66.25", frein = "50"}, 
}
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------

function Main(Job_I)
    if(Job_I ~= nil and Job_I ~= "") then Job_ID = Job_I end
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Loca'Luxe"
    options.menu_subtitle = "Vente et Location"
    Menu.selection = 1
    Menu.addButton("Louer un véhicule", "MenuSortirVeh", nil)
    Menu.addButton("Vendre un véhicule", "MenuVenteVeh", nil)
    Menu.addButton("Transférer un véhicule", "TransfertVeh", nil)
    Menu.addButton("Gérer les locations", "MenuLoc", nil)
    --Menu.addButton("Supprimer le véhicule", "SupprimerVeh", nil)
    --Menu.addButton("Afficher les véhicules", "MenuAffichVeh", nil)
end
-----------------------------------------
-- MENU PRINCIPAUX --
-----------------------------------------
-- MENU GESTION LOCATION --
function MenuLoc()
    TriggerServerEvent("concessionnaire:CheckLocation")
end

RegisterNetEvent('concessionnaire:MenuLocation')
AddEventHandler('concessionnaire:MenuLocation', function(ListeLoc)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Loca'Luxe"
    options.menu_subtitle = "Locations"
    Menu.selection = 1
    for i, c in pairs(ListeLoc) do
        Menu.addButton(ListeLoc[i].nom .. " " .. ListeLoc[i].prenom .. " (" .. ListeLoc[i].vehicle_name .. ")", "GestionDLoc", {nom = ListeLoc[i].nom, prenom = ListeLoc[i].prenom, veh = ListeLoc[i].vehicle_name})
    end
end)
RegisterNetEvent('concessionnaire:RetourMenu')
AddEventHandler('concessionnaire:RetourMenu', function()
    Main(25)
end)

function GestionDLoc(location)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Location"
    options.menu_subtitle = "Gestion"
    Menu.previous = "MenuLoc"
    Menu.selection = 1
    Menu.addButton("Supprimer " .. location.veh, "DeleteLocation", {nom = location.nom, prenom = location.prenom, veh = location.veh})
    Menu.addButton("Retour", "MenuLoc", 1)
end

function DeleteLocation(location)
    TriggerServerEvent("concessionnaire:Delete", location.nom, location.prenom, location.veh)
end

-- MENU LOCATION/DEMONSTRATION --
function MenuSortirVeh()
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Sortir"
    options.menu_subtitle = "Démonstration"
    Menu.previous = "Main"
    Menu.selection = 1
    Menu.addButton("Voiture", "ListeVeh", 1)
    Menu.addButton("Motos", "ListeMoto", 1)
end
-- MENU VENTE --
function MenuVenteVeh()
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Vendre"
    options.menu_subtitle = "Vente"
    Menu.previous = "Main"
    Menu.selection = 1
    Menu.addButton("Voiture", "ListeVeh", 2)
    Menu.addButton("Motos", "ListeMoto", 2)
end

function MenuTransVeh()
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Transfert"
    options.menu_subtitle = "Vente"
    Menu.previous = "Main"
    Menu.selection = 1
    Menu.addButton("Voiture", "ListeVeh", 2)
    Menu.addButton("Motos", "ListeMoto", 2)
end
-- MENU AFFICHAGE EXTERIEUR/INTERIEUR --
function MenuAffichVeh()
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Sotir"
    options.menu_subtitle = "Vitrine"
    Menu.previous = "Main"
    Menu.selection = 1
    Menu.addButton("Afficher les véhicules extérieurs", "AfficherVehiculesExternes", nil)
    Menu.addButton("Afficher les véhicules intérieurs", "AfficherVehiculesInternes", nil)
end

------------------------------------------
-- LOCATION/DEMONSTRATION DES VEHICULES --
------------------------------------------
function LocationVeh(model)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Louer"
    options.menu_subtitle = "Louer"
    Menu.previous = "MenuSortirVeh"
    Menu.selection = 1
    Menu.addButton("Louer : "..model.model, "LouerModel", model)
    Menu.addButton("Retour", "MenuSortirVeh", 1)
end

------------------------------------------
-- VENTE DES VEHICULES --
------------------------------------------
function VenteVeh(model)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Vendre"
    options.menu_subtitle = "Vendre"
    Menu.previous = "MenuVenteVeh"
    Menu.selection = 1
    Menu.addButton("Vendre: "..model.model, "VendreModel", model)
    Menu.addButton("Retour", "MenuVenteVeh", 1)
end
-----------------------------------------
-- AFFICHAGE DES VEHICULES --
-----------------------------------------
function ListeVeh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Sortir"
    options.menu_subtitle = "Démonstration"
    Menu.previous = "Main"
    Menu.selection = 1
    Menu.addButton("Compacts", "Compactveh", id)
    Menu.addButton("Coupés", "Coupesveh", id)
    Menu.addButton("Sedans", "Sedansveh", id)
    Menu.addButton("Sports", "Sportsveh", id)
    Menu.addButton("Sports Classics", "ClassSportveh", id)
    Menu.addButton("SuperCars", "Superveh", id)
    Menu.addButton("Muscle", "Muscleveh", id)
    Menu.addButton("Tout-terrain", "TouTerveh", id)
    Menu.addButton("SUV", "SUVeh", id)
    Menu.addButton("Vans", "Vansveh", id)
end

function ListeMoto(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Motos"
    options.menu_subtitle = "Motos"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(motos) do
            Menu.addButton(motos[i].name, "LocationVeh", {model = motos[i].model, price = motos[i].costs})
        end
    else
        for i, c in pairs(motos) do
            Menu.addButton(motos[i].name .. " (" ..motos[i].costs .. " $)", "VenteVeh", {model = motos[i].model, price = motos[i].costs})
        end
    end
end

function Vansveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Vans"
    options.menu_subtitle = "Vans"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(vans) do
            Menu.addButton(vans[i].name, "LocationVeh", {model = vans[i].model, price = vans[i].costs})
        end
    else
        for i, c in pairs(vans) do
            Menu.addButton(vans[i].name .. " (" ..vans[i].costs .. " $)", "VenteVeh", {model = vans[i].model, price = vans[i].costs})
        end
    end
end

function SUVeh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "SUV"
    options.menu_subtitle = "SUV"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(suv) do
            Menu.addButton(suv[i].name, "LocationVeh", {model = suv[i].model, price = suv[i].costs})
        end
    else
        for i, c in pairs(suv) do
            Menu.addButton(suv[i].name .. " (" ..suv[i].costs .. " $)", "VenteVeh", {model = suv[i].model, price = suv[i].costs})
        end
    end
end

function TouTerveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Tout-Terrain"
    options.menu_subtitle = "Tout-Terrain"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(toutterrain) do
            Menu.addButton(toutterrain[i].name, "LocationVeh", {model = toutterrain[i].model, price = toutterrain[i].costs})
        end
    else
        for i, c in pairs(toutterrain) do
            Menu.addButton(toutterrain[i].name .. " (" ..toutterrain[i].costs .. " $)", "VenteVeh", {model = toutterrain[i].model, price = toutterrain[i].costs})
        end
    end
end

function Muscleveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Muscle"
    options.menu_subtitle = "Muscle"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(muscle) do
            Menu.addButton(muscle[i].name, "LocationVeh", {model = muscle[i].model, price = muscle[i].costs})
        end
    else
        for i, c in pairs(muscle) do
            Menu.addButton(muscle[i].name .. " (" ..muscle[i].costs .. " $)", "VenteVeh", {model = muscle[i].model, price = muscle[i].costs})
        end
    end
end

function Superveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Supercars"
    options.menu_subtitle = "Supercars"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(supercars) do
            Menu.addButton(supercars[i].name, "LocationVeh", {model = supercars[i].model, price = supercars[i].costs})
        end
    else
        for i, c in pairs(supercars) do
            Menu.addButton(supercars[i].name .. " (" ..supercars[i].costs .. " $)", "VenteVeh", {model = supercars[i].model, price = supercars[i].costs})
        end
    end
end

function ClassSportveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Sport Classics"
    options.menu_subtitle = "Sport Classics"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(sportclassics) do
            Menu.addButton(sportclassics[i].name, "LocationVeh", {model = sportclassics[i].model, price = sportclassics[i].costs})
        end
    else
        for i, c in pairs(sportclassics) do
            Menu.addButton(sportclassics[i].name .. " (" ..sportclassics[i].costs .. " $)", "VenteVeh", {model = sportclassics[i].model, price = sportclassics[i].costs})
        end
    end
end

function Compactveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Compacts"
    options.menu_subtitle = "Compacts"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(compacts) do
            Menu.addButton(compacts[i].name, "LocationVeh", {model = compacts[i].model, price = compacts[i].costs})
        end
    else
        for i, c in pairs(compacts) do
            Menu.addButton(compacts[i].name .. " (" ..compacts[i].costs .. " $)", "VenteVeh", {model = compacts[i].model, price = compacts[i].costs})
        end
    end
end

function Coupesveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Coupes"
    options.menu_subtitle = "Coupes"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(coupes) do
            Menu.addButton(coupes[i].name, "LocationVeh", {model = coupes[i].model, price = coupes[i].costs})
        end
    else
        for i, c in pairs(coupes) do
            Menu.addButton(coupes[i].name .. " (" ..coupes[i].costs .. " $)", "VenteVeh", {model = coupes[i].model, price = coupes[i].costs})
        end
    end
end

function Sportsveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Sports"
    options.menu_subtitle = "Sports"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(sports) do
            Menu.addButton(sports[i].name, "LocationVeh", {model = sports[i].model, price = sports[i].costs})
        end
    else
        for i, c in pairs(sports) do
            Menu.addButton(sports[i].name .. " (" ..sports[i].costs .. " $)", "VenteVeh", {model = sports[i].model, price = sports[i].costs})
        end
    end
end

function Sedansveh(id)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Sedans"
    options.menu_subtitle = "Sedans"
    Menu.previous = "Main"
    Menu.selection = 1
    if id == 1 then
        for i, c in pairs(sedans) do
            Menu.addButton(sedans[i].name, "LocationVeh", {model = sedans[i].model, price = sedans[i].costs})
        end
    else
        for i, c in pairs(sedans) do
            Menu.addButton(sedans[i].name .. " (" ..sedans[i].costs .. " $)", "VenteVeh", {model = sedans[i].model, price = sedans[i].costs})
        end
    end
end

local options = {
    x = 0.1, 
    y = 0.2, 
    width = 0.2, 
    height = 0.04, 
    scale = 0.4, 
    font = 0, 
    menu_title = "Loca'Luxe", 
    color_r = 30, 
    color_g = 144, 
    color_b = 255, 
}

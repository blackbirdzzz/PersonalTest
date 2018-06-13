--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

local Menu = {}
local itemMenuGeneralPolice = {}
local itemMenuChoixPoliceService = {}
local itemMenuChoixPoliceVehicle = {}

local UrgencePoliceMenu = {['Title'] = 'Missions en cours',  ['SubMenu'] = {
    ['Title'] = 'Missions en cours', ['Items'] = {
        {['Title'] = 'Retour', ['ReturnBtn'] = true },
        {['Title'] = 'Fermer'}
}}}

function updateMenuPolice(newUrgenceMenu)
    itemMenuGeneralPolice.Items[1] = newUrgenceMenu
end

function openMenuPoliceGeneral() 
    Menu.item = itemMenuGeneralPolice
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixPoliceVehicleCar()
    Menu.item = itemMenuChoixPoliceVehicleCar
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixPoliceVehicleHeli()
    Menu.item = itemMenuChoixPoliceVehicleHeli
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuArmurerie()
    Menu.item = itemMenuArmurerie
    Menu.isOpen = true
    Menu.initMenu()
end
function MenuChoixPoliceService()
    Menu.item = itemMenuChoixPoliceService
    Menu.isOpen = true
    Menu.initMenu()
end


itemMenuGeneralPolice = {
    ['Title'] = 'Police',
    ['Items'] = {
        UrgencePoliceMenu,
        {['Title'] = 'Amendes',  ['SubMenu'] = {
            ['Title'] = 'Amendes', 
            ['Items'] = {
			   {['Title'] = 'Crimes',  ['SubMenu'] = {
                    ['Title'] = 'Code Pénal - Crimes', 
                    ['Items'] = {
                        {['Title'] = '6.A/ Prise d\'otages : ~r~200.000$', ['Function'] = POLICE_FINE_DATA, tarif = 200000},
                        {['Title'] = '6.B/ Assassinat : ~r~300.000$', ['Function'] = POLICE_FINE_DATA, tarif = 300000},
                        {['Title'] = '6.D/ Chef Orga Criminelle : ~r~200.000$', ['Function'] = POLICE_FINE_DATA, tarif = 200000},
                        {['Title'] = '6.D/ Membre Orga Criminelle : ~r~150.000$', ['Function'] = POLICE_FINE_DATA, tarif = 150000},                        
                        {['Title'] = '6.E/ Tentative d\'homicide : ~r~300.000$', ['Function'] = POLICE_FINE_DATA, tarif = 300000},
                        {['Title'] = '6.F/ Enlèvement, séquestration : ~r~250.000$', ['Function'] = POLICE_FINE_DATA, tarif = 250000},
                        {['Title'] = '6.G/ Braquage - Vol à mains armé ~r~15.000$', ['Function'] = POLICE_FINE_DATA, tarif = 15000},
                        {['Title'] = '6.H/ Homicide involontaire : ~r~100.000$', ['Function'] = POLICE_FINE_DATA, tarif = 100000}                                           
                    }
                }},
                {['Title'] = 'Délits majeurs',  ['SubMenu'] = {
                    ['Title'] = 'Code Pénal - Délits majeurs', 
                    ['Items'] = {
                        {['Title'] = '5.A/ Vol véhicule d\'urgence : ~r~50.000$', ['Function'] = POLICE_FINE_DATA, tarif = 50000},
                        {['Title'] = '5.B/ Evasion : ~r~50.000$', ['Function'] = POLICE_FINE_DATA, tarif = 50000},   
                        {['Title'] = '5.C/ Complicité d\'évasion : ~r~30.000$', ['Function'] = POLICE_FINE_DATA, tarif = 30000},  
						{['Title'] = '5.D/ Corruption : ~r~15.000$', ['Function'] = POLICE_FINE_DATA, tarif = 15000},          
                        {['Title'] = '5.E/ Recel : ~r~10.000$', ['Function'] = POLICE_FINE_DATA, tarif = 10000},		
                        {['Title'] = '5.F/ Vol bateaux, avions, hélico : ~r~50.000$', ['Function'] = POLICE_FINE_DATA, tarif = 50000},     
                        {['Title'] = '5.G/ Trafic munition, pièce d\'arme : ~r~15.000$', ['Function'] = POLICE_FINE_DATA, tarif = 15000},   
						{['Title'] = '5.H/ Vol véhicule: ~r~40.000$', ['Function'] = POLICE_FINE_DATA, tarif = 40000},                 
						{['Title'] = '5.I/ Coups et blessures sur LSPD : ~r~50.000$', ['Function'] = POLICE_FINE_DATA, tarif = 50000},	
						{['Title'] = '5.J/ Coups et blessures : ~r~20.000$', ['Function'] = POLICE_FINE_DATA, tarif = 20000},
                        {['Title'] = '5.K/ Usurpations : ~r~20.000$', ['Function'] = POLICE_FINE_DATA, tarif = 20000},		
                        {['Title'] = '5.L/ Vol : ~r~20.000$', ['Function'] = POLICE_FINE_DATA, tarif = 20000},   
                        {['Title'] = '5.M/ Diffamation : ~r~15.000$', ['Function'] = POLICE_FINE_DATA, tarif = 15000},     
                        {['Title'] = '5.N/ Escroquerie : ~r~1.500$', ['Function'] = POLICE_FINE_DATA, tarif = 1500},   
                        {['Title'] = '5.O/ Mise en danger d\'autrui : ~r~10.000$', ['Function'] = POLICE_FINE_DATA, tarif = 10000},     
                        {['Title'] = '5.P/ Entrave aux secours : ~r~25.000$', ['Function'] = POLICE_FINE_DATA, tarif = 25000}, 
                        {['Title'] = '5.Q/ Refus d\'obtempéré : ~r~5000$', ['Function'] = POLICE_FINE_DATA, tarif = 5000},  
                        {['Title'] = '5.R/ Outrage : ~r~15.000$', ['Function'] = POLICE_FINE_DATA, tarif = 15000},                                                                                                                                                  															                                               				                                                           
                        {['Title'] = '5.S/ Trafic d\'Organe : ~r~100.000$', ['Function'] = POLICE_FINE_DATA, tarif = 100000},
                        {['Title'] = '5.T/ Trafic de stups : ~r~50.000$ ', ['Function'] = POLICE_FINE_DATA, tarif = 50000},
                        {['Title'] = '5.U/ Trafic d\'arme : ~r~5.000.000$ ', ['Function'] = POLICE_FINE_DATA, tarif = 5000000},
                        {['Title'] = '5.V/ Défaut de permis d\'arme : ~r~15.000$ ', ['Function'] = POLICE_FINE_DATA, tarif = 15000}                        
                    }
                }},
				{['Title'] = 'Délits de possession',  ['SubMenu'] = {
                    ['Title'] = 'Code Pénal - Délits de possession',
					['Items'] = {
					    {['Title'] = '4.A/ Possession d\'arme', ['Function'] = POLICE_FINE_WEAPONS},
                        {['Title'] = '4.B/ Possession de drogue', ['Function'] = POLICE_FINE_DRUGS},
						{['Title'] = '4.C/ Possession d\'organe', ['Function'] = POLICE_FINE_ORGAN},
						{['Title'] = '4.D/ Possession d\'argent sale', ['Function'] = POLICE_FINE_DIRTYMONEY},
                        {['Title'] = '4.D/ Blanchiment : ~r~50.000.000$', ['Function'] = POLICE_FINE_DATA, tarif = 50000000}   						
					}
				}},
				{['Title'] = 'Délits mineurs',  ['SubMenu'] = { 
                    ['Title'] = 'Code Pénal - Délits mineurs',
                    ['Items'] = {
                        {['Title'] = '3.A/ Harcèlement : ~r~5.000$', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                        {['Title'] = '3.B/ Entraves à la justice : ~r~15.000$', ['Function'] = POLICE_FINE_DATA, tarif = 15000},
                        {['Title'] = '3.C/ Rébellion  : ~r~5.000$', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
						{['Title'] = '3.D/ Destructions de biens : ~r~2.500$', ['Function'] = POLICE_FINE_DATA, tarif = 2500},
                        {['Title'] = '3.E/ Manifestations : ~r~5.000$', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                        {['Title'] = '3.F/ Abus de faiblesse : ~r~1.000$', ['Function'] = POLICE_FINE_DATA, tarif = 1000},
                        {['Title'] = '3.G/ Délit de fuite à pied : ~r~10.000$', ['Function'] = POLICE_FINE_DATA, tarif = 10000},
                        {['Title'] = '3.H/ Atteintes aux morts : ~r~5000$', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                        {['Title'] = '3.I/ Menaces (hors outrage) : ~r~25.000$', ['Function'] = POLICE_FINE_DATA, tarif = 25000},
                        {['Title'] = '3.J/ Dissimulation du visage : ~r~2.500$', ['Function'] = POLICE_FINE_DATA, tarif = 2500},
                        {['Title'] = '3.K/ Violences verbales : ~r~10.000$', ['Function'] = POLICE_FINE_DATA, tarif = 10000}
                    }
                }},
				{['Title'] = 'Code de la Route',  ['SubMenu'] = { 
                    ['Title'] = 'Code de la route', 
                    ['Items'] = {
                        {['Title'] = '2.A/ Défaut de phares : ~r~50$', ['Function'] = POLICE_FINE_DATA, tarif = 50},
                        {['Title'] = '2.B/ Non-respect des distances : ~r~100$', ['Function'] = POLICE_FINE_DATA, tarif = 100},
                        {['Title'] = '2.C/ Stationnement gênant : ~r~100$', ['Function'] = POLICE_FINE_DATA, tarif = 100},
                        {['Title'] = '2.D/ Défaut de casque : ~r~100$', ['Function'] = POLICE_FINE_DATA, tarif = 100},
                        {['Title'] = '2.E/ Chevauchement ligne continue : ~r~150$', ['Function'] = POLICE_FINE_DATA, tarif = 150},
                        {['Title'] = '2.F/ Sens interdit / Contre-sens : ~r~2.000$', ['Function'] = POLICE_FINE_DATA, tarif = 2000},
                        {['Title'] = '2.G/ Dépassement dangereux : ~r~250$', ['Function'] = POLICE_FINE_DATA, tarif = 250}, 
                        {['Title'] = '2.H/ Refus de priorité : ~r~250$', ['Function'] = POLICE_FINE_DATA, tarif = 250},     
                        {['Title'] = '2.I/ Conduite emprise de stups : ~r~3.000$', ['Function'] = POLICE_FINE_DATA, tarif = 3000}, 
                        {['Title'] = '2.J/ Conduite emprise d\'alcool : ~r~3.000$', ['Function'] = POLICE_FINE_DATA, tarif = 3000},   
                        {['Title'] = '2.K/ Bande d\'arrêt d\'urgence : ~r~700$', ['Function'] = POLICE_FINE_DATA, tarif = 700},   
                        {['Title'] = '2.L/ Feu rouge ou Stop : ~r~500$', ['Function'] = POLICE_FINE_DATA, tarif = 500},   
                        {['Title'] = '2.M/ Véhicule endommagé : ~r~500$', ['Function'] = POLICE_FINE_DATA, tarif = 500},   
						{['Title'] = '2.N/ Conduite dangereuse : ~r~500$', ['Function'] = POLICE_FINE_DATA, tarif = 500}, 
                        {['Title'] = '2.O/ Délit de fuite en véhicule : ~r~30.000$', ['Function'] = POLICE_FINE_DATA, tarif = 30000},   
                      --{['Title'] = '2.P/ Conduite sans permis :', ['Function'] = POLICE_FINE_DATA, tarif = },                                                                                                                                                                                                             
                      --{['Title'] = '65/ Usage d\'un téléphone : ~r~150$', ['Function'] = POLICE_FINE_DATA, tarif = 150},
                      --{['Title'] = '66/ Clignotant : ~r~150$', ['Function'] = POLICE_FINE_DATA, tarif = 150},
                      --{['Title'] = '79/ Défaut d\'assurance :', ['Function'] = POLICE_FINE_DATA, tarif = },
                        {['Title'] = '2.Q/ Excès de vitesse', ['Function'] = POLICE_FINE_SPEED}
                    }
                }},
            }
        }},
        {['Title'] = 'Signalisations',  ['SubMenu'] = { 
                    ['Title'] = 'Signalisations', 
                    ['Items'] = {
                        {['Title'] = 'Cône de signalisation', ['Function'] = SpawnCone},
                        {['Title'] = 'Barrière en métal', ['Function'] = SpawnMetalb},
                        {['Title'] = 'Barrière de police', ['Function'] = SpawnPoliceb},
                        {['Title'] = 'Herse', ['Function'] = SpawnHerse},
                        --{['Title'] = 'Retirer le dernier cone', ['Function'] = },
                        --{['Title'] = 'Retirer TOUS les cones', ['Function'] = },
                        --{['Title'] = 'Retirer la dernière barrière de métal', ['Function'] = },
                        --{['Title'] = 'Retirer TOUTES les barrières de métal', ['Function'] = },
                        --{['Title'] = 'Retirer la dernière barrière de police', ['Function'] = },
                        --{['Title'] = 'Retirer TOUTES les barrières de police', ['Function'] = },
                        --{['Title'] = 'Retirer TOUTES les herses', ['Function'] = },
                        {['Title'] = 'RETIRER TOUTES LES SIGNALISATIONS', ['Function'] = RemoveAllProps}
                    }
                }},
		{['Title'] = 'Fouiller', ['Function'] = POLICE_Check},
		{['Title'] = 'Ethylotest', ['Event'] = 'ambulancier:ethylotest'},
		{['Title'] = 'Menoter', ['Function'] = POLICE_Cuffed},
		{['Title'] = 'Attraper', ['Function'] = POLICE_Drag},
		{['Title'] = 'Retirer les armes', ['Function'] = POLICE_DropWeapons},
        {['Title'] = 'Placer dans le véhicle', ['Function'] = POLICE_PutInVehicle},
        {['Title'] = 'Sortir du véhicule', ['Function'] = POLICE_UnseatVehicle},
        {['Title'] = 'Crocheter', ['Function'] = POLICE_Crocheter},
        {['Title'] = 'Verifier la plaque', ['Function'] = POLICE_Plate},
		{['Title'] = 'Placer un Radar', ['Function'] = POLICE_radar},
		{['Title'] = 'Supprimer le Vehicule', ['Function'] = POLICE_deleteVehicle}
		
    }
}

itemMenuChoixPoliceVehicleCar = {
    ['Title'] = 'Police - Choix du véhicule',
    ['Items'] = {
		--[[
        --{['Title'] = 'Vapid Police Cruiser (Stanier)', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police'},
		{['Title'] = 'Bravado Police Buffalo', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police2'},
		--{['Title'] = 'Vapid Police Interceptor', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police3'},
		--{['Title'] = 'Vapid Cruiser Banalisée (Stanier)', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police4'},
		{['Title'] = 'Dodge Charger', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police5'},
		{['Title'] = 'Chevy "K9" Tahoe', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police6'},
		--{['Title'] = 'Ford Victoria Crown', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police7'},
		{['Title'] = 'Chevy Impala', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police8'},
		{['Title'] = 'Ford Explorer', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police9'},
		{['Title'] = 'Ford Taurus', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police10'},
        {['Title'] = 'WMC Police Moto', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'policeb'},
        {['Title'] = 'Declasse Police Transporter', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'policet'},
		{['Title'] = 'Brute Police Riot', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'riot'},
		--{['Title'] = 'Vapid Sheriff Cruiser (Stanier)', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'sheriff'},
		{['Title'] = 'Bravado FIB Buffalo', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'fbi'},
		{['Title'] = 'Declasse FIB Granger', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'fbi2'},
		--{['Title'] = 'Declasse Sheriff Granger', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'sheriff2'},
		{['Title'] = 'Declasse Park Ranger Granger', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'pranger'},
		{['Title'] = 'Vapid BPSP Prison Bus', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'pbus'}
        ]]
        --{['Title'] = 'LSPD Oracle XS', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police11'},
        {['Title'] = 'LSPD Penacle', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police9'},
        {['Title'] = 'LSPD Jackal', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police10'},
        {['Title'] = 'Bravado Police Buffalo', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police2'},
        {['Title'] = 'LSPD Radius', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police13'},
        {['Title'] = 'WMC Police Moto', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'policeb'},
        {['Title'] = 'Declasse Sheriff Granger', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'sheriff2'},
        {['Title'] = 'FIB Oracle', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'fbi3'},
        {['Title'] = 'Bravado FIB Buffalo', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'fbi'},
        {['Title'] = 'Declasse FIB Granger', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'fbi2'},
        {['Title'] = 'FIB Pony', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'police14'},
        {['Title'] = 'LSPD Bullet', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'bulpolice'},
        {['Title'] = 'FIB Bullet', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'bulpolice3'},
        {['Title'] = 'HWay Bullet', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'bulhway2'},
        --{['Title'] = 'LSPD Infernus', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'infpolice'},
        --{['Title'] = 'FIB Infernus', ['Function'] = POLICE_SpanwVehicleCar, type = 'Car', model = 'infpolice2'},
        {['Title'] = 'Declasse Police Transporter', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'policet'},
        {['Title'] = 'Brute Police Riot', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'riot'},
        --{['Title'] = 'Declasse Park Ranger Granger', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'pranger'},
        {['Title'] = 'Vapid BPSP Prison Bus', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'pbus'}
    }
}

itemMenuChoixPoliceVehicleHeli = {
    ['Title'] = 'Police - Choix du véhicule',
    ['Items'] = {
        {['Title'] = 'Police Maverick', ['Function'] = POLICE_invokeVehicle, type = 'Chopper', model = 'polmav'},
        {['Title'] = 'Police Buzzard', ['Function'] = POLICE_invokeVehicle, type = 'Chopper', model = 'buzzard2'},
         {['Title'] = 'Ranger l\'hélicoptère', ['Function'] = POLICE_deleteHelicouptere}
    }
}

itemMenuArmurerie = {
    ['Title'] = 'Police - Armurerie',
    ['Items'] = {
        {['Title'] = '-Fusil à Pompe-',['Function'] = mettrearme, weapon = GetHashKey("WEAPON_PUMPSHOTGUN"), ammo=150, text = "un fusil à pompe"},
        {['Title'] = 'Lampe',['Function'] = mettreaccessoire, weapon = GetHashKey("WEAPON_PUMPSHOTGUN"), component = GetHashKey("COMPONENT_AT_AR_FLSH"), text = "une lampe tactique"},
        {['Title'] = '-Carabine-',['Function'] = mettrearme, weapon = GetHashKey("WEAPON_CARBINERIFLE"),ammo=200, text = "une carabine"},
        {['Title'] = 'Lampe',['Function'] = mettreaccessoire, weapon = GetHashKey("WEAPON_CARBINERIFLE"), component = GetHashKey("COMPONENT_AT_AR_FLSH"), text = "une lampe tactique"},
        {['Title'] = 'Poignée',['Function'] = mettreaccessoire, weapon = GetHashKey("WEAPON_CARBINERIFLE"), component =GetHashKey("COMPONENT_AT_AR_AFGRIP"), text = "une poignée pour carabine"},
        {['Title'] = 'Lunette',['Function'] = mettreaccessoire, weapon = GetHashKey("WEAPON_CARBINERIFLE"), component =GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"), text = "une lunette pour carabine"},
        {['Title'] = '-Fusil à Lunette-',['Function'] = mettrearme, weapon = GetHashKey("WEAPON_SNIPERRIFLE"),ammo=30, text = "une lunette pour carabine"},
        {['Title'] = 'Lunette amélioré',['Function'] = mettreaccessoire, weapon = GetHashKey("WEAPON_SNIPERRIFLE"), component = 0xBC54DA77, text = "une lunette puissante"},
        {['Title'] = '-Gaz soporifique-',['Function'] = mettrearme, weapon = GetHashKey("WEAPON_SMOKEGRENADE"),ammo=5, text = "du gaz soporifique"},
		{['Title'] = '-Recharge Extincteur-',['Function'] = mettrearme, weapon = GetHashKey("WEAPON_FIREEXTINGUISHER"),ammo=10, text = "une recharge d'extincteur"},
		{['Title'] = '-Rendre les armes-',['Function'] = removeweapon}
    }
}


itemMenuChoixPoliceService = {
    ['Title'] = 'Police - Vest',
    ['Items'] = {
        {['Title'] = 'Prendre le service', ['Function'] = takeService},
        {['Title'] = 'Prendre le service ( Investigation ) ', ['Function'] = takeServiceInvestigation},
        {['Title'] = 'Mettre le gillet par balles', ['Function'] = equipeVest, type = 'Bulletproof jacket'},
        {['Title'] = 'Retirer le giller par balles', ['Function'] = equipeVest, type = 'Take offbulletproof jacket'},
        {['Title'] = "Mettre chasuble jaune", ['Function'] = equipeVest, type = 'High-visibility clothing'},
        {['Title'] = "Retirer chasuble Jaune", ['Function'] = equipeVest, type = 'Take off High-visibility clothing'},
        {['Title'] = 'Quitter le service', ['Function'] = finishService}
    }
}


--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 0, 0, 10, 190 }
Menu.backgroundColorActive = { 255, 255, 255, 190 }
Menu.titleTextColor = { 255, 255, 255, 190 }
Menu.titleBackgroundColor = { 50, 0, 10, 190 }
Menu.textColor = { 255, 255, 255, 190 }
Menu.textColorActive = { 0, 0, 10, 190 }

Menu.keyOpenMenu = 170 -- N+
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel
Menu.IgnoreNextKey = false
Menu.posX = 0.05
Menu.posY = 0.05

Menu.ItemWidth = 0.26
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 4
    scale = scale or 0.43
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.titleBackgroundColor)    
    Menu.initText(Menu.titleTextColor, 7, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY+0.01)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(value.TextColor or Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    Menu.currentPos = {1}
    Menu.IgnoreNextKey = true 
end

function Menu.keyControl()
    if Menu.IgnoreNextKey == true then
        Menu.IgnoreNextKey = false 
        return
    end
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].ReturnBtn == true then
                table.remove(Menu.currentPos)
                if #Menu.currentPos == 0 then
                    Menu.isOpen = false 
                end
            else
                if cMenu.Items[cSelect].Function ~= nil then
                    cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Event ~= nil then
                    TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                    Menu.isOpen = false
                end
            end
        end
    end

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.isOpen = false
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
	end
end)

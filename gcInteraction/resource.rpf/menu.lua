--====================================================================================
-- #Author: Jonathan D @ Gannon
--
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================





--===================================================================================================================================================--
--                Build Menu -- playAmination = joue l'aniamtion une fois et playAminationLoop pour jouer l'animation en boucle.                     --
-- site des emotes = http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm#amb@code_human_wander_idles_cop@male@staticSection --
--===================================================================================================================================================--
local KeyOpenJobsMenu = 166 -- F5
local currentJobs = ''
local hasMenuJob = false
local CanPlayEmote = true
RegisterNetEvent('metiers:updateJob')
AddEventHandler('metiers:updateJob', function(nameJob)
    if hasMenuJob then
        table.remove(Menu.item.Items, 1)
    end
    hasMenuJob = false

    if nameJob == 'Policier' or
       nameJob == 'Ambulancier' or
       nameJob == 'Taxi' or
       nameJob == 'Mecano' or
	   nameJob == 'Journaliste' then
       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJob, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       --Citizen.Trace('-----------------------')
    end
    if nameJob == 'Policier' then
        currentJobs = 'police'
    else
        currentJobs = string.lower(nameJob)
    end
end)

function openMenuJobs()
    TriggerEvent(currentJobs .. ':openMenu')
end

Menu = {}
Menu.item = {
    ['Title'] = 'Interactions',
    ['Items'] = {
        {['Title'] = 'Identité / Permis', ['SubMenu'] = {
            ['Title'] = 'Identité / Permis',
                ['Items'] = {
                    { ['Title'] = 'Regarder sa carte d\'identité', ['Event'] = 'gcl:openMeIdentity'},
					{ ['Title'] = 'Montrer carte d\'identité', ['Event'] = 'gcl:showItentity'}
                }
            }
        },
        {['Title'] = 'Animations', ['SubMenu'] = {
            ['Title'] = 'Animations',
            ['Items'] = {
                { ['Title'] = 'Rester les bras tendu', Function = playAnimationLoop, dictionaries = "nm@hands", clip = 'flail', ['Close'] = false },
                { ['Title'] = 'Saluts', ['SubMenu'] = {
                    ['Title'] = 'Animations - Saluts',
                    ['Items'] = {
                        { ['Title'] = "Serrer la main", Function = playAnimation ,  dictionaries = "mp_common", clip = 'givetake1_a', ['Close'] = false },
                        { ['Title'] = "Dire bonjour",   Function = playAnimation ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_hello", ['Close'] = false },
                        { ['Title'] = "Tappes m'en 5", Function = playAnimation , dictionaries = "mp_ped_interaction", clip = "highfive_guy_a", ['Close'] = false },
                        { ['Title'] = "Salut militaire", Function = playAnimation , dictionaries = "mp_player_int_uppersalute", clip = "mp_player_int_salute", ['Close'] = false }
                    }
                }},
                { ['Title'] = 'Humeur', ['SubMenu'] = {
                    ['Title'] = 'Animations - Humeurs',
                    ['Items'] = {
                        { ['Title'] = "Applaudir", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_CHEERING", ['Close'] = false},
                        { ['Title'] = "Branleur", Function = playAnimation ,  dictionaries = "mp_player_int_upperwank", clip = "mp_player_int_wank_01", ['Close'] = false },
                        { ['Title'] = "Zut !", Function = playAnimation ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_damn", ['Close'] = false },
                        { ['Title'] = "Calme toi ", Function = playAnimation ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_easy_now", ['Close'] = false },
                        { ['Title'] = "Pas question !", Function = playAnimation ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_no_way", ['Close'] = false },
                        { ['Title'] = "Doigt d'honneur", Function = playAnimation ,  dictionaries = "mp_player_int_upperfinger", clip = "mp_player_int_finger_01_enter", ['Close'] = false },
						{ ['Title'] = 'Faire un doigt', Function = playAnimation, dictionaries = "mp_player_intfinger", clip = 'mp_player_int_finger', ['Close'] = false },
                        { ['Title'] = "Balle dans la tete", Function = playAnimation ,  dictionaries = "mp_suicide", clip = "pistol", ['Close'] = false },
                        { ['Title'] = "Super", Function = playAnimation ,  dictionaries = "mp_action", clip = "thanks_male_06", ['Close'] = false },
                        { ['Title'] = "Enlacer", Function = playAnimation ,  dictionaries = "mp_ped_interaction", clip = "kisses_guy_a", ['Close'] = false },
						{ ['Title'] = 'Mains en l\'air', Function = playAnimation, dictionaries = "missminuteman_1ig_2", clip = 'handsup_base', ['Close'] = false },
						{ ['Title'] = 'Signe de la main', Function = playAnimation, dictionaries = "friends@frj@ig_1", clip = 'wave_e', ['Close'] = false }
                    }
                }},
                { ['Title'] = 'Sport', ['SubMenu'] = {
                    ['Title'] = 'Animations - Sport',
                    ['Items'] = {
						{ ['Title'] = "Altères", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", ['Close'] = false },
						{ ['Title'] = "Faire des abdos", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_SIT_UPS", ['Close'] = false },
                        { ['Title'] = "Faire du Yoga", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_YOGA", ['Close'] = false },
                        { ['Title'] = "Jogging", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_JOG_STANDING", ['Close'] = false },
                        { ['Title'] = "Faire des pompes", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_PUSH_UPS", ['Close'] = false },
						{ ['Title'] = "Montrer ses muscles", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_MUSCLE_FLEX", ['Close'] = false }
					}
                }},
                { ['Title'] = 'Festives', ['SubMenu'] = {
                    ['Title'] = 'Animations - Festives',
                    ['Items'] = {
                        { ['Title'] = "Boire du soda", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_DRINKING", ['Close'] = false },
                        { ['Title'] = "Près du feu", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_STAND_FIRE", ['Close'] = false },
                        { ['Title'] = "Jouer de la musique", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_MUSICIAN", ['Close'] = false },
						{ ['Title'] = "Boire du vin", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_DRINKING", ['Close'] = false },
						{ ['Title'] = "Boire une bière", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_PARTYING", ['Close'] = false },
						{ ['Title'] = "Petite danse", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_STRIP_WATCH_STAND", ['Close'] = false },
						{ ['Title'] = "Barbecue", Function = playEmote, ['EmoteName'] = "PROP_HUMAN_BBQ", ['Close'] = false }
					}
                }},
				{ ['Title'] = 'Prendre une pose', ['SubMenu'] = {
                    ['Title'] = 'Animations - Poses',
                    ['Items'] = {
                        { ['Title'] = "S'assoir", ['SubMenu'] = {
                                ['Title'] = "S'assoir", ['Items'] = {
                                    { ['Title'] = 'Assis au sol', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_PICNIC', ['Close'] = false },
                                    { ['Title'] = "Assis sur une chaise avec dossier", Function = playEmote, ['EmoteName'] = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", ['diminuerhauteur'] = true, ['Close'] = false },
                                    { ['Title'] = "Assis sur une chaise sans dossier", Function = playEmote, ['EmoteName'] = "PROP_HUMAN_SEAT_ARMCHAIR", ['diminuerhauteur'] = true, ['Close'] = false },
                                    { ['Title'] = "Assis à l'arrêt de bus", Function = playEmote, ['EmoteName'] = "PROP_HUMAN_SEAT_BUS_STOP_WAIT", ['diminuerhauteur'] = true, ['Close'] = false },
                                    { ['Title'] = "Assis au bar", Function = playEmote, ['EmoteName'] = "PROP_HUMAN_SEAT_BAR", ['Close'] = false },
                                    { ['Title'] = "Assis en hauteur", Function = playEmote, ['EmoteName'] = "PROP_HUMAN_SEAT_BENCH", ['Close'] = false }
                                }
                            }
                        },
						{ ['Title'] = "Fumer", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_SMOKING", ['Close'] = false },
						{ ['Title'] = "Fumer nerveusement", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_AA_SMOKE", ['Close'] = false },
						{ ['Title'] = "Secoué (accident/aggression)", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_STUPOR", ['Close'] = false },
						{ ['Title'] = "Attendre impatiemment", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_STAND_IMPATIENT", ['Close'] = false },
						{ ['Title'] = "Dormir/se Reposer", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_BUM_SLUMPED", ['Close'] = false }, --leaning down
						{ ['Title'] = "Jouer avec son tel", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_LEANING", ['Close'] = false }, -- lean 2
						{ ['Title'] = 'Accouder au comptoir', ['Function'] = playEmote, ['EmoteName'] = 'PROP_HUMAN_BUM_SHOPPING_CART', ['Close'] = false },
						{ ['Title'] = "SDF (pancarte)", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_BUM_FREEWAY", ['Close'] = false },
						{ ['Title'] = 'Sur le ventre', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_SUNBATHE', ['Close'] = false },
						{ ['Title'] = 'Sur le dos', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_SUNBATHE_BACK', ['Close'] = false },
						{ ['Title'] = 'Sécurité', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GUARD_STAND', ['Close'] = false },
						{ ['Title'] = "Boire un café", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_AA_COFFEE", ['Close'] = false },
						{ ['Title'] = "Pompette", ['Function'] = playEmote, ['EmoteName'] = "WORLD_HUMAN_BUM_STANDING", ['Close'] = false },
						{ ['Title'] = "Avec un balais", ['Function'] = playEmote, ['EmoteName'] = "WORLD_HUMAN_JANITOR", ['Close'] = false },
						{ ['Title'] = "Statue", ['Function'] = playEmote, ['EmoteName'] = "WORLD_HUMAN_HUMAN_STATUE", ['Close'] = false },
                        { ['Title'] = "Prostitution 1", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", ['Close'] = false }, -- prostitute 1
                        { ['Title'] = "Prostitution 2", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", ['Close'] = false } -- prostitute 2
					}
                }},
                { ['Title'] = 'Travail', ['SubMenu'] = {
					['Title'] = 'Animations - Travail',
					['Items'] = {
						{ ['Title'] = "Prendre des notes", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_CLIPBOARD", ['Close'] = false },
						{ ['Title'] = "Reparer le moteur",   Function = playAnimation ,  dictionaries = "amb@world_human_vehicle_mechanic@male@idle_a", clip = "WORLD_HUMAN_VEHICLE_MECHANIC", ['Close'] = false },
						{ ['Title'] = "Photographe", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_PAPARAZZI", ['Close'] = false },
						{ ['Title'] = 'Marteau piqueur', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_CONST_DRILL', ['Close'] = false }, -- mineur
						{ ['Title'] = 'Pose de la police', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_COP_IDLES', ['Close'] = false }, -- Police
						{ ['Title'] = 'Regarder (Police)', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GUARD_PATROL', ['Close'] = false }, -- Police
						{ ['Title'] = 'Circulation', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_CAR_PARK_ATTENDANT', ['Close'] = false }, -- police
						{ ['Title'] = 'Souffleur', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GARDENER_LEAF_BLOWER', ['Close'] = false }, -- Jardinier
						{ ['Title'] = 'Planter', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GARDENER_PLANT', ['Close'] = false }, -- Jardinier
						{ ['Title'] = 'Pêcher', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_STAND_FISHING', ['Close'] = false }, -- P?cheur
						{ ['Title'] = 'Soudure', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_WELDING', ['Close'] = false }, -- soudeur / crochetage
						{ ['Title'] = 'Examiner corp 1', Function = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_KNEEL', ['Close'] = false }, -- Pour medecin et ambulancier
						{ ['Title'] = 'Examiner corp 2', Function = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', ['Close'] = false }, -- Pour medecin et ambulancier
						{ ['Title'] = 'Verbaliser', Function = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', ['Close'] = false }, -- Verbaliser
						{ ['Title'] = 'Jumelle', Function = playEmote, ['EmoteName']  = 'WORLD_HUMAN_BINOCULARS', ['Close'] = false }, -- policier/chasseur
						{ ['Title'] = "Lampe Torche", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_SECURITY_SHINE_TORCH", ['Close'] = false },
						{ ['Title'] = "Nettoyer", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_MAID_CLEAN", ['Close'] = false }
					}
				}},
				{ ['Title'] = 'Autres', ['SubMenu'] = {
                    ['Title'] = 'Animations - Autres',
                    ['Items'] = {
						{ ['Title'] = 'Oui', Function = playAnimation, dictionaries = "gestures@m@standing@casual", clip = 'gesture_pleased', ['Close'] = false },
						{ ['Title'] = 'Non', Function = playAnimation, dictionaries = "gestures@m@standing@casual", clip = 'gesture_head_no', ['Close'] = false },
                        { ['Title'] = "Expliquer", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_HANG_OUT_STREET", ['Close'] = false },
                        { ['Title'] = "Se gratter les c**", Function = playAnimation , dictionaries = "mp_player_int_uppergrab_crotch", clip = "mp_player_int_grab_crotch", ['Close'] = false },
                        { ['Title'] = "Rock and Roll", Function = playAnimation , dictionaries = "mp_player_int_upperrock", clip = "mp_player_int_rock", ['Close'] = false },
						{ ['Title'] = 'Selfie', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_TOURIST_MOBILE', ['Close'] = false },
						{ ['Title'] = 'Portable', Function = playEmote, ['EmoteName'] = 'WORLD_HUMAN_STAND_MOBILE', ['Close'] = false },
						{ ['Title'] = "Touriste (avec carte)", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_TOURIST_MAP", ['Close'] = false },
						{ ['Title'] = "Se nettoyer (dans l'eau)", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_BUM_WASH", ['Close'] = false }   -- washing me self
					}
                }},
                { ['Title'] = 'Démarches', ['SubMenu'] = {
                    ['Title'] = 'Démarches', ['Items'] = {
                        { ['Title'] = 'Normal', Function = stopdemarche, ['Close'] = false },
                        { ['Title'] = 'Démarches Masculines', ['SubMenu'] = {
                            ['Title'] = 'Démarches Masculines',
                            ['Items'] = {
                                { ['Title'] = 'Démarche de loubard', Function = playdemarche, ['demarchname'] = "move_characters@franklin@fire", ['Close'] = false },
                                { ['Title'] = 'Démarche de loubard lent', Function = playdemarche, ['demarchname'] = "move_characters@Jimmy@slow@" , ['Close'] = false },
                                { ['Title'] = 'Enervé, bad guy 1', Function = playdemarche, ['demarchname'] = "move_p_m_zero_janitor", ['Close'] = false },
                                { ['Title'] = 'Enervé, bad guy 2', Function = playdemarche, ['demarchname'] = "move_ped_bucket", ['Close'] = false },
                                { ['Title'] = 'Enervé, bad guy 3', Function = playdemarche, ['demarchname'] = "move_ped_mop", ['Close'] = false },
                                { ['Title'] = 'Tête haute (m)', Function = playdemarche, ['demarchname'] = "MOVE_M@GANGSTER@NG", ['Close'] = false },
                                { ['Title'] = 'Démarche luxueuse (m)', Function = playdemarche, ['demarchname'] = "MOVE_M@POSH@", ['Close'] = false },
                                { ['Title'] = 'Jouer au dur (m)', Function = playdemarche, ['demarchname'] = "MOVE_M@TOUGH_GUY@", ['Close'] = false }
                            }
                        }},
                        { ['Title'] = 'Démarches Féminines', ['SubMenu'] = {
                            ['Title'] = 'Démarches Féminines',
                            ['Items'] = {
                                { ['Title'] = 'Démarche féminine', Function = playdemarche, ['demarchname'] = "move_f@flee@a", ['Close'] = false },
                                { ['Title'] = 'Démarche féminine + peur', Function = playdemarche, ['demarchname'] = "move_f@scared", ['Close'] = false },
                                { ['Title'] = 'Démarche féminine sexy', Function = playdemarche, ['demarchname'] = "move_f@sexy@a", ['Close'] = false },
                                { ['Title'] = 'Démarche féminine rapide', Function = playdemarche, ['demarchname'] = "FEMALE_FAST_RUNNER", ['Close'] = false },
                                --{ ['Title'] = 'missfbi4prepp1_garbageman', Function = playdemarche, ['demarchname'] = "missfbi4prepp1_garbageman", ['Close'] = false },
                                { ['Title'] = 'Démarche feminine (m)', Function = playdemarche, ['demarchname'] = "MOVE_M@FEMME@", ['Close'] = false },
                                { ['Title'] = 'Démarche feminine (f)', Function = playdemarche, ['demarchname'] = "MOVE_F@FEMME@", ['Close'] = false },
                                { ['Title'] = 'Tête haute (f)', Function = playdemarche, ['demarchname'] = "MOVE_F@GANGSTER@NG", ['Close'] = false },
                                { ['Title'] = 'Démarche luxueuse (f)', Function = playdemarche, ['demarchname'] = "MOVE_F@POSH@", ['Close'] = false },
                                { ['Title'] = 'Jouer au dur (f)', Function = playdemarche, ['demarchname'] = "MOVE_F@TOUGH_GUY@", ['Close'] = false }
                            }
                        }},
                        { ['Title'] = 'Démarches Mixtes', ['SubMenu'] = {
                            ['Title'] = 'Démarches Mixtes',
                            ['Items'] = {
                                { ['Title'] = 'Démarche énervé rapide', Function = playdemarche, ['demarchname'] = "move_characters@michael@fire" , ['Close'] = false },
                                { ['Title'] = 'Avoir le caleçon bien remplis', Function = playdemarche, ['demarchname'] = "ANIM_GROUP_MOVE_BALLISTIC", ['Close'] = false },
                                { ['Title'] = 'Tortiller du c*l', Function = playdemarche, ['demarchname'] = "ANIM_GROUP_MOVE_LEMAR_ALLEY", ['Close'] = false },
                                { ['Title'] = 'Je vais te mettre un coup de point', Function = playdemarche, ['demarchname'] = "clipset@move@trash_fast_turn", ['Close'] = false },
                                { ['Title'] = 'Boîter moyennement', Function = playdemarche, ['demarchname'] = "move_injured_generic", ['Close'] = false },
                                { ['Title'] = 'Boîter fort', Function = playdemarche, ['demarchname'] = "move_heist_lester", ['Close'] = false },
                                { ['Title'] = 'Boîter très fort', Function = playdemarche, ['demarchname'] = "move_lester_CaneUp", ['Close'] = false },
                                { ['Title'] = 'Détendu', Function = playdemarche, ['demarchname'] = "move_m@bag", ['Close'] = false },
                                { ['Title'] = 'Déçu', Function = playdemarche, ['demarchname'] = "MOVE_M@BAIL_BOND_NOT_TAZERED", ['Close'] = false },
                                { ['Title'] = 'Sonné', Function = playdemarche, ['demarchname'] = "MOVE_M@BAIL_BOND_TAZERED", ['Close'] = false },
                                { ['Title'] = 'Motivé', Function = playdemarche, ['demarchname'] = "move_m@brave", ['Close'] = false },
                                { ['Title'] = 'Se la péter', Function = playdemarche, ['demarchname'] = "move_m@casual@d", ['Close'] = false },
                                { ['Title'] = 'Boîteux', Function = playdemarche, ['demarchname'] = "move_m@fire", ['Close'] = false },
                                { ['Title'] = 'Balai dans le c*l', Function = playdemarche, ['demarchname'] = "move_m@gangster@var_e", ['Close'] = false },
                                { ['Title'] = 'Vexé', Function = playdemarche, ['demarchname'] = "move_m@gangster@var_f", ['Close'] = false },
                                { ['Title'] = 'Pressé', Function = playdemarche, ['demarchname'] = "move_m@gangster@var_i", ['Close'] = false },
                                --{ ['Title'] = 'Mouvement avec une valise 1', Function = playdemarche, ['demarchname'] = "MOVE_P_M_ONE", ['Close'] = false },
                                --{ ['Title'] = 'Mouvement avec une valise 2', Function = playdemarche, ['demarchname'] = "MOVE_P_M_ONE_BRIEFCASE", ['Close'] = false },
                                { ['Title'] = 'Avancer doucement', Function = playdemarche, ['demarchname'] = "move_p_m_zero_slow", ['Close'] = false }
                            }
                        }}
                    }
                }}
            }
        }},
		{['Title'] = 'Accessoires', ['SubMenu'] = {
            ['Title'] = 'Accessoires',
                ['Items'] = {
                    { ['Title'] = 'Enlever / Mettre votre chapeau', ['Event'] = 'accessories_switcher:toggleHat', ['Close'] = false},
					{ ['Title'] = 'Enlever / mettre vos lunettes', ['Event'] = 'accessories_switcher:toggleGlasses', ['Close'] = false},
					{ ['Title'] = 'Enlever / mettre votre masque', ['Event'] = 'accessories_switcher:toggleMasks', ['Close'] = false}
                }
            }
        },
        {['Title'] = 'Gérer mon portefeuille', ['SubMenu'] = {
            ['Title'] = 'Portefeuille',
                ['Items'] = {
					{ ['Title'] = "Donner de l'argent", ['Event'] = 'bank:givecash'},
					{ ['Title'] = "Payer une facture", ['Event'] = 'bank:givetaxecash'},
					{ ['Title'] = "Donner de l'argent sale", ['Event'] = 'bank:givedirty'}
                }
            }
        },
		{ ['Title'] = 'Activer/Désactiver mode Arrestation', ['Event'] = 'gc:KneelHU'},
		{ ['Title'] = 'Cacher/Afficher le HUD', ['Event'] = 'Players:ToogleHud'},
		{ ['Title'] = 'Faire pipi !', ['Event'] = 'gabs:enviepipi'}
		--[[{ ['Title'] = 'Se suicider / Respawn', ['SubMenu'] = {
			['Title'] = 'Validation suicide:',
			['Items'] = {
						{ ['Title'] = 'Quitter' },
						{ ['Title'] = 'Valider le suicide / respawn',['Event'] = 'ambulancier:selfRespawn'},
                        }
            }
        },]]--
    }
}
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 0, 0, 0, 190 }
Menu.backgroundColorActive = { 255, 255, 255, 190 }
Menu.tileTextColor = { 255, 255, 255, 190 }
Menu.tileBackgroundColor = { 50, 0, 10, 190 }
Menu.textColor = { 255, 255, 255, 190 }
Menu.textColorActive = { 0, 0, 10, 190 }

Menu.keyOpenMenu = 170 -- F3
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

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
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)
    Menu.initText(Menu.tileTextColor, 7, 0.7)
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
            Menu.initText(Menu.textColor)
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
    for i,v in ipairs(Menu.item.Items)do
            if( v['Title'] == 'Ambulancier')then
                table.remove(Menu.item.Items,i)

            end
    end
    TriggerEvent("ambulancier:menu")
    Menu.currentPos = {1}

end

function Menu.keyControl()
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

RegisterNetEvent("gc:CantStopEm")
AddEventHandler("gc:CantStopEm", function()
    CanPlayEmote = false
end)

RegisterNetEvent("gc:CanStopEm")
AddEventHandler("gc:CanStopEm", function()
    CanPlayEmote = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) and CanPlayEmote then
            Menu.initMenu()
            Menu.isOpen = not Menu.isOpen
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
        if IsControlJustPressed(1, KeyOpenJobsMenu) or IsDisabledControlJustReleased(1, KeyOpenJobsMenu) then
            openMenuJobs()
        end
    end
end)
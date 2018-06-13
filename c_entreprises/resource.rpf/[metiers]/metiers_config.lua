-- loop-ignore : le script ignore totalement ce métier
-- pole-emploi : ce métier n'apparaît pas dans pôle emploi
-- metier_prive : metier prive ou publique
-- id = id du blips
-- CircleDiameter : le diamètre du cercle
-- CircleBounce : Le cercle rebondi sur place si 1
-- distActivate : La distance à laquelle le script s'active
-- distDraw : La distance à laquelle le cercle est visible
-- giveItem : L'objet donné sur le point
-- requireItem : L'objet requis sur le point
-- minprice : le prix de vente mini par unité
-- maxprice : le prix de vente maxi par unité
-- fonction : Obligatoire pour Garage et Entreprise, facultatif pour les autres.


--############### BÛCHERON ###############
local bucheron = {metier = "Bûcheron", 
    nom = "La Bûcherie", 
    jobid = 7, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = false, 
    check_service = 'isInServiceBucheronBool', 
    coffre = {}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleBucheron', x = -790.644, y = 5400.225, z = 33.425, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceBucheron', x = -839.800, y = 5401.216, z = 34.005, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Découpe du bois", fonction = nil, forcecar = true, forcepedincar = true, x = -471.076, y = 5580.450, z = 70.162, CircleDiameter = 10.0, CircleBounce = 0, giveItem = 19, maxQuantity = 8, distActivate = 10, distDraw = 30}}, 
    traitement = {[1] = {id = 20, nom = "Fabrication des planches", fonction = nil, forcecar = true, forcepedincar = true, x = -508.064, y = 5267.702, z = 79.610, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 19, giveItem = 20, maxQuantity = 8, distActivate = 10, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente de des planches", fonction = nil, forcecar = true, forcepedincar = true, x = 1199.263, y = -1345.268, z = 34.404, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 20, minprice = 33, maxprice = 40, distActivate = 10, distDraw = 30}}, 
vehicules = {[1] = {nom = "Camion de DéDé", model = 'Phantom', vehid = 1}}}
--########################################

--############### VIGNERON ###############
local vigneron = {metier = "Vigneron", 
    nom = "Le Bouchon", 
    jobid = 13, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceVigneronBool', 
    coffre = {x = -1893.512, y = 2075.651, z = 139.997, CircleDiameter = 3.0, CircleBounce = 1, distActivate = 3, distDraw = 30}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleVigneron', x = -1901.316, y = 2026.555, z = 140.000, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceVigneron', x = -1886.461, y = 2049.232, z = 140.179, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Récolte du Raisin", fonction = nil, forcecar = true, forcepedincar = true, x = -1829.171, y = 2213.837, z = 86.303, CircleDiameter = 10.0, CircleBounce = 0, giveItem = 26, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    traitement = {[1] = {id = 20, nom = "Mise en Bouteille", fonction = nil, forcecar = true, forcepedincar = true, x = 496.167, y = -1970.300, z = 23.799, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 26, giveItem = 27, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente des Bouteilles", fonction = nil, forcecar = true, forcepedincar = true, x = -1524.525, y = 90.259, z = 55.501, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 27, minprice = 82, maxprice = 88, distActivate = 10, distDraw = 30}}, 
vehicules = {[1] = {nom = "Pickup", model = 'sadler', vehid = 1}}}
--########################################

--############### BRASSEUR ###############
local brasseur = {metier = "Brasseur", 
    nom = "Les 3 Bibines", 
    jobid = 12, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceBrasseurBool', 
    coffre = {x = 2445.577, y = 4983.623, z = 45.809, CircleDiameter = 3.0, CircleBounce = 1, distActivate = 3, distDraw = 30}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleBrasseur', x = 2442.192, y = 5011.770, z = 46.009, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceBrasseur', x = 2480.028, y = 4953.197, z = 44.309, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Récolte de l'Orge", fonction = nil, forcecar = true, forcepedincar = true, x = 2413.522, y = 4991.765, z = 45.502, CircleDiameter = 10.0, CircleBounce = 0, giveItem = 24, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    traitement = {[1] = {id = 20, nom = "Fabrication de la Bière", fonction = nil, forcecar = true, forcepedincar = true, x = 837.185, y = -1938.010, z = 27.776, CircleDiameter = 20.0, CircleBounce = 0, requireItem = 24, giveItem = 25, maxQuantity = 30, distActivate = 20, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente de la Bière", fonction = nil, forcecar = true, forcepedincar = true, x = 141.320, y = -1277.928, z = 28.109, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 25, minprice = 74, maxprice = 80, distActivate = 10, distDraw = 30}}, 
vehicules = {[1] = {nom = "Camion à Bibines", model = 'pounder', vehid = 1}}}
--########################################

--############### LIVREUR ###############
local livreur = {metier = "Livreur", 
    nom = "Chrono'Pro", 
    jobid = 14, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceLivreurBool', 
    coffre = {x = -456.74, y = -2750.63, z = 5.0, CircleDiameter = 3.0, CircleBounce = 1, distActivate = 3, distDraw = 30}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleLivreur', x = -409.75, y = -2795.61, z = 5.0, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceLivreur', x = -422.120, y = -2787.520, z = 5.0, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Chargement de la cargaison", fonction = 'SpawnCargaisonLivreur', forcecar = true, forcepedincar = true, x = -413.39, y = -2697.21, z = 5.00, CircleDiameter = 3.0, CircleBounce = 0, giveItem = 0, maxQuantity = 0, distActivate = 10, distDraw = 30}}, 
    traitement = {}, 
    vente = {[1] = {id = 20, nom = "Dépôt de la cargaison", fonction = 'VenteCargaisonLivreur', forcecar = true, forcepedincar = false, x = 1738.72, y = 3283.57, z = 39.90, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 0, minprice = 1600, maxprice = 2000, distActivate = 10, distDraw = 30}}, 
vehicules = {[1] = {nom = "Véhicule de fonction", model = 'flatbed', vehid = 1}, [2] = {nom = "Fenwick", model = 'forklift', vehid = 2}}}
--########################################

--############### FERMIER ###############
local fermier = {metier = "Fermier", 
    nom = "La P'tite Mie", 
    jobid = 6, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceFermierBool', 
    coffre = {x = 2258.313, y = 5165.692, z = 58.111, CircleDiameter = 3.0, CircleBounce = 1, distActivate = 3, distDraw = 30}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleFermier', x = 2229.083, y = 5167.491, z = 58.007, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceFermier', x = 2242.869, y = 5154.286, z = 57.087, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Récolte du Blé", fonction = nil, forcecar = true, forcepedincar = true, x = 2150.973, y = 5164.509, z = 53.091, CircleDiameter = 10.0, CircleBounce = 0, giveItem = 10, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    traitement = {[1] = {id = 20, nom = "Fabrication du Pain", fonction = nil, forcecar = true, forcepedincar = true, x = 2903.000, y = 4382.175, z = 49.552, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 10, giveItem = 5, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente du Pain", fonction = nil, forcecar = true, forcepedincar = true, x = -1292.270, y = -1398.797, z = 3.586, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 5, minprice = 55, maxprice = 61, distActivate = 10, distDraw = 30}}, 
vehicules = {[1] = {nom = "Camion Benson", model = 'benson', vehid = 1}}}
--########################################

--############### MINEUR ###############
local mineur = {metier = "Mineur", 
    nom = "La Carrière", 
    jobid = 9, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = false, 
    check_service = 'isInServiceMineurBool', 
    coffre = {}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleMineur', x = 981.393, y = -1919.801, z = 30.320, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceMineur', x = 966.258, y = -1933.027, z = 30.327, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Mine de Fer", fonction = nil, forcecar = true, forcepedincar = true, x = 2678.576, y = 2870.152, z = 35.753, CircleDiameter = 10.0, CircleBounce = 0, giveItem = 1, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    traitement = {[1] = {id = 20, nom = "La Fonderie", fonction = nil, forcecar = true, forcepedincar = true, x = 1075.501, y = -1949.545, z = 30.204, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 1, giveItem = 2, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente du Métal", fonction = nil, forcecar = true, forcepedincar = true, x = -463.215, y = -1714.076, z = 17.654, CircleDiameter = 15.0, CircleBounce = 0, requireItem = 2, minprice = 25, maxprice = 35, distActivate = 15, distDraw = 30}}, 
vehicules = {[1] = {nom = "Camion Mineur n°1", model = 'tiptruck', vehid = 1}, [2] = {nom = "Camion Mineur n°2", model = 'tiptruck2', vehid = 2}, [3] = {nom = "Camion Mineur n°3", model = 'rubble', vehid = 3}}}
--########################################

--############### ORPAILLEUR ###############
local orpailleur = {metier = "Orpailleur", 
    nom = "Le Diamantaire", 
    jobid = 21, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceOrpailleurBool', 
    coffre = {x = 1075.4, y = -2328.81, z = 30.29, CircleDiameter = 3.0, CircleBounce = 1, distActivate = 3, distDraw = 30}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleOrpailleur', x = 1110.039, y = -2290.100, z = 29.376, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceOrpailleur', x = 1084.820, y = -2289.270, z = 29.231, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Mine d'Or", fonction = nil, forcecar = true, forcepedincar = true, x = -596.781, y = 2091.123, z = 130.412, CircleDiameter = 10.0, CircleBounce = 0, giveItem = 3, maxQuantity = 10, distActivate = 10, distDraw = 30}}, 
    traitement = {[1] = {id = 20, nom = "La Fonderie", fonction = nil, forcecar = true, forcepedincar = true, x = 1102.256, y = -2241.587, z = 29.210, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 3, giveItem = 9, maxQuantity = 10, distActivate = 10, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente de l'Or", fonction = nil, forcecar = true, forcepedincar = true, x = -623.765, y = -227.916, z = 37.057, CircleDiameter = 15.0, CircleBounce = 0, requireItem = 9, minprice = 150, maxprice = 158, distActivate = 15, distDraw = 30}}, 
vehicules = {[1] = {nom = "Camion Orpailleur n°1", model = 'bison', vehid = 1}, [2] = {nom = "Camion Orpailleur n°2", model = 'bison2', vehid = 2}, [3] = {nom = "Camion Orpailleur n°3", model = 'bison3', vehid = 3}}}
--########################################

--############### PECHEUR ###############
local pecheur = {metier = "Pêcheur", 
    nom = "Dov'Fish", 
    jobid = 10, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServicePecheurBool', 
    coffre = {x = 3817.605, y = 4482.550, z = 4.992, CircleDiameter = 3.0, CircleBounce = 1, distActivate = 3, distDraw = 30}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehiclePecheur', x = 3827.914, y = 4466.706, z = 1.991, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServicePecheur', x = 3804.072, y = 4476.629, z = 4.992, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Zone de Pêche", fonction = nil, forcecar = true, forcepedincar = false, x = 3780.315, y = 4845.537, z = 0.468, CircleDiameter = 60.0, CircleBounce = 0, giveItem = 21, maxQuantity = 30, distActivate = 60, distDraw = 100}}, 
    traitement = {[1] = {id = 20, nom = "Préparation du Poisson", fonction = nil, forcecar = true, forcepedincar = true, x = 970.746, y = -1623.371, z = 29.110, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 21, giveItem = 22, maxQuantity = 30, distActivate = 10, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente des Filets", fonction = nil, forcecar = true, forcepedincar = true, x = -1053.807, y = -1398.759, z = 4.425, CircleDiameter = 15.0, CircleBounce = 0, requireItem = 22, minprice = 74, maxprice = 81, distActivate = 15, distDraw = 30}}, 
vehicules = {[1] = {nom = "Le petit bâteau", model = 'tug', vehid = 1}, [2] = {nom = "Camionette", model = 'benson', vehid = 2}}}
--########################################

--############### RAFFINEUR ###############
local raffineur = {metier = "Raffineur", 
    nom = "Fuel & Explosions", 
    jobid = 20, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceRaffineurBool', 
    coffre = {x = 1413.870, y = -2042.442, z = 50.998, CircleDiameter = 3.0, CircleBounce = 1, distActivate = 3, distDraw = 30}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleRaffineur', x = 1358.479, y = -2078.598, z = 50.99, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceRaffineur', id = 17, x = 1383.03, y = -2078.81, z = 50.99, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {[1] = {id = 19, nom = "Récolte du Pétrole", fonction = nil, forcecar = true, forcepedincar = true, x = 1370.961, y = -1860.891, z = 55.98, CircleDiameter = 10.0, CircleBounce = 0, giveItem = 43, maxQuantity = 8, distActivate = 10, distDraw = 30}}, 
    traitement = {[1] = {id = 20, nom = "La Raffinerie", fonction = nil, forcecar = true, forcepedincar = true, x = 479.02, y = -2146.73, z = 4.91, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 43, giveItem = 44, maxQuantity = 8, distActivate = 10, distDraw = 30}}, 
    vente = {[1] = {id = 21, nom = "Vente de des planches", fonction = nil, forcecar = true, forcepedincar = true, x = -2536.184, y = 2344.321, z = 32.06, CircleDiameter = 10.0, CircleBounce = 0, requireItem = 44, minprice = 88, maxprice = 95, distActivate = 10, distDraw = 30}}, 
vehicules = {[1] = {nom = "Camion de Bernard", model = 'Phantom', vehid = 1}}}
--########################################

--############### CONCESSIONNAIRE ###############
local concessionnaire = {metier = "Concessionnaire", 
    nom = "Loca'Nation", 
    jobid = 25, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceConcessionnaireBool', 
    coffre = {x = -31.589, y = -1106.970, z = 25.422, CircleDiameter = 1.0, CircleBounce = 1, distActivate = 2, distDraw = 30}, 
    garage = {id = 18, nom = "Menu Concessionnaire", fonction = 'CheckForOpeningConcessMenu', x = -31.773, y = -1113.521, z = 25.422, CircleDiameter = 2.0, CircleBounce = 0, distActivate = 2, distDraw = 30}, 
    entreprise = {id = 17, nom = "Zone de suppression de véhicules", fonction = 'SupprimerVehiculeConcessionnaire', id = 17, x = -9.52, y = -1089.89, z = 25.67, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {}}
--########################################

--############### AVOCAT ###############
local avocat = {metier = "Avocat", 
    nom = "Chicote & Justice", 
    jobid = 22, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceAvocatBool', 
    coffre = {x = 122.19, y = -738.18, z = 241.15, CircleDiameter = 1.0, CircleBounce = 1, distActivate = 2, distDraw = 30},
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleAvocat', x = -3.68, y = -668.09, z = 31.33, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceAvocat', id = 17, x = 107.84, y = -750.45, z = 241.15, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {[1] = {nom = "Voiture Avocat", model = 'washington', vehid = 1}}}
--########################################

--############### GOUVERNEMENT ###############
local gouvernement = {metier = "Gouvernement", 
    nom = "Gouvernement", 
    jobid = 23, 
    loop_ignore = false, 
    pole_ignore = true, 
    metier_prive = true, 
    check_service = 'isInServiceGouvernementBool', 
    coffre = {x = -1555.790, y = -575.123, z = 107.537, CircleDiameter = 1.0, CircleBounce = 1, distActivate = 2, distDraw = 30}, 
    garage = {}, 
    entreprise = {}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {}}
--########################################

--############### PROCUREUR ###############
local procureur = {metier = "Procureur", 
    nom = "Procureur", 
    jobid = 24, 
    loop_ignore = false, 
    pole_ignore = true, 
    metier_prive = true, 
    check_service = 'isInServiceProcureurBool', 
    coffre = {}, 
    garage = {id = 18, nom = "Garage", fonction = 'GetVehicleProcureur', x = -3.712, y = -670.003, z = 31.338, CircleDiameter = 5.0, CircleBounce = 0, distActivate = 5, distDraw = 30}, 
    entreprise = {id = 17, nom = "Prise de Service", fonction = 'GetServiceProcureur', x = 10.095, y = -668.158, z = 32.449, CircleDiameter = 3.0, CircleBounce = 0, distActivate = 3, distDraw = 30}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {[1] = {nom = "Voiture Procureur", model = 'cog55', vehid = 1}}}
--########################################

--############### MECANICIEN ###############
local mecanicien = {metier = "Mécanicien", 
    nom = "Benny's", 
    jobid = 16, 
    loop_ignore = false, 
    metier_prive = true, 
    pole_ignore = false, 
    check_service = 'isInServiceMecanicienBool', 
    coffre = {x = -206.773, y = -1341.549, z = 33.894, CircleDiameter = 1.0, CircleBounce = 1, distActivate = 2, distDraw = 30}, 
    garage = {}, 
    entreprise = {}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {}}
--########################################

--############### LSES ###############
local lses = {metier = "LSES", 
    nom = "LSES", 
    jobid = 15, 
    loop_ignore = false, 
    metier_prive = true, 
    pole_ignore = true, 
    check_service = 'isInServiceLsesBool', 
    coffre = {x = 229.894, y = -1369.412, z = 38.534, CircleDiameter = 1.0, CircleBounce = 1, distActivate = 2, distDraw = 30}, 
    garage = {}, 
    entreprise = {}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {}}
--########################################

--############### LSPD ###############
local lspd = {metier = "LSPD", 
    nom = "LSPD", 
    jobid = 2, 
    loop_ignore = false, 
    pole_ignore = true, 
    metier_prive = true, 
    check_service = 'isInServiceLspdBool', 
    coffre = {x = 452.736, y = -973.624, z = 29.689, CircleDiameter = 1.0, CircleBounce = 1, distActivate = 2, distDraw = 30}, 
    garage = {}, 
    entreprise = {}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {}}
--########################################


--############### TAXI ###############
local taxi = {metier = "Taxi", 
    nom = "Cab'n'Co", 
    jobid = 17, 
    loop_ignore = false, 
    pole_ignore = false, 
    metier_prive = true, 
    check_service = 'isInServiceTaxiBool', 
    coffre = {x = 882.722, y = -159.996, z = 76.110, CircleDiameter = 1.0, CircleBounce = 1, distActivate = 2, distDraw = 30}, 
    garage = {}, 
    entreprise = {}, 
    recolte = {}, 
    traitement = {}, 
    vente = {}, 
vehicules = {}}
--########################################

entreprises = {
    [1] = fermier, 
    [2] = bucheron, 
    [3] = brasseur, 
    [4] = vigneron, 
    [5] = livreur, 
    [6] = mineur, 
    [7] = orpailleur, 
    [8] = pecheur, 
    [9] = raffineur, 
    [10] = concessionnaire, 
    [11] = avocat, 
    [12] = gouvernement, 
    [13] = procureur, 
    [14] = mecanicien, 
    [15] = lses, 
    [16] = lspd, 
    [17] = taxi
}

pole_emploi = {
    [1] = {nom = "Recherche d'Emploi", id = 407, x = -266.94, y = -960.744, z = 30.0231}, 
[2] = {nom = "Recherche d'Emploi", id = 407, x = -253.952, y = 6148.22, z = 30.4242}}

options = {
    x = 0.1, 
    y = 0.2, 
    width = 0.2, 
    height = 0.04, 
    scale = 0.4, 
    font = 0, 
    menu_title = "Entreprise", 
    menu_subtitle = "Gestion", 
    color_r = 30, 
    color_g = 144, 
    color_b = 255, 
}

--[[local coffres = {
  {nom='Coffre LSES', x=229.89440917969, y=-1369.412109375, z=39.534370422363, jobid=15}, -- LSES
  {nom='Coffre LSPD',x=452.73648071289, y=-973.62426757813, z=29.689603805542, jobid=2}, -- LSPD
  {nom='Coffre Benny\'S',x=-206.77369689941, y=-1341.5491943359, z=33.894374847412, jobid=16}, -- MECANICIEN
  {nom='Coffre Raffineurs',x=1413.8708496094, y=-2042.4427490234, z=50.998550415039, jobid=20}, -- RAFFINEUR
  {nom='Coffre Pêcheurs',x=3817.6057128906, y=4482.5502929688, z=4.9926853179932 , jobid=10}, -- PECHEUR
  {nom='Coffre Fermiers',x=2258.3134765625, y=5165.6923828125, z=58.111709594727 , jobid=6}, -- FERMIER
  {nom='Coffre Vignerons',x=-1893.5125732422, y=2075.6511230469, z=139.99772644043 , jobid=13}, -- VIGNERON
  {nom='Coffre Orpailleurs',x=707.40289306641, y=-966.55505371094, z=29.412853240967, jobid=21}, -- ORPAILLEUR
  {nom='Coffre Journaliste',x=-1055.21484375, y=-230.88966369629, z=43.021030426025, jobid=19}, -- JOURNALISTE
  {nom='Coffre Loca\'Luxe',x=-31.58943939209, y=-1106.9705810547, z=25.422351837158, jobid=25}, -- LOCALUXE
  {nom='Coffre Brasseur',x=2445.5776367188, y=4983.6235351563, z=45.809768676758, jobid=12}, -- BRASSEUR
  {nom='Coffre Gouvernement',x=-1555.7905273438, y=-575.12353515625, z=107.53789520264, jobid=23}, -- GOUVERNEMENT
  {nom='Coffre Taxi',x=882.72222900391, y=-159.99606323242, z=77.110229492188, jobid=17}, -- TAXI
}
]]--

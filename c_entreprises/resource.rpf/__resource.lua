resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    'client_base.lua', 
    '[gui]/gui.lua', 
	'[salaires]/salaires_config_serveur.lua', 
    '[salaires]/salaires_client.lua', 
    '[pole-emploi]/popole_client.lua', 
    '[coffres]/coffres_client.lua', 
    '[metiers]/metiers_config.lua', 
    '[metiers]/Vignerons/vignerons_client.lua', 
    '[metiers]/Livreurs/livreurs_client.lua', 
    '[metiers]/Brasseurs/brasseurs_client.lua', 
    '[metiers]/Bucherons/bucherons_client.lua', 
    '[metiers]/Fermiers/fermiers_client.lua', 
    '[metiers]/Mineurs/mineurs_client.lua', 
    '[metiers]/Orpailleurs/orpailleurs_client.lua', 
    '[metiers]/Pecheurs/pecheurs_client.lua', 
    '[metiers]/Raffineurs/raffineurs_client.lua', 
    '[metiers]/Concessionnaires/concessionnaires_menu.lua', 
    '[metiers]/Concessionnaires/concessionnaires_client.lua', 
    '[metiers]/Avocats/avocats_client.lua', 
    '[metiers]/Gouvernement/gouvernement_client.lua', 
    '[metiers]/Procureur/procureur_client.lua', 
    '[metiers]/Mecaniciens/mecaniciens_client.lua', 
    '[metiers]/LSES/lses_client.lua', 
    '[metiers]/LSPD/lspd_client.lua', 
    '[metiers]/Taxis/taxis_client.lua', 
}

server_scripts {
    '[salaires]/salaires_serveur.lua', 
    '[salaires]/salaires_config_serveur.lua', 
    '[pole-emploi]/popole_serveur.lua', 
    '[coffres]/coffres_serveur.lua', 
    '[metiers]/metiers_serveur.lua', 
    '[metiers]/Concessionnaires/concessionnaires_serveur.lua', 
    '@mysql-async/lib/MySQL.lua'
}

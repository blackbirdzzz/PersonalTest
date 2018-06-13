resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency 'essentialmode'

ui_page 'gui/ui.html'

files {
    'gui/ui.html', 
    'gui/job-icon.png', 
    'gui/pricedown.ttf', 
    "gui/chomeur.png", 
    "gui/policier.png", 
    "gui/mineur.png", 
    "gui/bucheron.png", 
    "gui/fermier.png", 
    "gui/pecheur.png", 
    "gui/brasseur.png", 
    "gui/vigneron.png", 
    "gui/ambulancier.png", 
    "gui/mecano.png", 
    "gui/taxi.png", 
    "gui/Raffineur.png", 
    "gui/Orpaillage.png", 
    "gui/Avocat.png", 
    "gui/Journaliste.png", 
    "gui/gouvernement.png", 
    "gui/Procureur.png", 
    "gui/LocaLuxe.png", 
    "gui/livreur.png"
}

client_script {
    'gui/gui.lua', 
    'poleemploi/metiers_config.lua', 
    'police/config_portes.lua', 
    'police/police_client.lua', 
    'police/police_client_vehicle.lua', 
    'police/police_client_veset.lua', 
    'police/police_client_notif.lua', 
    'police/police_Menu.lua', 
    'poleemploi/metiers_client.lua', 
    'mecano/mecano_client.lua', 
    'mecano/mecano_Menu.lua', 
    'ui.lua', 
}

server_script {
    'poleemploi/metiers_config.lua', 
    'poleemploi/metiers_server.lua', 
    'police/config_portes.lua', 
    'police/police_server.lua', 
    'police/police_server_notif.lua', 
    'mecano/mecano_server.lua', 
    '@mysql-async/lib/MySQL.lua', 
    'server_base.lua'
}

export 'getIsInService'

server_exports {
    'AddEmergencyConnected', 
    'RemoveEmergencyConnected', 
    'GetAmbuConnected', 
    'GetPoliceConnected'
}

dependencies{
    'vdk_inventory'
}

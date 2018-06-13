resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    'journaliste_server.lua',
	'@mysql-async/lib/MySQL.lua'
} 

client_scripts {
	'menu.lua',
	'journaliste_utils.lua',
	'journaliste_config.lua',
	'journaliste_client.lua',
	'journaliste_menu.lua',
	'jour_camera.lua'
}
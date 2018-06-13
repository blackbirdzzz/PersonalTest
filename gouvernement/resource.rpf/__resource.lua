resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    'gouv_server.lua',
	'@mysql-async/lib/MySQL.lua'
} 

client_scripts {
	'menu.lua',
	'gouv_utils.lua',
	'gouv_config.lua',
	'gouv_client.lua',
	'gouv_menu.lua'
}
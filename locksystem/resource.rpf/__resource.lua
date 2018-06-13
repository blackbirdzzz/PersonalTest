resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'config/shared.lua',
	'client/utils.lua',
	'client/main.lua'
}

server_scripts {
	'config/shared.lua',
	'server/utils.lua',
	'server/class.lua',
	'server/server.lua'
}

ui_page 'client/html/index.html'

files {
    'client/html/index.html',
    'client/html/sounds/lock.ogg',
    'client/html/sounds/unlock.ogg'
}
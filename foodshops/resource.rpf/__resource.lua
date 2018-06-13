resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency 'essentialmode'

client_scripts {
	'menu.lua',
	'foodshops_cl.lua'
}

server_scripts {
	'foodshops_sv.lua',
	'@mysql-async/lib/MySQL.lua'
}
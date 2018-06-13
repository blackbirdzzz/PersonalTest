resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

dependency 'essentialmode'

client_scripts {
	'armes_illegales_cl.lua',
	'menu.lua'
}
	
server_scripts {
	'armes_illegales_sv.lua',
	'@mysql-async/lib/MySQL.lua'
}
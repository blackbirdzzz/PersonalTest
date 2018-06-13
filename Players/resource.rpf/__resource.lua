client_scripts {
	'overhead.lua',
	'pointing.lua',
	'client.lua',
--	'stamina.lua',
	'crouch.lua',
	'watermark.lua',
	'hud.lua'
}

exports {
	"getStatusHUD",
	"toogleHud",
	"setStatusHUD"
}

server_script '@mysql-async/lib/MySQL.lua'
server_script 'server.lua'
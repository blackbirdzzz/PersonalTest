--
-- @Project: Trium
-- @License: No License
--

ui_page 'nui/needs.html'
files {
	'nui/needs.html',
	'nui/pdown.ttf'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"src/server.lua",
}

client_scripts {
	"src/client.lua",
}

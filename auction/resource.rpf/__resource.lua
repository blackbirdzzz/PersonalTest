--
-- @Project: Trium
-- @License: No License
--

server_scripts {
	'@mysql-async/lib/MySQL.lua',
  'src/auction.server.lua',
}
client_script {
  'src/auction.client.lua',
}

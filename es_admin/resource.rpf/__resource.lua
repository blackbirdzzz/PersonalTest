-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

client_script 'cl_admin.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_admin.lua'
}
server_script '@mysql-async/lib/MySQL.lua'
client_script 'apart_client.lua'
server_script 'apart_server.lua'
client_script 'GUI.lua'

client_script 'InteractSound.lua'
ui_page('html/index.html')
files({
    'html/index.html',
    'html/sounds/chime.ogg'
})

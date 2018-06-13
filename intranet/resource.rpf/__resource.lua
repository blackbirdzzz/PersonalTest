
ui_page 'html/index.html'

files {
  'html/index.html',
  'html/style.css',
  'html/script.js'
}

client_script "client.lua"

server_scripts {
  "server.lua",
  "md5.lua"
}
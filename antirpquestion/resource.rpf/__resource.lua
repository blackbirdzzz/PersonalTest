ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/logo.png',
	'html/cursor.png',
	'html/styles.css',
	'html/questions.js',
	'html/scripts.js',
	'html/debounce.min.js'
}

server_scripts {
        'server.lua',
		'@mysql-async/lib/MySQL.lua'
}
client_script {
        'client.lua'
}

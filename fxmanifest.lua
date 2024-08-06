fx_version 'cerulean'

game 'gta5'

author 'baTu'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'client/*.lua',
    'config.lua',
}

server_scripts {
    'config.lua',
    'server/main.lua',
}

depencies {
    'ox_lib',
    'ox_target',
    'ox_inventory'
}

lua54 'yes'
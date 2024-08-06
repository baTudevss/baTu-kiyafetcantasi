game 'gta5'
fx_version 'cerulean'
lua54 'yes'
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

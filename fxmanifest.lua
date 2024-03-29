fx_version  'cerulean'
game        'gta5'
lua54       'yes'
-- ===========================================================
description 'Sistema de gestión de garages y stashes para organizaciones criminales para qb-core basado en ox_lib y ox_inventory'
author      'KuroNeko'
-- ===========================================================
version     '1.0.1'

-- ===========================================================
shared_scripts { '@ox_lib/init.lua', 'config.lua' }
server_scripts { 'server.lua' }
client_scripts { 'client.lua' }
files          { 'locales/es.json' }
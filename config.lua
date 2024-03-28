Config = Config or {}

Config.settings = {
    -- ===== settings for fuel
    fuel  = 'ps-fuel', -- ps-fuel, lj-fuel, LegacyFuel

    -- ===== settings for ox_inventory
    stash = {
        slots  = 60,
        weight = 300000
    },

    -- ===== settings for markers :: https://docs.fivem.net/docs/game-references/markers/
    markers = {
        iconGgarage = 36,
        iconStash   = 2,
        alphaColor  = 180
    }
}

Config.Gangs = {
    {
        id = 'ballas',
        label = 'Ballas',
        markerColor = { r = 204, g = 51, b = 102 },
        stash  = vector3(-41.1190, -1115.7319, 26.4367),
        garage = vector4(-44.8715, -1116.6627, 26.4338, 2.7542),
        vehicles = {
            pr = 'BL',  -- dos letras
            colors = {
                primary = { r = 223, g = 88, b = 145 },
                secondary = { r = 107, g = 31, b = 123 }
            },
            options = {
                buffalo2 = 'Buffalo Sport',
                rumpo3   = 'RumpoXL',
                manchez  = 'Manchez',
                chino2   = 'Lowrider',
            }
        }
    },
}
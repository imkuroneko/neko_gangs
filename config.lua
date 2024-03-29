-- links:
-- [1] https://docs.fivem.net/docs/game-references/markers/
-- [2] https://docs.fivem.net/docs/game-references/hud-colors/

Config = Config or {}

Config.settings = {
    fuel  = 'ps-fuel',  -- ps-fuel, lj-fuel, LegacyFuel

    stash = {
        slots  = 60,     -- espacios total (slots) del inventario
        weight = 300000  -- capacidad total (peso en gr) del inventario
    },

    markers = { -- [1]
        iconGarage = 36,  -- ícono para el garage
        iconStash  = 2,   -- ícono para el inventario
    },
}

Config.Gangs = {
    {
        id = 'ballas',                                             -- id del grupo
        label = 'Ballas',                                          -- nombre del grupo

        markerColor = { r = 204, g = 51, b = 102 },                -- color (rgb) para los marcadores (garage e inventario)

        stash = vector3(-41.1190, -1115.7319, 26.4367),            -- coordenadas para el inventario (definir como nil si no se utilizará)

        territory = {                                              -- para mostrar un marcador en el mapa como "zona peligrosa" (definir como nil si no se utilizará)
            coords = vector3(-41.11, -1115.73, 26.43),             -- territory main coord (center)
            radius = 90.0,                                         -- radius
            color  = 30                                            -- color [2]
        },

        garage = vector4(-44.8715, -1116.6627, 26.4338, 2.7542),   -- coordenadas para el garage (definir como nil si no se utilizará)
        vehicles = {
            pr = 'BL',                                             -- prefix for the plate
            colors = {                                             -- colors for the vehicle
                primary = { r = 223, g = 88, b = 145 },
                secondary = { r = 107, g = 31, b = 123 }
            },
            options = {                                            -- que vehículos podrán utilizar este grupo
                buffalo2 = 'Buffalo Sport',
                rumpo3   = 'RumpoXL',
                manchez  = 'Manchez',
                chino2   = 'Lowrider',
            }
        }
    },

    {
        id = 'families',                                           -- id del grupo
        label = 'Families',                                        -- nombre del grupo
        markerColor = { r = 204, g = 51, b = 102 },                -- color (rgb) para los marcadores (garage e inventario)
        stash = nil,                                               -- coordenadas para el inventario (definir como nil si no se utilizará)
        territory = nil,                                           -- para mostrar un marcador en el mapa como "zona peligrosa" (definir como nil si no se utilizará)
        garage = nil,                                              -- coordenadas para el garage (definir como nil si no se utilizará)
        vehicles = {}                                              -- si el garage no se utilizará, se puede dejar esto como un array vacío
    },
}

lib.locale()
local ox_inventory = exports.ox_inventory
local settings = Config.settings.stash

Citizen.CreateThread(function()
    for _, gang in pairs(Config.Gangs) do
        if gang.stash ~= nil then
            ox_inventory:RegisterStash(
                'stash_gang_'..gang.id,
                locale('stash_label', gang.label),
                settings.slots,
                settings.weight,
                nil,
                { [gang.id] = 0 },
                { gang.stash }
            )
        end
    end
end)
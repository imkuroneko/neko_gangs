lib.locale()
local ox_inventory = exports.ox_inventory
local QBCore = exports['qb-core']:GetCoreObject()
local settingsMarker = Config.settings.markers
local PlayerGang = {}

-- === get player data
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(data)
        PlayerGang = data.gang
    end)
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(data)
    PlayerGang = data
end)

-- === thread
Citizen.CreateThread(function()
    if lib.isTextUIOpen() then
        lib.hideTextUI()
    end

    for _, gang in pairs(Config.Gangs) do
        local colorRgb = { r = gang.markerColor.r, g = gang.markerColor.g, b = gang.markerColor.b, a = 180 }

        -- ===== Territories
        if gang.territory ~= nil then
            local bgBlip = AddBlipForRadius(gang.territory.coords.x, gang.territory.coords.y, gang.territory.coords.z, gang.territory.radius)
            SetBlipAlpha(bgBlip, 80)
            SetBlipColour(bgBlip, gang.territory.color)

            lib.points.new({
                id       = 'neko_gangs_territory_'..gang.id,
                coords   = gang.territory.coords,
                distance = gang.territory.radius,
                onEnter  = function()
                    lib.showTextUI(locale('danger_zone'), {
                        icon = 'fas fa-exclamation',
                        position = 'bottom-center',
                        style = { backgroundColor = 'rgba(82, 16, 29, 0.8)', fontSize = '90%' }
                    })
                end,
                onExit   = function()
                    lib.hideTextUI()
                end,
            })
        end

        -- ===== stash
        if gang.stash ~= nil then
            local oxMarker = lib.marker.new({ type = settingsMarker.iconStash, coords = gang.stash, width = 0.20, height = 0.20, color = colorRgb, faceCamera = true })

            lib.points.new({
                id       = 'neko_gangs_stash_'..gang.id,
                coords   = gang.stash,
                distance = 2,
                nearby   = function()
                    if PlayerGang.name ~= gang.id then return end
                    oxMarker:draw()
                    lib.showTextUI(locale('press_e_open_stash'), { icon = 'fas fa-box', position = 'left-center' })
                    if IsControlJustPressed(0, 38) then
                        ox_inventory:openInventory('stash', { id = 'stash_gang_'..gang.id, groups = gang.id })
                    end
                end,
                onExit   = function() lib.hideTextUI() end
            })
        end

        -- ===== vehicle menu & garage system
        if gang.garage ~= nil then
            VehicleListMenu = {}
            for model, label in pairs(gang.vehicles.options) do
                VehicleListMenu[model] = {
                    title       = label,
                    icon        = 'fas fa-car',
                    event       = 'neko_gangs:client:garage:spawnvehicle',
                    args        = { prefix = gang.vehicles.pr, colors = gang.vehicles.colors, spawn = gang.garage, model = model }
                }
            end

            lib.registerContext({
                id      = 'neko_gangs_garage_'..gang.id,
                title   = locale('vehicle_list_menu'),
                options = VehicleListMenu
            })

            -- ===== garage
            local oxGarage = lib.marker.new({ type = settingsMarker.iconGarage, coords = gang.garage, width = 0.20, height = 0.20, color = colorRgb, faceCamera = true })

            lib.points.new({
                id       = 'neko_gangs_garage_'..gang.id,
                coords   = gang.garage,
                distance = 2,
                nearby   = function()
                    if PlayerGang.name ~= gang.id then return end
                    oxGarage:draw()

                    if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId()) then
                        lib.showTextUI(locale('press_e_save_vehicle'), { icon = 'fas fa-square-parking', position = 'left-center' })
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent('neko_gangs:client:garage:deletevehicle')
                        end
                    else
                        lib.showTextUI(locale('press_e_open_garage'), { icon = 'fas fa-car-side', position = 'left-center' })
                        if IsControlJustPressed(0, 38) then
                            lib.hideTextUI()
                            lib.showContext('neko_gangs_garage_'..gang.id)
                        end
                    end
                end,
                onExit   = function() lib.hideTextUI() end
            })
        end
    end
end)

-- === Eventos
RegisterNetEvent('neko_gangs:client:garage:spawnvehicle', function(data)
    local vehModel   = data.model
    local vehPrefix  = data.prefix
    local vehColors  = data.colors
    local spawnPoint = data.spawn

    QBCore.Functions.SpawnVehicle(vehModel, function(veh)
        SetVehicleNumberPlateText(veh, vehPrefix..tostring(math.random(010000, 999999)))
        SetEntityHeading(veh, spawnPoint.w)
        exports[Config.settings.fuel]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleDirtLevel(veh, 1.0)
        SetVehicleCustomPrimaryColour(veh, vehColors.primary.r, vehColors.primary.g, vehColors.primary.b)
        SetVehicleCustomSecondaryColour(veh, vehColors.secondary.r, vehColors.secondary.g, vehColors.secondary.b)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, spawnPoint, true)
end)

RegisterNetEvent('neko_gangs:client:garage:deletevehicle', function()
    local car = GetVehiclePedIsIn(PlayerPedId(), true)
    DeleteVehicle(car)
    DeleteEntity(car)
end)

-- === eventos fivem
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerGang = PlayerData.gang
    end)
end)
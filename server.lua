local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("robbery:loot")
AddEventHandler("robbery:loot", function()
    local src = source
    local winNumber = math.random( 0, 100)
    if winNumber >= 30 then
        Rewards(src, "normalItems")
    elseif winNumber < 30 and winNumber > 2 then
        Rewards(src, "rareItems")
    else
        Rewards(src, "veryRareItems")
    end
end)

RegisterNetEvent('robbery:removerequireditem', function(data)
    local source = src
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem(Config.ItemRequired, 1)
end)

local function Rewards(src, type)
    local item = Config.Items[type][math.random(1,#Config.Items[type])]
    TriggerClientEvent('QBCore:Notify', src, 'You Found ' .. QBCore.Shared.Items[item].label .. '!', 'success', 5000)
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
end

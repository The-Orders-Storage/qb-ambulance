local useBridge = GetResourceState('community_bridge') ~= 'missing'
local QBCore = exports['qb-core']:GetCoreObject()

local Bridge = nil
local function GetBridge()
    return Bridge or exports['community_bridge']:Bridge()
end

function SendNotify(src, message, _type)
    if useBridge then
        Bridge = GetBridge()
        Bridge.Notify.SendNotify(src, message, _type)
    else
        exports['qb-core']:Notify(src, message, _type)
    end
end

function AddBanking(society, amount, reason)
    if useBridge then
        Bridge = GetBridge()
        Bridge.Banking.AddAccountMoney(society, amount, reason)
    else
        exports['qb-banking']:AddMoney(society, amount, reason)
    end
end

function AddItem(src, itemName, amount, slot, info, reason)
    if useBridge then
        Bridge = GetBridge()
        return Bridge.Inventory.AddItem(src, itemName, amount, slot, info, reason)
    else
        exports['qb-inventory']:AddItem(src, itemName, amount, slot, info, reason)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'add')
    end
end

function RemoveItem(src, itemName, amount, slot, reason)
    if useBridge then
        Bridge = GetBridge()
        return Bridge.Inventory.RemoveItem(src, itemName, amount, slot, reason)
    else
        exports['qb-inventory']:RemoveItem(src, itemName, amount, slot, reason)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
        return true
    end
end 

function OpenInventoryById(src, playerId)
    if useBridge then
        Bridge = GetBridge()
        Bridge.Inventory.OpenPlayerInventory(src, playerId)
    else
        exports['qb-inventory']:OpenInventoryById(src, playerId)
    end
end

function OpenInventory(src, id, data)
    if useBridge then
        Bridge = GetBridge()
        Bridge.Inventory.RegisterStash(id, id, data.slots, data.maxweight)
        Bridge.Inventory.OpenStash(src, 'stash', id)
    else
        exports['qb-inventory']:OpenInventory(src, id, data)
    end
end
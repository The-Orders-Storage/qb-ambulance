local useBridge = GetResourceState('community_bridge') ~= 'missing'
local QBCore = exports['qb-core']:GetCoreObject()

local Bridge = nil
local function GetBridge()
    return Bridge or exports['community_bridge']:Bridge()
end

function OpenMenu(menu)
    if useBridge then
        Bridge = GetBridge()
        Bridge.Menu.Open(menu, true)
    else
        exports['qb-menu']:openMenu(menu)
    end
end

function AddCircleZone(name, center, radius, options1, options2)
    if useBridge then
        Bridge = GetBridge()
        for i, d in pairs(options2.options) do
            if d.jobType then
                for k, v in pairs(QBCore.Shared.Jobs or {}) do
                    if v.type == d.jobType then
                        d.jobs = d.jobs or {}
                        d.jobs[k] = true
                    end
                end
            end
        end
        return Bridge.Target.AddSphereZone(name, center, radius, options2?.options or {} ,true)
    else
        return exports['qb-target']:AddCircleZone(name, center, radius, options1, options2)
    end
end

function AddBoxZone(name, center, volume, heading , options1, options2)
    if useBridge then
        Bridge = GetBridge()
        for i, d in pairs(options2.options) do
            if d.jobType then
                for k, v in pairs(QBCore.Shared.Jobs or {}) do
                    if v.type == d.jobType then
                        d.jobs = d.jobs or {}
                        d.jobs[k] = true
                    end
                end
            end
        end
        return Bridge.Target.AddBoxZone(name, center, vector3(volume, volume, volume), heading, options2?.options or {}, true)
    else
        return exports['qb-target']:AddBoxZone(name, center, volume, heading, options1, options2)
    end
end

function ShowInput(data)
    if useBridge then
        Bridge = GetBridge()
        return  Bridge.Input.Open(data.header, data, true, data.submitText)
    else
        return exports['qb-input']:ShowInput(data)
    end
end

function SendNotify( message, _type)
    if useBridge then
        Bridge = GetBridge()
        Bridge.Notify.SendNotify(message, _type)
    else
        exports['qb-core']:Notify(message, _type)
    end
end

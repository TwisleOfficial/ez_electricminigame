local wiringfix

RegisterNuiCallback('wiringfixSuccess', function(_, cb)
    if not wiringfix then return cb('ok') end
    SetNuiFocus(false, false)
    wiringfix:resolve(true)
    wiringfix = nil
    cb('ok')
end)

RegisterNuiCallback('wiringfixFail', function(_, cb)
    if not wiringfix then return cb('ok') end
    SetNuiFocus(false, false)
    wiringfix:resolve(false)
    wiringfix = nil
    cb('ok')
end)

---@param time number # Time in seconds
local function WiringFix(time)
    wiringfix = promise.new()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'startWiring',
        time = time
    })
    return Citizen.Await(wiringfix)
end
exports('WiringFix', WiringFix)

-- Test Command
RegisterCommand("testwiringfix",function()
    local success = exports.ez_electricminigame:WiringFix(15)
    print(success)
end, false)

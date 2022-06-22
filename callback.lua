if not IsDuplicityVersion() then 
    TriggerServerCallback =   function(name,cb,...)
        local p = promise.new() 
        local uuid = name
        TriggerServerEvent("n"..GetCurrentResourceName()..':RequestServerCallback',uuid,...)
        local tempEvent; tempEvent=RegisterNetEvent("n"..GetCurrentResourceName()..':ServerCallbackResultTo:'..uuid, function(...)
            local args = {...}
            if args[1] == nil then 
                p:reject() 
                RemoveEventHandler(tempEvent)
            else 
                p:resolve({...})
                RemoveEventHandler(tempEvent)
            end 
        end)
        cb(table.unpack(Citizen.Await(p)))
    end

    TriggerServerCallbackSynced = function(name,cb,...)
        local p = promise.new() 
        TriggerServerCallback(name, function(...)
            if cb then cb(...) end
            p:resolve({...})
        end, ...)
        return table.unpack(Citizen.Await(p)) 
    end 
else 
    
    local Callbacks = {}
    local CurrentIndex = 0
    RegisterServerCallback = function(name,cb)
        local uuid = name
        Callbacks[CurrentIndex+1] = {
            uuid = uuid,
            callback = cb,
        }
        CurrentIndex = CurrentIndex + 1
        if CurrentIndex > 2^15 then 
            CurrentIndex = 0
        end
        return uuid
    end

    RegisterNetEvent("n"..GetCurrentResourceName()..':RequestServerCallback', function(uuid,...)
        local Client = source
        local result
        local args = {...}
        for i,v in pairs(Callbacks) do 
            if v.uuid == uuid then 
                result = v.callback(Client,function(...)
                    --cb method
                    TriggerClientEvent("n"..GetCurrentResourceName()..':ServerCallbackResultTo:'..uuid,Client,...)
                end,table.unpack(args))
                
                break
            end 
        end
        --sync method (return on RegisterServerCallback)
        if result then
            TriggerClientEvent("n"..GetCurrentResourceName()..':ServerCallbackResultTo:'..uuid,Client,result)
        end 
    end)
end 

if not IsDuplicityVersion() then 
    local Callbacks = {}
    local CurrentIndex = 0
    RegisterClientCallback = function(name,cb)
        local uuid = name
        Callbacks[CurrentIndex+1] = {
            uuid = uuid,
            callback = cb,
        }
        CurrentIndex = CurrentIndex + 1
        if CurrentIndex > 2^15 then 
            CurrentIndex = 0
        end
        return uuid
    end

    RegisterNetEvent("n"..GetCurrentResourceName()..':RequestClientCallback'..GetPlayerServerId(PlayerId()), function(uuid,...)
        local result
        local args = {...}
        for i,v in pairs(Callbacks) do 
            if v.uuid == uuid then 
                result = v.callback(function(...)
                    --cb method
                    TriggerServerEvent("n"..GetCurrentResourceName()..':ClientCallbackResultTo:'..uuid..GetPlayerServerId(PlayerId()),...)
                end,table.unpack(args))
                
                break
            end 
        end
        --sync method (return on RegisterServerCallback)
        if result then
            TriggerServerEvent("n"..GetCurrentResourceName()..':ClientCallbackResultTo:'..uuid,result)
        end 
    end)
else 
    TriggerClientCallback = function(name,client,cb,...)
        if tonumber(client) == -1 then error("Client can not be set to -1 for the callback",2) end 
        local p = promise.new() 
        local uuid = name
        TriggerClientEvent("n"..GetCurrentResourceName()..':RequestClientCallback'..client,client,uuid,...)
        local tempEvent; tempEvent=RegisterNetEvent("n"..GetCurrentResourceName()..':ClientCallbackResultTo:'..uuid..client, function(...)
            local args = {...}
            if args[1] == nil or tonumber(client) ~= tonumber(source) then 
                p:reject() 
                RemoveEventHandler(tempEvent)
            else 
                p:resolve({...})
                RemoveEventHandler(tempEvent)
            end 
        end)
        cb(table.unpack(Citizen.Await(p)))
    end

    TriggerClientCallbackSynced = function(name,client,cb,...)
        local p = promise.new() 
        TriggerClientCallback(name,client, function(...)
            if cb then cb(...) end
            p:resolve({...})
        end, ...)
        return table.unpack(Citizen.Await(p)) 
    end 
    
end 
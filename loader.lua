local ORIGIN_CONFIG = {
    Version = "1.0.0",
    Protected = true,
    Debug = false,
    Server = "https://soon.../origin/"
}

local function ORIGIN_LOG(message)
    if ORIGIN_CONFIG.Debug then
        print("[ORIGIN] " .. message)
    end
end

local function ORIGIN_FETCH()
    local endpoint = ORIGIN_CONFIG.Server .. "init.lua"
    
    ORIGIN_LOG("Fetching from: " .. endpoint)
    
    local success, payload = pcall(function()
        return game:HttpGet(endpoint)
    end)
    
    if not success then
        error("[ORIGIN] Failed to fetch payload: " .. tostring(payload))
    end
    
    ORIGIN_LOG("Payload fetched successfully")
    return payload
end

local function ORIGIN_EXECUTE(payload)
    if ORIGIN_CONFIG.Protected then
        ORIGIN_LOG("Executing protected payload")
        local executor = loadstring(payload)
        
        if not executor then
            error("[ORIGIN] Failed to parse payload")
        end
        
        local success, result = pcall(executor)
        
        if not success then
            error("[ORIGIN] Execution failed: " .. tostring(result))
        end
        
        ORIGIN_LOG("Payload executed successfully")
        return result
    end
end

local function ORIGIN_INITIALIZE()
    ORIGIN_LOG("Initializing Origin Hub v" .. ORIGIN_CONFIG.Version)
    
    local payload = ORIGIN_FETCH()
    ORIGIN_EXECUTE(payload)
    
    ORIGIN_LOG("Origin Hub loaded successfully")
end

ORIGIN_INITIALIZE()

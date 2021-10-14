WarCry = WarCry or {}
WarCry.name = "WarCry"
WarCry.color = "8B0000"
WarCry.credits = "@m00nyONE"
WarCry.slashCmd = "/wc"
WarCry.variableVersion = 1
WarCry.List = {}
WarCry.defaultVariables = {
    groupCommands = true,
}

function WarCry:CreateWarCry(name, ids)
    if name == nil then d("|c8B0000WarCry:|r name must not be nil!") return end
    if type(ids) ~= "table" then d("|c8B0000WarCry:|r ids must be a table!") return end

    for index, value in ipairs(ids) do
        if type(value) ~="number" then d("|c8B0000WarCry:|r id must be a number!") return end
    end

    ---table.insert(WarCry.List, name, ids)
    WarCry.List[name] = {}
    WarCry.List[name].collectibleIDs = ids
end

function WarCry.PlayWarCry(name)
    if name == nil then return end
    if type(name) ~= "string" then return end

    local playable = {}
    if WarCry.List[name] ~= nil then
        for index, value in ipairs(WarCry.List[name].collectibleIDs) do
            if GetCollectibleUnlockStateById(value) == 2 then
                table.insert(playable, value)
            end
        end
        --- play random collectible from array
        UseCollectible(playable[ math.random(#playable)])
        return
    end

end

WarCry.chatCallback = function(_, messageType, _, message, _, fromDisplayName)
    -- check if message is in group chat
    if messageType == CHAT_CHANNEL_PARTY then
        -- check if message is the one we are listening for
        if WarCry.List[string.lower(message)] ~= nil then
            if fromDisplayName == GetUnitDisplayName(GetGroupLeaderUnitTag()) then
                -- play the warcry from the list
                WarCry.PlayWarCry(string.lower(message))
            end
        end
    end
end

function WarCry.toggleListener(value)
    -- toggle listener
    if value then
       WarCry.startChatListener()
    else
        WarCry.stopChatListener()
    end

    -- write value to saved vars
    WarCry.savedVariables.groupCommands = value
end

function WarCry.startChatListener()
    EVENT_MANAGER:RegisterForEvent(WarCry.name, EVENT_CHAT_MESSAGE_CHANNEL, WarCry.chatCallback)
    d("|c8B0000WarCry: group listener enabled|r")
end
function WarCry.stopChatListener()
    EVENT_MANAGER:UnregisterForEvent(WarCry.name, EVENT_CHAT_MESSAGE_CHANNEL)
    d("|c8B0000WarCry: group listener disabled|r")
end

--- create SLASH_COMMAND that can play every warcry available in the list
SLASH_COMMANDS["/warcry"] = function(str)
    if str ~= nil then
        if WarCry.List[string.lower(str)] ~= nil then
            WarCry.PlayWarCry(string.lower(str))
        end
    end
end

function WarCry.loadDefaults()
    local ahuListenString = "ahu"
    local ahuCollectibleIDs = {353}
    local roarListenString = "roar"
    local roarCollectibleIDs = {9432, 9590}

    WarCry:CreateWarCry(ahuListenString, ahuCollectibleIDs)
    WarCry:CreateWarCry(roarListenString, roarCollectibleIDs)
end

function WarCry.OnAddOnLoaded(event, addonName)
    if addonName == WarCry.name then
        --EVENT_MANAGER:RegisterForEvent("WarCry.name", EVENT_PLAYER_ACTIVATED, self.Init)

        WarCry.savedVariables = WarCry.savedVariables or {}
        WarCry.savedVariables = ZO_SavedVars:NewAccountWide("WarCryVars", WarCry.variableVersion, nil, WarCry.defaultVariables, GetWorldName())

        WarCry.loadDefaults()

        if WarCry.savedVariables.groupCommands == true then
            WarCry.startChatListener()
        end
    end
end

EVENT_MANAGER:RegisterForEvent(WarCry.name, EVENT_ADD_ON_LOADED, WarCry.OnAddOnLoaded)
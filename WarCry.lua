WarCry = {}
WarCry.name = "WarCry"
WarCry.color = "8B0000"
WarCry.credits = "@m00nyONE"
WarCry.slashCmd = "/wc"
WarCry.variableVersion = 1
WarCry.listenString = "ahu"
WarCry.defaultVariables = {
    collectibleID = 353,
    groupCommands = true,
}

ZO_CreateStringId("SI_BINDING_NAME_WARCRY_PLAY", "Play Warcry")
ZO_CreateStringId("SI_BINDING_NAME_WARCRY_GROUP_PLAY", "Play Group Warcry")

-- currently fixed
function WarCry.Play()
    UseCollectible(WarCry.savedVariables.collectibleID)
end

-- initiates a synced warcry event
function WarCry.GroupPlay()

    -- check if player is in a group
    if GetGroupSize() >= 1 then
        -- check if the player is the leader of the group
        if GetUnitDisplayName(GetGroupLeaderUnitTag()) == GetUnitDisplayName("player") then
            StartChatInput("/party " .. WarCry.listenString)
            return
        end
        d("|c8B0000WarCry: you are not the group leader. The command will do nothing.|r")
        return
    end
    d("|c8B0000WarCry: you are not in a group|r")
    return
end



WarCry.chatCallback = function(_, messageType, _, message, _, fromDisplayName)
    -- check if message is in group chat
    if messageType == CHAT_CHANNEL_PARTY then
        -- check if message is the one we are listening for
        if string.lower(message) == string.lower(WarCry.listenString) then
            -- check if the iniciator is group leader
            if fromDisplayName == GetUnitDisplayName(GetGroupLeaderUnitTag()) then
                WarCry.Play()
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


--[[
function WarCry:Init()
    EVENT_MANAGER:UnregisterForEvent("WarCry.name", EVENT_PLAYER_ACTIVATED)
end
]]--

function WarCry.OnAddOnLoaded(event, addonName)
    if addonName == WarCry.name then
        --EVENT_MANAGER:RegisterForEvent("WarCry.name", EVENT_PLAYER_ACTIVATED, self.Init)

        WarCry.savedVariables = WarCry.savedVariables or {}
        WarCry.savedVariables = ZO_SavedVars:NewAccountWide("WarCryVars", WarCry.variableVersion, nil, WarCry.defaultVariables, GetWorldName())

        WarCry.icon = GetCollectibleIcon(WarCry.savedVariables.collectibleID)

        if WarCry.savedVariables.groupCommands == true then
            WarCry.startChatListener()
        end
    end
end

EVENT_MANAGER:RegisterForEvent(WarCry.name, EVENT_ADD_ON_LOADED, WarCry.OnAddOnLoaded)

SLASH_COMMANDS["/ahu"] = function(str)
    WarCry.Play()
    return
end
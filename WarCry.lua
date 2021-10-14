WarCry = WarCry or {}
WarCry.ahuListenString = "ahu"
WarCry.ahuCollectibleIDs = {353}
WarCry.roarListenSTring = "roar"
WarCry.roarCollectibleIDs = {9432, 9590}


ZO_CreateStringId("SI_BINDING_NAME_WARCRY_AHU_PLAY", "Play AHU Warcry")
--- ZO_CreateStringId("SI_BINDING_NAME_WARCRY_AHU_GROUP_PLAY", "Play AHU Group Warcry")
ZO_CreateStringId("SI_BINDING_NAME_WARCRY_ROAR_PLAY", "Play ROAR Warcry")
--- ZO_CreateStringId("SI_BINDING_NAME_WARCRY_ROAR_GROUP_PLAY", "Play ROAR Group Warcry")

--[[ -- initiates a synced warcry event
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
end ]]


--[[
function WarCry:Init()
    EVENT_MANAGER:UnregisterForEvent("WarCry.name", EVENT_PLAYER_ACTIVATED)
end
]]--
WarCry = WarCry or {}
WarCry.name = "WarCry"
WarCry.credits = "@m00nyONE"

ZO_CreateStringId("SI_BINDING_NAME_WARCRY_AHU_PLAY", "Play AHU Warcry")
ZO_CreateStringId("SI_BINDING_NAME_WARCRY_ROAR_PLAY", "Play ROAR Warcry")

function WarCry.OnAddOnLoaded(event, addonName)
    if addonName == WarCry.name then
        local ahuListenString = "ahu"
        local ahuCollectibleIDs = {353}
        local roarListenString = "roar"
        local roarCollectibleIDs = {9432, 9590}
    
        LibWarCry:CreateWarCry(ahuListenString, ahuCollectibleIDs)
        LibWarCry:CreateWarCry(roarListenString, roarCollectibleIDs)
    end
end

EVENT_MANAGER:RegisterForEvent(WarCry.name, EVENT_ADD_ON_LOADED, WarCry.OnAddOnLoaded)
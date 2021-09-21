local LAM2 = LibAddonMenu2

local panelData = {
    type = "panel",
    name = "WarCry",
    displayName = "WarCry",
    author = "|cFFC0CBm00ny|r",
    version = "0.2.0",
    website = "https://www.esoui.com/downloads/fileinfo.php?id=3191",
    slashCommand = "/wcsettings",	--(optional) will register a keybind to open to this panel
    registerForRefresh = true,	--boolean (optional) (will refresh all options controls when a setting is changed and when the panel is shown)
    registerForDefaults = true,	--boolean (optional) (will set all options controls back to default values)
}

local optionsTable = {
    [1] = {
        type = "header",
        name = "general settings",
        width = "full",	--or "half" (optional)
    },
    [2] = {
        type = "slider",
        name = "Collectible ID",
        tooltip = "ID of the collectible that you want to play",
        min = 1,
        max = 1000,
        disabled = true,
        step = 1,	--(optional)
        getFunc = function() return WarCry.savedVariables.collectibleID end,
        setFunc = function(value) WarCry.savedVariables.collectibleID = value end,
        width = "half",	--or "half" (optional)
        default = 353,	--(optional)
    },
    [3] = {
        type = "texture",
        --image = "EsoUI\\Art\\ActionBar\\abilityframe64_up.dds",
        image = "/esoui/art/icons/trophy_malacaths_wrathful_flame.dds", -- needs to be dynamic
        imageWidth = 64,	--max of 250 for half width, 510 for full
        imageHeight = 64,	--max of 100
        width = "half",	--or "half" (optional)
    },
    [4] = {
        type = "header",
        name = "group control settings",
        width = "full",	--or "half" (optional)
    },
    [5] = {
        type = "checkbox",
        name = "synced warcry",
        tooltip = "enables/disables listening for chat events to sync warcry in the group",
        getFunc = function() return WarCry.savedVariables.groupCommands end,
        setFunc = function(value) WarCry.toggleListener(value) end,
        width = "full",	--or "half" (optional)
        default = true,
        --warning = "Will need to reload the UI.",	--(optional)
    },
}

LAM2:RegisterAddonPanel("WarCry", panelData)
LAM2:RegisterOptionControls("WarCry", optionsTable)
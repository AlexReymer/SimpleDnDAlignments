local config = require("cthelo.SimpleDnDAlignments.config")

local function registerMCM()
    local template = mwse.mcm.createmcm("Simple D&D Alignments")

    template:saveOnClose(config.configPath, config.mcm)
    local page = template:createSideBarPage("Settings")

    local sideBarText = (
        "Adds a simple alignment system, select your alignment after character creation " ..
        "for additional flavor and roleplay."
    )
    page.sidebar:createInfo{ text = sideBarText }

    page:createOnOffButton{
        label = "Enable Alignments",
        description = "Enable or disable the alignment system.",
        variable = mwse.mcm.createTableVariable{
            id = "enableAlignments",
            table = config.mcm
        }
    }

    page:createButton {
        buttonText = "Select Alignment",
        description = "Select your alignment, use this on existing characters or if you decide to change your alignment.",
        inGameOnly = true,
        callback = function()
            timer.delayOneFrame(function()
                createAlignmentMenu()
            end)
        end
    }

    page:createDropdown{
        label = "Alignment Type",
        description = "Classic includes the standard 3x3 alignment table, expanded includes the 5x5 alignment table.",
        options = {
            { label = "Classic", value = "Classic"},
            { label = "Expanded", value = "Expanded"}
        },
        variable = mwse.mcm.createTableVariable{ 
            id = "alignmentType", 
            table = config.mcm
        }
    }

    template:register()
end
event.register("modConfigReady", registerMCM)
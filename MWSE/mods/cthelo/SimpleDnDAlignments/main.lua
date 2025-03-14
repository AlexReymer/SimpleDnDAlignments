require("cthelo.SimpleDnDAlignments.MCM")
local config = require("cthelo.SimpleDnDAlignments.config")

local alignmentBlockId = "GUI_MenuStat_CharacterAlignment_Stat"
local alignmentValueLabelId = "AlignmentValueLabel"
local alignmentMenuId = "AlignmentSelectionMenu"
local alignmentDescriptionLabelId = "AlignmentDescriptionBlockLabel"
local alignmentDescriptionTextId = "AlignmentDescriptionBlockText"

local playerAlignment

local function createAlignmentTooltip()
    if tes3.player.data.ctheloAlignments == nil then
        return
    end
    local selectedAlignment = tes3.player.data.ctheloAlignments.alignment

    local tooltip = tes3ui.createTooltipMenu()
    local outerBlock = tooltip:createBlock()
    outerBlock.flowDirection = "top_to_bottom"
    outerBlock.paddingTop = 6
    outerBlock.paddingBottom = 12
    outerBlock.paddingLeft = 6
    outerBlock.paddingRight = 6
    outerBlock.width = 400
    outerBlock.autoHeight = true

    local header = outerBlock:createLabel{
        text = selectedAlignment.name
    }
    header.absolutePosAlignX = 0.5
    header.color = tes3ui.getPalette("header_color")


    local description = outerBlock:createLabel{
        text = selectedAlignment.description
    }
    description.autoHeight = true
    description.width = 285
    description.wrapText = true

    tooltip:updateLayout()
end

local function updateAlignmentStat()
    if tes3.player.data.ctheloAlignments == nil then
        return
    end
    local selectedAlignment = tes3.player.data.ctheloAlignments.alignment

    local menu = tes3ui.findMenu("MenuStat")
    if menu then
        local alignmentValueLabel = menu:findChild(alignmentValueLabelId)
        alignmentValueLabel.text = selectedAlignment.name
        
        menu:updateLayout()
    end
end
event.register("menuEnter", updateAlignmentStat)

local function createAlignmentStat(e)
    local menu = e.element
    local charBlock = menu:findChild("MenuStat_level_layout").parent

    -- local alignmentBlock = charBlock:findChild(alignmentBlockId)
    -- if alignmentBlock then alignmentBlock:destroy() end

    alignmentBlock = charBlock:createBlock({ id = alignmentBlockId})
    alignmentBlock.widthProportional = 1.0
    alignmentBlock.autoHeight = true

    local alignmentBlockLabel = alignmentBlock:createLabel{ text = "Alignment" }
    alignmentBlockLabel.color = tes3ui.getPalette("header_color")

    local alignmentValueBlock = alignmentBlock:createBlock()
    alignmentValueBlock.paddingLeft = 5
    alignmentValueBlock.autoHeight = true
    alignmentValueBlock.widthProportional = 1.0

    local alignmentValueLabel = alignmentValueBlock:createLabel{ id = alignmentValueLabelId,  text = "None" }
    if tes3.player.data.ctheloAlignments == nil then
        alignmentValueLabel.text = "None"
    else
        local selectedAlignment = tes3.player.data.ctheloAlignments.alignment
        alignmentValueLabel.text = selectedAlignment.name
    end
    alignmentValueLabel.wrapText = true
    alignmentValueLabel.widthProportional = 1
    alignmentValueLabel.justifyText = "right"

    alignmentBlockLabel:register("help", createAlignmentTooltip)
    alignmentValueBlock:register("help", createAlignmentTooltip)
    alignmentValueLabel:register("help", createAlignmentTooltip)

    menu:updateLayout()
end
event.register("uiActivated", createAlignmentStat, { filter = "MenuStat" })

local function alignmentClickHandler(alignment)
    playerAlignment = alignment

    local label = tes3ui.findMenu(alignmentMenuId):findChild(alignmentDescriptionLabelId)
    label.text = alignment.name

    local description = tes3ui.findMenu(alignmentMenuId):findChild(alignmentDescriptionTextId)
    description.text = alignment.description
    
    description:updateLayout()
end

function createAlignmentMenu(e)
    if not tes3.player then
        logger:error("No player, can't create perk menu")
        return
    end

    local alignmentMenu = tes3ui.createMenu{ id = alignmentMenuId, fixedFrame = true }
    local alignmentMenuBlock = alignmentMenu:createBlock()
    alignmentMenuBlock.flowDirection = "top_to_bottom"
    alignmentMenuBlock.autoHeight = true
    alignmentMenuBlock.autoWidth = true

    local alignmentMenuTitle = alignmentMenuBlock:createLabel{ id = "perksheading", text = "Select Alignment:" }
    alignmentMenuTitle.absolutePosAlignX = 0.5
    alignmentMenuTitle.borderTop = 4
    alignmentMenuTitle.borderBottom = 4

    local innerBlock = alignmentMenuBlock:createBlock{ id = "perkInnerBlock" }
    innerBlock.height = 350
    innerBlock.autoWidth = true
    innerBlock.flowDirection = "left_to_right"

    local alignmentListBlock = innerBlock:createVerticalScrollPane{ id = "alignmentListBlock" }
    alignmentListBlock.widthProportional = 1.0
    alignmentListBlock.minWidth = 300
    alignmentListBlock.maxWidth = 300
    alignmentListBlock.paddingAllSides = 4
    alignmentListBlock.borderRight = 6

    -- Check if the player is using expanded alignments, if so merge them into the alignments table
    local mergedAlignments = config.alignmentsTable
    if config.mcm.alignmentType == "Expanded" then
        for key,alignment in pairs(config.expandedAlignments) do 
            mergedAlignments[key] = alignment 
        end
    end
    local sortedAlignments = table.values(mergedAlignments, function(a, b) return a.order < b.order end)

    for _, alignment in pairs(sortedAlignments) do
        local alignmentButton = alignmentListBlock:createTextSelect{ id = "alignmentButton", text = alignment.name }
        alignmentButton.autoHeight = true
        alignmentButton.widthProportional = 1.0
        alignmentButton.paddingAllSides = 2
        alignmentButton.borderAllSides = 2
        
        alignmentButton:register("mouseClick", function()
            local currentAlignment = alignment
            alignmentClickHandler(currentAlignment)
        end )
    end

    do
        local alignmentDescriptionBlock = innerBlock:createThinBorder{ id = "alignmentDescriptionBlock" }
        alignmentDescriptionBlock.minWidth = 300
        alignmentDescriptionBlock.autoWidth = true
        alignmentDescriptionBlock.heightProportional = 1.0
        alignmentDescriptionBlock.borderRight = 10
        alignmentDescriptionBlock.flowDirection = "top_to_bottom"
        alignmentDescriptionBlock.paddingAllSides = 10

        local alignmentDescriptionLabel = alignmentDescriptionBlock:createLabel{ id = alignmentDescriptionLabelId, text = "" }
        alignmentDescriptionLabel.color = tes3ui.getPalette("header_color")

        local alignmentDescriptionText = alignmentDescriptionBlock:createLabel{ id = alignmentDescriptionTextId, text = "" }
        alignmentDescriptionText.wrapText = true
    end

    local alignmentMenuButtons = alignmentMenuBlock:createBlock()
    alignmentMenuButtons.flowDirection = "left_to_right"
    alignmentMenuButtons.widthProportional = 1.0
    alignmentMenuButtons.autoHeight = true
    alignmentMenuButtons.childAlignX = 1.0

    local rerollButton = alignmentMenuButtons:createButton{ text = "Reroll"}
    rerollButton:register("mouseClick", function()
        local alignmentList = alignmentListBlock:getContentElement().children
        alignmentList[ math.random(#alignmentList) ]:triggerEvent("mouseClick")
    end)

    local okayButton = alignmentMenuButtons:createButton{ id = "alignmentOkButton", text = tes3.findGMST(tes3.gmst.sOK).value }
    okayButton:register("mouseClick", function()
        alignmentMenu:destroy()
        tes3ui.leaveMenuMode()
        tes3.player.data.ctheloAlignments = {
            alignment = playerAlignment
        }
    end)

    alignmentMenu:updateLayout()
    tes3ui.enterMenuMode(alignmentMenuID)
end
event.register("charGenFinished", createAlignmentMenu)
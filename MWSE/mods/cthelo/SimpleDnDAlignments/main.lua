local alignmentBlockId = "GUI_MenuStat_CharacterAlignment_Stat"
local alignmentValueLabelId = "AlignmentValueLabel"
local alignmentMenuId = "AlignmentSelectionMenu"
local alignmentDescriptionLabelId = "AlignmentDescriptionBlockLabel"
local alignmentalignmentDescriptionTextId = "AlignmentDescriptionBlockText"

local alignmentsTable = {
    ["lawfulGood"] = {
        id = "lawfulGood",
        name = "Lawful Good",
        description = ("A lawful good character typically acts with compassion and always with honor " ..
            "and a sense of duty. However, lawful good characters will often regret taking any action " ..
            "they fear would violate their code, even if they recognize such action as being good."
        )
    },
    ["neutralGood"] = {
        id = "neutralGood",
        name = "Neutral Good",
        description = ("A neutral good character typically acts altruistically, without regard for or " .. 
            "against lawful precepts such as rules or tradition. A neutral good character has no problems " .. 
            "with cooperating with lawful officials, but does not feel beholden to them. In the event that " ..
            "doing the right thing requires the bending or breaking of rules, they do not suffer the same " ..
            "inner conflict that a lawful good character would."
        ) 
    }
}

local function updateAlignmentStat()
    local menu = tes3ui.findMenu("MenuStat")
    if menu then
        local alignmentValueLabel = menu:findChild(alignmentValueLabelId)
        alignmentValueLabel.text = "True Neutral"
        
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
    alignmentValueLabel.text = "True Neutral"
    alignmentValueLabel.wrapText = true
    alignmentValueLabel.widthProportional = 1
    alignmentValueLabel.justifyText = "right"


    alignmentBlockLabel:register("help", createBGTooltip )
    alignmentValueBlock:register("help", createBGTooltip )
    alignmentValueLabel:register("help", createBGTooltip )

    menu:updateLayout()
end
event.register("uiActivated", createAlignmentStat, { filter = "MenuStat" })

local function alignmentClickHandler(alignment)
    local label = tes3ui.findMenu(perksMenuID):findChild(alignmentDescriptionLabelId)
    label.text = alignment.name

    local description = tes3ui.findMenu(perksMenuID):findChild(alignmentalignmentDescriptionTextId)
    description.text = alignment.description
    
    description:updateLayout()
end

local function createAlignmentMenu(e)
    if not tes3.player then
        logger:error("No player, can't create perk menu")
        return
    end

    config.persistent.currentBackground = config.persistent.currentBackground or "none"
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

    for _, alignment in next,alignmentsTable do
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
    end)

    alignmentMenu:updateLayout()
    tes3ui.enterMenuMode(alignmentMenuID)
end
event.register("charGenFinished", createAlignmentMenu)
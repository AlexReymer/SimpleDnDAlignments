require("cthelo.SimpleDnDAlignments.MCM")

local alignmentBlockId = "GUI_MenuStat_CharacterAlignment_Stat"
local alignmentValueLabelId = "AlignmentValueLabel"
local alignmentMenuId = "AlignmentSelectionMenu"
local alignmentDescriptionLabelId = "AlignmentDescriptionBlockLabel"
local alignmentDescriptionTextId = "AlignmentDescriptionBlockText"

local alignmentsTable = {
    ["lawfulGood"] = {
        id = "lawfulGood",
        order = 0,
        name = "Lawful Good",
        description = (
            "A lawful good character typically acts with compassion and always with honor " ..
            "and a sense of duty. However, lawful good characters will often regret taking any action " ..
            "they fear would violate their code, even if they recognize such action as being good."
        )
    },
    ["neutralGood"] = {
        id = "neutralGood",
        order = 2,
        name = "Neutral Good",
        description = (
            "A neutral good character typically acts altruistically, without regard for or " .. 
            "against lawful precepts such as rules or tradition. A neutral good character has no problems " .. 
            "with cooperating with lawful officials, but does not feel beholden to them. In the event that " ..
            "doing the right thing requires the bending or breaking of rules, they do not suffer the same " ..
            "inner conflict that a lawful good character would."
        )
    },
    ["chaoticGood"] = {
        id = "chaoticGood",
        order = 4,
        name = "Chaotic Good",
        description = (
            "A chaotic good character does whatever is necessary to bring about change for the better, " .. 
            "disdains bureaucratic organizations that get in the way of social improvement, and places a " ..
            "high value on personal freedom, not only for oneself but for others as well. Chaotic good " ..
            "characters usually intend to do the right thing, but their methods are generally disorganized " ..
            "and often out of sync with the rest of society."
        )
    },
    ["lawfulNeutral"] = {
        id = "lawfulNeutral",
        order = 10,
        name = "Lawful Neutral",
        description = (
            "A lawful neutral character typically believes strongly in lawful concepts such as honor, order, " ..
            "rules, and tradition, but often follows a personal code in addition to, or even in preference to, " ..
            "one set down by a benevolent authority."
        )
    },
    ["trueNeutral"] = {
        id = "trueNeutral",
        order = 12,
        name = "True Neutral",
        description = (
            "A true neutral character is neutral on both axes and tends not to feel strongly towards any alignment, " ..
            "or actively seeks their balance."
        )
    },
    ["chaoticNeutral"] = {
        id = "chaoticNeutral",
        order = 14,
        name = "Chaotic Neutral",
        description = (
            "A chaotic neutral character is an individualist who follows their own heart and generally shirks rules and " ..
            "traditions. Although chaotic neutral characters promote the ideals of freedom, it is their own freedom that " ..
            "comes first; good and evil come second to their need to be free."
        )
    },
    ["lawfulEvil"] = {
        id = "lawfulEvil",
        order = 20,
        name = "Lawful Evil",
        description = (
            "A lawful evil character sees a well-ordered system as being necessary to fulfill their own personal wants" ..
            " and needs, using these systems to further their power and influence."
        )
    },
    ["neutralEvil"] = {
        id = "neutralEvil",
        order = 22,
        name = "Neutral Evil",
        description = (
            "A neutral evil character is typically selfish and has no qualms about turning on allies-of-the-moment, and " ..
            " usually makes allies primarily to further their own goals. A neutral evil character has no compunctions " ..
            "about harming others to get what they want, but neither will they go out of their way to cause carnage or " ..
            "mayhem when they see no direct benefit for themselves. Another valid interpretation of neutral evil holds " ..
            "up evil as an ideal, doing evil for evil's sake and trying to spread its influence."
        )
    },
    ["chaoticEvil"] = {
        id = "chaoticEvil",
        order = 24,
        name = "Chaotic Evil",
        description = (
            "A chaotic evil character tends to have no respect for rules, other people's lives, or anything but their own " ..
            "desires, which are typically selfish and cruel. They set a high value on personal freedom, but do not have " ..
            "much regard for the lives or freedom of other people. Chaotic evil characters do not work well in groups " ..
            "because they resent being given orders and usually do not behave themselves unless there is no alternative."
        )
    },
}

local selectedAlignmentId = "none"

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
    selectedAlignmentId = alignment.id

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

    local sortedAlignments = table.values(alignmentsTable, function(a, b) return a.order < b.order end)

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
            alignment = alignmentsTable[selectedAlignmentId]
        }
    end)

    alignmentMenu:updateLayout()
    tes3ui.enterMenuMode(alignmentMenuID)
end
event.register("charGenFinished", createAlignmentMenu)
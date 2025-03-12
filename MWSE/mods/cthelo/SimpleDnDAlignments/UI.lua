local alignmentBlockId = "GUI_MenuStat_CharacterAlignment_Stat"
local alignmentValueLabelId = "AlignmentValueLabel"

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
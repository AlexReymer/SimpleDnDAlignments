---@class DnDAlignments.Config
local config = {}

config.configPath = "SimpleDnDAlignments"

---@class DnDAlignments.Config.mcmDefault
config.mcmDefault = {
    ---@type boolean mod toggle
    enableAlignments = true,
    ---@type string 3x3 or 5x5 alignment table
    alignmentType = "Classic"
}

---@type CharacterBackgrounds.Config.mcm
config.mcm = mwse.loadConfig(config.configPath, config.mcmDefault)

return config
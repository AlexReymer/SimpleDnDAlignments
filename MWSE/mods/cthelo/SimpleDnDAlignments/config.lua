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

---@type DnDAlignments.Config.mcm
config.mcm = mwse.loadConfig(config.configPath, config.mcmDefault)

---@type DnDAlignments.Config.alignmentsTable
config.alignmentsTable = {
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
    }
}

---@type DnDAlignments.Config.expandedAlignments
config.expandedAlignments = {
    ["Social Good"] = {
        id = "socialGood",
        order = 1,
        name = "Social Good",
        description = {}
    },
    ["Rebel Good"] = {
        id = "rebelGood",
        order = 3,
        name = "Rebel Good",
        description = {}
    },
    ["Lawful Moral"] = {
        id = "lawfulMoral",
        order = 5,
        name = "Lawful Moral",
        description = {}
    },
    ["Social Moral"] = {
        id = "socialMoral",
        order = 6,
        name = "Social Moral",
        description = {}
    },
    ["Neutral Moral"] = {
        id = "neutralMoral",
        order = 7,
        name = "Neutral Moral",
        description = {}
    },
    ["Rebel Moral"] = {
        id = "rebelMoral",
        order = 8,
        name = "Rebel Moral",
        description = {}
    },
    ["Chaotic Moral"] = {
        id = "chaoticMoral",
        order = 9,
        name = "Chaotic Moral",
        description = {}
    },
    ["Social Neutral"] = {
        id = "socialNeutral",
        order = 11,
        name = "Social Neutral",
        description = {}
    },
    ["Rebel Neutral"] = {
        id = "rebelNeutral",
        order = 13,
        name = "Rebel Neutral",
        description = {}
    },
    ["Lawful Impure"] = {
        id = "lawfulImpure",
        order = 15,
        name = "Lawful Impure",
        description = {}
    },
    ["Social Impure"] = {
        id = "socialImpure",
        order = 16,
        name = "Social Impure",
        description = {}
    },
    ["Neutral Impure"] = {
        id = "Neutral Impure",
        order = 17,
        name = "Neutral Impure",
        description = {}
    },
    ["Rebel Impure"] = {
        id = "rebelImpure",
        order = 18,
        name = "Rebel Impure",
        description = {}
    },
    ["Chaotic Impure"] = {
        id = "chaoticImpure",
        order = 19,
        name = "Chaotic Impure",
        description = {}
    },
    ["Social Evil"] = {
        id = "socialEvil",
        order = 21,
        name = "Social Evil",
        description = {}
    },
    ["Rebel Evil"] = {
        id = "rebelEvil",
        order = 23,
        name = "Rebel Evil",
        description = {}
    }
}

return config
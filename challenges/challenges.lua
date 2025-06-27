local sinnoh_adv = {
    object_type = "Challenge",
    key = "sinnoh_adv",
    rules = {
        custom = {
            { id = 'sinnoh_adv' },
        },
    },
    vouchers = {
        {id = "v_overstock_norm"},
    }
}

local hibernation = {
    object_type = "Challenge",
    key = "hibernation",
    jokers = {
        {id = "j_nacho_skwovet", eternal = true},
        {id = "j_poke_munchlax", eternal = true},
    },
    restrictions = {
        banned_cards = {
            { id = 'j_perkeo' },
        }
    },
}

local gems = {
    object_type = "Challenge",
    key = "gems",
    jokers = {
        {id = "j_nacho_carbink", eternal = true},
        {id = "j_poke_roggenrola", eternal = true},
    },
    rules = {
        custom = {
            { id = 'no_reward' },
            { id = 'no_interest' },
        },
        modifiers = {
            { id = 'dollars',  value = 0 },
        },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_poke_chikorita' },
            { id = 'j_poke_bayleef' },
            { id = 'j_poke_meganium' },
        }
    },
}





return {name = "Challenges",
    list = {sinnoh_adv, hibernation, gems}
}
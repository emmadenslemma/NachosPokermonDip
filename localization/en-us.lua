return {
    descriptions = {
        Joker = {
            j_nacho_turtwig = {
                name = "Turtwig",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Played cards have a {C:green}1 in #2#{}",
                    "chance of earning {C:money}$#3#{}",
                    "{C:inactive,s:0.8}(Odds increase per scored card beyond the first)",
                    "Cards {C:attention}held in hand{}",
                    "give Mult equal to {C:money}${}",
                    "earned this way",
                    "{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#4#{C:inactive,s:0.8})",
                } 
            },
            j_nacho_grotle = {
                name = "Grotle",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Played cards have a {C:green}1 in #2#{}",
                    "chance of earning {C:money}$#3#{}",
                    "{C:inactive,s:0.8}(Odds increase per scored card beyond the first)",
                    "Cards {C:attention}held in hand{}",
                    "give Mult equal to {C:money}${}",
                    "earned this way",
                    "{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#4#{C:inactive,s:0.8})",
                } 
            },
            j_nacho_torterra = {
                name = "Torterra",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Played cards have a {C:green}1 in #2#{}",
                    "chance of earning {C:money}$#3#{}",
                    "{C:inactive,s:0.8}(Odds increase per scored card beyond the first)",
                    "Cards {C:attention}held in hand{}",
                    "give Chips and Mult equal to {C:money}${}",
                    "earned this way",
                } 
            },
            j_nacho_chimchar = {
                name = "Chimchar",
                text = {
                    "{C:red}+#1#{} discard",
                    "Adds the rank of",
                    "{C:attention}highest{} ranked card",
                    "discarded to Mult",
                    "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult)",        
                    "{C:inactive,s:0.8}(Evolves after scoring {C:red,s:0.8}+11{} {C:inactive,s:0.8}Mult{} {C:attention,s:0.8}#3#{C:inactive,s:0.8} Times){}",
                }
            },
            j_nacho_monferno = {
                name = "Monferno",
                text = {
                    "{C:red}+#1#{} discard",
                    "Gains Mult equal to the rank",
                    "of {C:attention}highest{} ranked card discarded",
                    "{C:inactive,s:0.8}(Resets at end of round)",
                    "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult)",
                    "{C:inactive,s:0.8}(Evolves after scoring {C:red,s:0.8}+30{} {C:inactive,s:0.8}Mult{} {C:attention,s:0.8}#3#{C:inactive,s:0.8} Times){}",
                }
            },
            j_nacho_infernape = {
                name = "Infernape",
                text = {
                    "{C:red}+#1#{} discard, {C:mult}+#2#{} mult",
                    "Gains {C:mult}X#3#{} mult for each",
                    "discarded {C:attention}face card{} or {C:attention}Ace{}",
                    "{C:inactive,s:0.8}(Resets at end of round)",
                    "{C:inactive}(Currently {C:mult}X#4#{} {C:inactive}Mult)",
                }
            },
            j_nacho_piplup = {
                name = "Piplup",
                text = {
                    "{C:blue}+#1#{} hand, {C:chips}+#2#{} Chips",
                    "{C:chips}-#3#{} Chips per scoring card",
                    "in played hand",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#4#{C:inactive,s:0.8} rounds)",
                } 
            },
            j_nacho_prinplup = {
                name = "Prinplup",
                text = {
                    "{C:blue}+#1#{} hand, {C:chips}+#2#{} Chips",
                    "Each Bonus card held in hand",
                    "gives {C:chips}+#3#{} Chips",
                    "If played hand has exactly 1 card,",
                    "it becomes a Bonus card",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#4#{C:inactive,s:0.8} rounds)",
                } 
            },
            j_nacho_empoleon = {
                name = "Empoleon",
                text = {
                    "{C:blue}+#1#{} hand, {C:chips}+#2#{} Chips",
                    "Each Bonus card held in hand",
                    "gives {C:chips}+#3#{} Chips",
                    "If played hand has exactly 1 card,",
                    "it becomes a Bonus card",
                    "Bonus Cards are also considered Steel Cards",
                } 
            },
        }
    },
    misc = {
        dictionary = {
            -- From Infernape
            poke_close_combat_ex = "Close Combat!",
            -- From Empoleon
            poke_brine_ex = "Brine!",
        },
    },
}



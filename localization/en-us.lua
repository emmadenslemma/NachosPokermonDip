return {
    descriptions = {
        Joker = {
            j_nacho_turtwig = {
                name = "Turtwig",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Cards {C:attention}held in hand{} have a {C:green}1 in #2#{}",
                    "chance of earning {C:money}$#3#{}",
                    "{C:inactive,s:0.8}(Odds increase by 1 per", 
                    "{C:inactive,s:0.8}scoring card beyond the first)",
                    "{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#4#{C:inactive,s:0.8})",
                } 
            },
            j_nacho_grotle = {
                name = "Grotle",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Cards {C:attention}held in hand{} have a {C:green}1 in #2#{}",
                    "chance of earning {C:money}$#3#{}",
                    "{C:inactive,s:0.8}(Odds increase by 1 per", 
                    "{C:inactive,s:0.8}scoring card beyond the first)",
                    "{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#4#{C:inactive,s:0.8})",
                } 
            },
            j_nacho_torterra = {
                name = "Torterra",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "{C:mult}+#2#{} Mult for every {C:money}$10{} you have",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Cards {C:attention}held in hand{} have a {C:green}1 in #3#{}",
                    "chance of earning {C:money}$#4#{}",
                    "{C:inactive,s:0.8}(Odds increase by 1 per", 
                    "{C:inactive,s:0.8}scoring card beyond the first)",
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
                    "{C:red}+#1#{} discard, {C:mult}+#2#{} Mult",
                    "Gains {C:mult}X#3#{} Mult for each",
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
                    "{br:2}ERROR - CONTACT STEAK",
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
                    "{br:2}ERROR - CONTACT STEAK",
                    "If played hand has exactly 1 card,",
                    "it becomes a Bonus card",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Bonus Cards are also",
                    "considered Steel Cards",
                } 
            },
            j_nacho_hisuian_zorua = {
                name = "{s:0.6}Hisuian{}Zorua",
                text = {
                    "{V:1}Copies ability of leftmost {C:attention}Joker{}",
                    "{br:2.5}ERROR - CONTACT STEAK",
                    "After scoring played hand while",
                    "copying, remove copy effect",
                    "until end of round",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#1#{C:inactive,s:0.8} rounds)",
                }
            },
            j_nacho_hisuian_zoroark = {
                name = "{s:0.6}Hisuian{}Zoroark",
                text = {
                    "Copies ability of leftmost {C:attention}Joker{}",
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



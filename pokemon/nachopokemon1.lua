function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Turtwig 387
local turtwig={
  name = "turtwig",
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 0},
  config = {extra = {h_size = 1, multi = 0, odds = 15, money_mod = 1, money_earned = 0}, evo_rqmt = 20},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local money_left = math.max(0, self.config.evo_rqmt - card.ability.extra.money_earned)
    return {vars = {card.ability.extra.h_size, card.ability.extra.odds, card.ability.extra.money_mod, money_left}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Grass",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)

    if context.individual and not context.end_of_round and context.cardarea == G.play then
      if context.other_card == context.scoring_hand[1] and not context.repetition then
        card.ability.extra.multi = 0
      end
      if (pseudorandom('torterra') < (G.GAME.probabilities.normal + #context.scoring_hand - 1)/card.ability.extra.odds) and not context.other_card.debuff then
        local earned = ease_poke_dollars(card, "turtwig", card.ability.extra.money_mod, true)
        card.ability.extra.money_earned = card.ability.extra.money_earned + earned
        card.ability.extra.multi = card.ability.extra.multi + earned
          return {
            dollars = earned,
            card = card,
          }
      end
    end
    
    if context.individual and not context.end_of_round and context.cardarea == G.hand and card.ability.extra.multi > 0 then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          return {
              h_mult = card.ability.extra.multi,
              card = card,
          }
      end
    end
    return scaling_evo(self, card, context, "j_nacho_grotle", card.ability.extra.money_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end
}

-- Grotle 388
local grotle={
  name = "grotle",
  poke_custom_prefix = "nacho",
  pos = {x = 1, y = 0},
  config = {extra = {h_size = 1, multi = 0, odds = 10, money_mod = 2, money_earned = 0}, evo_rqmt = 30},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local money_left = math.max(0, self.config.evo_rqmt - card.ability.extra.money_earned)
    return {vars = {card.ability.extra.h_size, card.ability.extra.odds, card.ability.extra.money_mod, money_left}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Grass",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)

    if context.individual and not context.end_of_round and context.cardarea == G.play then
      if context.other_card == context.scoring_hand[1] and not context.repetition then
        card.ability.extra.multi = 0
      end
      if (pseudorandom('torterra') < (G.GAME.probabilities.normal + #context.scoring_hand - 1)/card.ability.extra.odds) and not context.other_card.debuff then
        local earned = ease_poke_dollars(card, "torterra", card.ability.extra.money_mod, true)
        card.ability.extra.money_earned = card.ability.extra.money_earned + earned
        card.ability.extra.multi = card.ability.extra.multi + earned
          return {
            dollars = earned,
            card = card,
          }
      end
    end

    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          return {
              h_mult = card.ability.extra.multi,
              card = card,
          }
      end
    end
    return scaling_evo(self, card, context, "j_nacho_torterra", card.ability.extra.money_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end
}

-- Torterra 389
local torterra={
  name = "torterra",
  poke_custom_prefix = "nacho",
  pos = {x = 2, y = 0},
  config = {extra = {h_size = 1, chipsi = 0, multi = 0, odds = 5, money_mod = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.h_size, card.ability.extra.odds, card.ability.extra.money_mod}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Grass",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)

    if context.individual and not context.end_of_round and context.cardarea == G.play then
      if context.other_card == context.scoring_hand[1] and not context.repetition then
        card.ability.extra.chipsi = 0
        card.ability.extra.multi = 0
      end
      if (pseudorandom('torterra') < (G.GAME.probabilities.normal + #context.scoring_hand - 1)/card.ability.extra.odds) and not context.other_card.debuff then
        local earned = ease_poke_dollars(card, "torterra", card.ability.extra.money_mod, true)
        card.ability.extra.chipsi = card.ability.extra.chipsi + earned
        card.ability.extra.multi = card.ability.extra.multi + earned
          return {
            dollars = earned,
            card = card,
          }
      end
    end

    if context.individual and not context.end_of_round and context.cardarea == G.hand and card.ability.extra.multi > 0 then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          return {
              h_chips = card.ability.extra.chipsi,
              h_mult = card.ability.extra.multi,
              card = card,
          }
      end
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end
}

-- Chimchar 390
local chimchar={
  name = "chimchar",
  poke_custom_prefix = "nacho",
  pos = {x = 3, y = 0},
  config = {extra = {d_size = 1, mult = 0, mult_mod = 0, max_scored = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, math.max(0, self.config.evo_rqmt - card.ability.extra.max_scored)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Fire",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  
  calculate = function(self, card, context)
    if context.discard and not context.blueprint and not context.other_card.debuff then
      local prev_mult = card.ability.extra.mult

      if card.ability.extra.mult_mod < context.other_card:get_id() then
        card.ability.extra.mult_mod = context.other_card:get_id()
      end

      if context.other_card == context.full_hand[#context.full_hand] then
        if card.ability.extra.mult_mod >= 11 and card.ability.extra.mult_mod <= 13 then card.ability.extra.mult = 10
        elseif card.ability.extra.mult_mod == 14 then card.ability.extra.mult = 11
        else card.ability.extra.mult = card.ability.extra.mult_mod end
        if card.ability.extra.mult > prev_mult then
          return {
              message = localize('k_upgrade_ex'),
              colour = G.C.RED
          }
        end
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult = card.ability.extra.mult
        }
      end
    end

    if context.end_of_round and context.game_over == false and not context.blueprint and not context.repetition and not context.individual then
      if card.ability.extra.mult == 11 then
          card.ability.extra.max_scored = card.ability.extra.max_scored + 1
      end
      card.ability.extra.mult = 0
      card.ability.extra.mult_mod = 0
      local evolved = scaling_evo(self, card, context, "j_nacho_monferno", card.ability.extra.max_scored, self.config.evo_rqmt)
      if evolved then
        return evolved
      else
        return {
          message = localize('k_reset'),
          colour = G.C.RED
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
}

-- Monferno 391
local monferno={
  name = "monferno",
  poke_custom_prefix = "nacho",
  pos = {x = 4, y = 0},
  config = {extra = {d_size = 1, mult = 0, mult_mod = 0, max_scored = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, math.max(0, self.config.evo_rqmt - card.ability.extra.max_scored)}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fire",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,

  calculate = function(self, card, context)
    
    if context.discard and not context.blueprint and not context.other_card.debuff then

      if card.ability.extra.mult_mod < context.other_card:get_id() then
        card.ability.extra.mult_mod = context.other_card:get_id()
      end

      if context.other_card == context.full_hand[#context.full_hand] then
        if card.ability.extra.mult_mod >= 11 and card.ability.extra.mult_mod <= 13 then card.ability.extra.mult = card.ability.extra.mult + 10
        elseif card.ability.extra.mult_mod == 14 then card.ability.extra.mult = card.ability.extra.mult + 11
        else card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod end
        card.ability.extra.mult_mod = 0
        return {
            message = localize('k_upgrade_ex'),
            colour = G.C.RED
        }
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult = card.ability.extra.mult
        }
      end
    end

    if context.end_of_round and context.game_over == false and not context.blueprint and not context.repetition and not context.individual then
      if card.ability.extra.mult >= 30 then
        card.ability.extra.max_scored = card.ability.extra.max_scored + 1
      end
      card.ability.extra.mult = 0
      card.ability.extra.mult_mod = 0
      local evolved = scaling_evo(self, card, context, "j_nacho_infernape", card.ability.extra.max_scored, self.config.evo_rqmt)
      if evolved then
        return evolved
      else
        return {
          message = localize('k_reset'),
          colour = G.C.RED
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
}

-- Infernape 392
local infernape = {
  name = "infernape",
  poke_custom_prefix = "nacho",
  pos = {x = 5, y = 0},
  config = {extra = {d_size = 1, mult = 30, Ymult = 1.0, Xmult_mod = 0.3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, card.ability.extra.Xmult_mod, card.ability.extra.Ymult}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fire",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,

  calculate = function(self, card, context)

    if context.discard and not context.blueprint and not context.other_card.debuff then
      if context.other_card:is_face() or context.other_card:get_id() == 14 then 
        card.ability.extra.Ymult = card.ability.extra.Ymult + card.ability.extra.Xmult_mod
        return {
              message = localize('k_upgrade_ex'),
              colour = G.C.RED
          }
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize("poke_close_combat_ex"),
          colour = G.C.XMULT,
          mult_mod = card.ability.extra.mult,
          Xmult_mod = card.ability.extra.Ymult,
        }
      end
    end

    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
        card.ability.extra.Ymult = 1.0
        return {
            message = localize('k_reset'),
            colour = G.C.RED
        }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
}

-- Piplup 393
local piplup={
  name = "piplup",
  poke_custom_prefix = "nacho",
  pos = {x = 6, y = 0},
  config = {extra = {hands = 1, chips = 80, chip_loss = 20, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_loss, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Water",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
     if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local chip_total = card.ability.extra.chips - card.ability.extra.chip_loss * (#context.scoring_hand)
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {chip_total}}, 
          colour = G.C.CHIPS,
          chips = chip_total,
        }
      end
    end
    return level_evo(self, card, context, "j_nacho_prinplup")
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end
}

-- Prinplup 394
local prinplup={
  name = "prinplup",
  poke_custom_prefix = "nacho",
  pos = {x = 7, y = 0},
  config = {extra = {hands = 1, chips = 30, chip_mod = 30, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Water",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint then
      if context.full_hand and #context.full_hand == 1 then
        for k, v in ipairs(context.scoring_hand) do
          message = localize("poke_brine_ex"),
          v:set_ability(G.P_CENTERS.m_bonus, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              card:juice_up()
              return true
            end
          }))
        end
        return {message = localize("poke_brine_ex"),}
      end
    end
      
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if SMODS.get_enhancements(context.other_card)["m_bonus"] == true then
        return {
          h_chips = card.ability.extra.chip_mod,
          card = card,
        }
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
          colour = G.C.CHIPS,
          chips = card.ability.extra.chips,
        }
      end
    end
    return level_evo(self, card, context, "j_nacho_empoleon")
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end
}

-- Empoleon 395
local empoleon={
  name = "empoleon",
  poke_custom_prefix = "nacho",
  pos = {x = 8, y = 0},
  config = {extra = {hands = 1, chips = 50, chip_mod = 30}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Water",
  atlas = "nacho_pokedex_4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.check_enhancement and not context.blueprint then
      if context.other_card.config.center.key == "m_bonus" then
          return {m_steel = true}
      end
    end

    if context.before and context.cardarea == G.jokers and not context.blueprint then
      if context.full_hand and #context.full_hand == 1 then
        for k, v in ipairs(context.scoring_hand) do
          v:set_ability(G.P_CENTERS.m_bonus, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              card:juice_up()
              return true
            end
          }))
        end
        return {message = localize("poke_brine_ex"),}
      end
    end
      
     if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if SMODS.get_enhancements(context.other_card)["m_bonus"] == true then
        return {
          h_chips = card.ability.extra.chip_mod,
          card = card,
        }
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.chips}}, 
          colour = G.C.CHIPS,
          chips = card.ability.extra.chips,
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end
}
--

list = {turtwig, grotle, torterra, chimchar, monferno, infernape, piplup, prinplup, empoleon}

return {name = "nachopokemon1",
list = list
}
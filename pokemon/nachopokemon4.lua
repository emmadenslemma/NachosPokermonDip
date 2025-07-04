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
  pos = {x = 0, y = 0},
  config = {extra = {h_size = 1, interest = 5, counter = 0, money = 0, money_mod = 0, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.h_size, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Grass",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers then
      local evolved = level_evo(self, card, context, "j_nacho_grotle")
      if evolved then
        card.ability.extra.money = card.ability.extra.counter
        return evolved
      end
      card.ability.extra.counter = card.ability.extra.counter + 1
      G.GAME.interest_cap = G.GAME.interest_cap + card.ability.extra.interest
      return {
          message = localize("poke_leech_seed_ex"),
          card = card,
        }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
    G.GAME.interest_cap = G.GAME.interest_cap - card.ability.extra.counter * card.ability.extra.interest
  end,
}

-- Grotle 388
local grotle={
  name = "grotle",
  pos = {x = 1, y = 0},
  config = {extra = {h_size = 1, interest = 5, counter = 0, money = 0, money_mod = 0, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho, ESN64"}}
    return {vars = {card.ability.extra.h_size, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Grass",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind or context.pre_discard then
      local old_h_size = card.ability.extra.h_size
      if (SMODS.Mods["Talisman"] or {}).can_load then
        local dollars = to_number(G.GAME.dollars)
        if card.ability.extra.h_size ~= math.floor(((dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15) then
          card.ability.extra.h_size = math.floor(((dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15)
        end
      else
        if card.ability.extra.h_size ~= math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15) then
          card.ability.extra.h_size = math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15)
        end
      end
      if card.ability.extra.h_size > 2 then card.ability.extra.h_size = 2 end
      if card.ability.extra.h_size == old_h_size then return end
      G.hand:change_size(card.ability.extra.h_size - old_h_size)
    end
    if context.end_of_round and context.cardarea == G.jokers then
      local evolved = level_evo(self, card, context, "j_nacho_torterra")
      if evolved then
        card.ability.extra.money = card.ability.extra.counter
        return evolved
      end
      card.ability.extra.counter = card.ability.extra.counter + 2
      G.GAME.interest_cap = G.GAME.interest_cap + card.ability.extra.interest * 2
      return {
          message = localize("poke_leech_seed_ex"),
          card = card,
        }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.0, func = function()
              card.ability.extra.counter = card.ability.extra.money
              G.GAME.interest_cap = G.GAME.interest_cap + card.ability.extra.counter * card.ability.extra.interest
              return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
    G.GAME.interest_cap = G.GAME.interest_cap - card.ability.extra.counter * card.ability.extra.interest
  end,
}

-- Torterra 389
local torterra={
  name = "torterra",
  pos = {x = 2, y = 0},
  config = {extra = {h_size = 0, interest = 5, counter = 0, money = 0, money_mod = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho, ESN64"}}
    return {vars = {card.ability.extra.h_size, card.ability.extra.mult}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Grass",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind or context.pre_discard then
      local old_h_size = card.ability.extra.h_size
      if (SMODS.Mods["Talisman"] or {}).can_load then
        local dollars = to_number(G.GAME.dollars)
        if card.ability.extra.h_size ~= math.floor(((dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15) then
          card.ability.extra.h_size = math.floor(((dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15)
        end
      else
        if card.ability.extra.h_size ~= math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15) then
          card.ability.extra.h_size = math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 15)
        end
      end
      if card.ability.extra.h_size > 4 then card.ability.extra.h_size = 4 end
      if card.ability.extra.h_size == old_h_size then return end
      G.hand:change_size(card.ability.extra.h_size - old_h_size)
    end
    if context.end_of_round and context.cardarea == G.jokers then
      card.ability.extra.counter = card.ability.extra.counter + 3
      G.GAME.interest_cap = G.GAME.interest_cap + card.ability.extra.interest * 3
      return {
          message = localize("poke_leech_seed_ex"),
          card = card,
        }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.0, func = function()
              card.ability.extra.counter = card.ability.extra.money
              G.GAME.interest_cap = G.GAME.interest_cap + card.ability.extra.counter * card.ability.extra.interest
              return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
    G.GAME.interest_cap = G.GAME.interest_cap - card.ability.extra.counter * card.ability.extra.interest
  end,
}

-- Chimchar 390
local chimchar={
  name = "chimchar",
  pos = {x = 3, y = 0},
  config = {extra = {d_size = 1, mult = 0, mult_mod = 0, max_scored = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, math.max(0, self.config.evo_rqmt - card.ability.extra.max_scored)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Fire",
  atlas = "Pokedex4",
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
  pos = {x = 4, y = 0},
  config = {extra = {d_size = 1, mult = 0, mult_mod = 0, max_scored = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, math.max(0, self.config.evo_rqmt - card.ability.extra.max_scored)}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fire",
  atlas = "Pokedex4",
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
  pos = {x = 5, y = 0},
  config = {extra = {d_size = 1, mult = 30, Ymult = 1.0, Xmult_mod = 0.3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, card.ability.extra.Xmult_mod, card.ability.extra.Ymult}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fire",
  atlas = "Pokedex4",
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
  pos = {x = 6, y = 0},
  config = {extra = {hands = 1, chips = 80, chip_loss = 20, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_loss, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Water",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
     if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local chip_total = card.ability.extra.chips - card.ability.extra.chip_loss * (#context.scoring_hand)
        if chip_total < 0 then chip_total = 0 end
        return {
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
  end,
}

-- Prinplup 394
local prinplup={
  name = "prinplup",
  pos = {x = 7, y = 0},
  config = {extra = {hands = 1, chips = 30, chip_mod = 0, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Water",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)    
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if not SMODS.has_no_rank(context.other_card) then
        card.ability.extra.chip_mod = context.other_card.base.nominal
      end
      return {
        h_chips = card.ability.extra.chip_mod,
        card = card,
      }
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
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
  end,
}

-- Empoleon 395
local empoleon={
  name = "empoleon",
  pos = {x = 8, y = 0},
  config = {extra = {hands = 1, chips = 50, chip_mod = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Water",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)    
     if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if not SMODS.has_no_rank(context.other_card) then
        card.ability.extra.chip_mod = context.other_card.base.nominal * 2
      end
      return {
        h_chips = card.ability.extra.chip_mod,
        card = card,
      }
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
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
  end,
}

-- Gallade 475
local gallade={
  name = "gallade",
  pos = {x = 4, y = 6},
  config = {extra = {planets = 0, mult_mod = 2, Xmult_mod = 0.1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.planets, card.ability.extra.mult_mod, card.ability.extra.Xmult_mod}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fighting",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Consumable used - Planet
    if context.using_consumeable and context.consumeable and context.consumeable.ability then
      if context.consumeable.ability.set == 'Planet' then
        card.ability.extra.planets = card.ability.extra.planets + 1
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_psycho_cut_ex'), colour = G.C.SECONDARY_SET.Planet, sound = 'slice1', pitch = 0.96+math.random()*0.08})
        -- Third Planet = Levels function
        if card.ability.extra.planets >= 3 then
          if not context.blueprint then
              card.ability.extra.planets = 0
          end
          -- Find most played hand
          local _hand, _tally = nil, 0
          for k, v in ipairs(G.handlist) do
              if G.GAME.hands[v].visible and G.GAME.hands[v].played >= _tally then
                  _hand = v
                  _tally = G.GAME.hands[v].played
              end
          end
          -- Level up most played hand by three
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex')})
          update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(_hand, 'poker_hands'),chips = G.GAME.hands[_hand].chips, mult = G.GAME.hands[_hand].mult, level=G.GAME.hands[_hand].level})
          level_up_hand(context.blueprint_card or card, _hand, nil, 3)
          update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
      end
    end

    -- Main Scoring
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = card.ability.extra.mult_mod * G.GAME.hands[context.scoring_name].played
        local Xmult = 1 + card.ability.extra.Xmult_mod * G.GAME.hands[context.scoring_name].played
        return {
          mult = mult,
          xmult = Xmult,
          card = card
        }
      end
    end
  end,
  megas = {"mega_gallade"},
}

-- Mega-Gallade 475-1
local mega_gallade={
  name = "mega_gallade",
  pos = {x = 2, y = 6},
  soul_pos = { x = 3, y = 6 },
  config = {extra = {mult_mod = 4, Xmult_mod = 0.2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.mult_mod, card.ability.extra.Xmult_mod}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Fighting",
  atlas = "Megas",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)

    -- Un-debuff cards logic *I hate everything, will fix later
    -- if context.cardarea == G.play then
    --   local _hand, _tally = nil, 0
    --   for k, v in ipairs(G.handlist) do
    --       if G.GAME.hands[v].visible and G.GAME.hands[v].played >= _tally then
    --           _hand = v
    --           _tally = G.GAME.hands[v].played
    --       end
    --   end
    --   if context.scoring_name == localize(_hand, 'poker_hands') then
    --     for i in #context.scoring_hand do
    --       if context.scoring_hand[i].debuff then context.scoring_hand[i]:can_calculate(context.ignore_debuff) end
    --     end
    --   end
    -- end

    -- Main Scoring
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = card.ability.extra.mult_mod * G.GAME.hands[context.scoring_name].played
        local Xmult = 1 + card.ability.extra.Xmult_mod * G.GAME.hands[context.scoring_name].played
        return {
          mult = mult,
          xmult = Xmult,
          card = card
        }
      end
    end
  end,
}


list = {turtwig, grotle, torterra, chimchar, monferno, infernape, piplup, prinplup, empoleon, gallade, mega_gallade}
return {name = "nachopokemon4", list = list}

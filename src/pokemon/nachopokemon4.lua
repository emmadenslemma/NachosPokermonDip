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
  config = {extra = {h_size = 1, interest = 5, counter = 0, money = 0, money_mod = 0, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.h_size, card.ability.extra.rounds, G.GAME.interest_cap / 5}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Grass",
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
  config = {extra = {h_size = 1, interest = 5, counter = 0, money = 0, money_mod = 0, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.h_size, card.ability.extra.rounds, G.GAME.interest_cap / 5}}
  end,
  designer = "Eternalnacho, ESN64",
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Grass",
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
  config = {extra = {h_size = 0, interest = 5, counter = 0, money = 0, money_mod = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.h_size, card.ability.extra.mult, G.GAME.interest_cap / 5}}
  end,
  designer = "Eternalnacho, ESN64",
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Grass",
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
  config = {extra = {d_size = 1, mult = 0, max_scored = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, math.max(0, self.config.evo_rqmt - card.ability.extra.max_scored)}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Fire",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.discard and not context.blueprint and not context.other_card.debuff then
      local prev_mult = card.ability.extra.mult

      if card.ability.extra.mult < context.other_card.base.nominal then
        card.ability.extra.mult = context.other_card.base.nominal
      end

      if context.other_card == context.full_hand[#context.full_hand] then
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
          mult = card.ability.extra.mult
        }
      end
    end

    if context.end_of_round and context.game_over == false and not context.blueprint and not context.repetition and not context.individual then
      if card.ability.extra.mult >= 11 then
          card.ability.extra.max_scored = card.ability.extra.max_scored + 1
      end
      card.ability.extra.mult = 0
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
  config = {extra = {d_size = 1, mult = 0, highest_rank = 0, max_scored = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, math.max(0, self.config.evo_rqmt - card.ability.extra.max_scored)}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fire",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.discard and not context.blueprint and not context.other_card.debuff then

      if card.ability.extra.highest_rank < context.other_card.base.nominal then
        card.ability.extra.highest_rank = context.other_card.base.nominal
      end

      if context.other_card == context.full_hand[#context.full_hand] then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.highest_rank
        card.ability.extra.highest_rank = 0
        return {
            message = localize('k_upgrade_ex'),
            colour = G.C.RED
        }
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          mult = card.ability.extra.mult
        }
      end
    end

    if context.end_of_round and context.game_over == false and not context.blueprint and not context.repetition and not context.individual then
      if card.ability.extra.mult >= 30 then
        card.ability.extra.max_scored = card.ability.extra.max_scored + 1
      end
      card.ability.extra.mult = 0
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
  config = {extra = {d_size = 1, mult = 30, Ymult = 1.0, Xmult_mod = 0.3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.d_size, card.ability.extra.mult, card.ability.extra.Xmult_mod, card.ability.extra.Ymult}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fire",
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
  config = {extra = {hands = 1, chips = 80, chip_loss = 20, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_loss, card.ability.extra.rounds}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Water",
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
  config = {extra = {hands = 1, chips = 30, chip_mod = 0, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.rounds}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Water",
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
  config = {extra = {hands = 1, chips = 50, chip_mod = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.rounds}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Water",
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
  config = {extra = {Xmult_mod = 0.15}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult_mod}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fighting",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Consumable used - Planet
    if context.using_consumeable and context.consumeable and context.consumeable.ability then
      if context.consumeable.ability.set == 'Planet' then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_psycho_cut_ex'), colour = G.C.SECONDARY_SET.Planet, sound = 'slice1', pitch = 0.96+math.random()*0.08})
        -- Find most played hand
        local _hand = calc_most_played_hand()
        -- Level up most played hand by three
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex')})
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(_hand, 'poker_hands'),chips = G.GAME.hands[_hand].chips, mult = G.GAME.hands[_hand].mult, level=G.GAME.hands[_hand].level})
        level_up_hand(context.blueprint_card or card, _hand, nil, 1)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
      end
    end

    -- Main Scoring
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Xmult = 1 + card.ability.extra.Xmult_mod * G.GAME.hands[context.scoring_name].played
        return {
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
  config = {extra = {Xmult_mod = 0.3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult_mod}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Fighting",
  gen = 4,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Main Scoring
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Xmult = 1 + card.ability.extra.Xmult_mod * G.GAME.hands[context.scoring_name].played
        return {
          xmult = Xmult,
          card = card
        }
      end
    end
  end,
}


list = {}
if nacho_config.Turtwig then list[#list+1] = turtwig end
if nacho_config.Turtwig then list[#list+1] = grotle end
if nacho_config.Turtwig then list[#list+1] = torterra end

if nacho_config.Chimchar then list[#list+1] = chimchar end
if nacho_config.Chimchar then list[#list+1] = monferno end
if nacho_config.Chimchar then list[#list+1] = infernape end

if nacho_config.Piplup then list[#list+1] = piplup end
if nacho_config.Piplup then list[#list+1] = prinplup end
if nacho_config.Piplup then list[#list+1] = empoleon end

if nacho_config.Ralts then list[#list+1] = gallade end
if nacho_config.Ralts then list[#list+1] = mega_gallade end

return {name = "nachopokemon4", list = list}

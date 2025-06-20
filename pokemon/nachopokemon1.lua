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
  config = {extra = {h_size = 1, odds = 15, money_mod = 1, money_earned = 0}, evo_rqmt = 15},
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
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if (pseudorandom('turtwig') < (G.GAME.probabilities.normal + #context.scoring_hand - 1)/card.ability.extra.odds) and not context.other_card.debuff then
        local earned = ease_poke_dollars(card, "turtwig", card.ability.extra.money_mod, true)
        card.ability.extra.money_earned = card.ability.extra.money_earned + earned
          return {
            dollars = earned,
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
  config = {extra = {h_size = 1, odds = 10, money_mod = 2, money_earned = 0}, evo_rqmt = 30},
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
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if (pseudorandom('grotle') < (G.GAME.probabilities.normal + #context.scoring_hand - 1)/card.ability.extra.odds) and not context.other_card.debuff then
        local earned = ease_poke_dollars(card, "grotle", card.ability.extra.money_mod, true)
        card.ability.extra.money_earned = card.ability.extra.money_earned + earned
          return {
            dollars = earned,
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
  config = {extra = {h_size = 1, mult = 2, odds = 5, money_mod = 3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.h_size, card.ability.extra.mult, card.ability.extra.odds, card.ability.extra.money_mod}}
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
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if (pseudorandom('torterra') < (G.GAME.probabilities.normal + #context.scoring_hand - 1)/card.ability.extra.odds) and not context.other_card.debuff then
        local earned = ease_poke_dollars(card, "torterra", card.ability.extra.money_mod, true)
          return {
            dollars = earned,
            card = card,
          }
      end
    end
    if context.joker_main then
      return { mult = card.ability.extra.mult * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 10) }
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

-- Hisuian Zorua 570-1
local hisuian_zorua = {
  name = "hisuian_zorua", 
  poke_custom_prefix = "nacho",
  pos = { x = 9, y = 4 },
  soul_pos = { x = 9, y = 5 },
  config = {extra = {hidden_key = nil, rounds = 5, active = true}},
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "nacho_regionals",
  blueprint_compat = true,
  rental_compat = false,
  calculate = function(self, card, context)
    local other_joker = G.jokers.cards[1]
    if other_joker and other_joker ~= card and not context.no_blueprint and card.ability.extra.active then
      context.blueprint = (context.blueprint or 0) + 1
      context.blueprint_card = context.blueprint_card or card
      if context.blueprint > #G.jokers.cards + 1 then return end

      local other_joker_ret = Card.calculate_joker(other_joker, context)

      context.blueprint = nil
      local eff_card = context.blueprint_card or card
      context.blueprint_card = nil
      if other_joker_ret then 
        other_joker_ret.card = eff_card
        other_joker_ret.colour = G.C.BLACK
        return other_joker_ret
      end
    end
    if context.after and G.jokers.cards[1] ~= card and card.ability.extra.active then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function() 
          card.ability.extra.active = false
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_reveal_ex')})
      return true end }))
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.active = true
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
    end
    return level_evo(self, card, context, "j_nacho_hisuian_zoroark")
  end,
  set_card_type_badge = function(self, card, badges)
    local card_type = SMODS.Rarity:get_rarity_badge(card.config.center.rarity)
    local card_type_colour = get_type_colour(card.config.center or card.config, card)
    if card.area and card.area ~= G.jokers and not poke_is_in_collection(card) then
      local _o = G.P_CENTERS[card.ability.extra.hidden_key]
      card_type = SMODS.Rarity:get_rarity_badge(_o.rarity)
      card_type_colour = get_type_colour(_o, card)
    end
    badges[#badges + 1] = create_badge(card_type, card_type_colour, nil, 1.2)
  end,
  set_sprites = function(self, card, front)
    if card.ability and card.ability.extra and card.ability.extra.hidden_key then
      self:set_ability(card)
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if not type_sticker_applied(card) then
      apply_type_sticker(card, "Colorless")
    end
    if card.area ~= G.jokers and not poke_is_in_collection(card) and not G.SETTINGS.paused then
      card.ability.extra.hidden_key = card.ability.extra.hidden_key or get_random_poke_key('zorua', nil, 1)
      local _o = G.P_CENTERS[card.ability.extra.hidden_key]
      card.children.center.atlas = G.ASSET_ATLAS[_o.atlas]
      card.children.center:set_sprite_pos(_o.pos)
    else
      card.children.center.atlas = G.ASSET_ATLAS[self.atlas]
      card.children.center:set_sprite_pos(self.pos)
    end
  end,
  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    local _c = card and card.config.center or card
    card.ability.extra.hidden_key = card.ability.extra.hidden_key or get_random_poke_key('zorua', nil, 1)
    local _o = G.P_CENTERS[card.ability.extra.hidden_key]
    if card.area ~= G.jokers and not poke_is_in_collection(card) then
      local temp_ability = card.ability
      card.ability = _o.config
      _o:generate_ui(info_queue, card, desc_nodes, specific_vars, full_UI_table)
      if not full_UI_table.name then
        full_UI_table.name = localize({ type = "name", set = _o.set, key = _o.key, nodes = full_UI_table.name })
      end
      card.ability = temp_ability
      if full_UI_table.name[1].nodes[1] then
        local textDyna = full_UI_table.name[1].nodes[1].nodes[1].config.object
        textDyna.string = textDyna.string .. localize("poke_illusion")
        textDyna.config.string = {textDyna.string}
        textDyna.strings = {}
        textDyna:update_text(true)
      end
      card.children.center.atlas = G.ASSET_ATLAS[_o.atlas]
      card.children.center:set_sprite_pos(_o.pos)
      local poketype_list = {Grass = true, Fire = true, Water = true, Lightning = true, Psychic = true, Fighting = true, Colorless = true, Dark = true, Metal = true, Fairy = true, Dragon = true, Earth = true}
      for i = #info_queue, 1, -1 do
        if info_queue[i].set == "Other" and info_queue[i].key and poketype_list[info_queue[i].key] then
          table.remove(info_queue, i)
        end
      end
    else
      if not full_UI_table.name then
        full_UI_table.name = localize({ type = "name", set = _c.set, key = _c.key, nodes = full_UI_table.name })
      end
      card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ''
      card.ability.blueprint_compat_check = nil
      local main_end = (card.area and card.area == G.jokers) and {
        {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
          {n=G.UIT.C, config={ref_table = card, align = "m", colour = G.C.JOKER_GREY, r = 0.05, padding = 0.06, func = 'blueprint_compat'}, nodes={
            {n=G.UIT.T, config={ref_table = card.ability, ref_value = 'blueprint_compat_ui',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
          }}
        }}
      } or nil
      localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes, vars = {card.ability.extra.rounds, colours = {not card.ability.extra.active and G.C.UI.TEXT_INACTIVE}}}
      desc_nodes[#desc_nodes+1] = main_end
    end
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN and card.area == G.jokers  then
      local other_joker = G.jokers.cards[1]
      card.ability.blueprint_compat = ( other_joker and other_joker ~= card and not other_joker.debuff and other_joker.config.center.blueprint_compat and 'compatible') or 'incompatible'
      if card.ability.blueprint_compat == 'compatible' and not card.debuff and card.ability.extra.active then
        card.children.center.atlas = other_joker.children.center.atlas
        card.children.center:set_sprite_pos(other_joker.children.center.sprite_pos)
        if other_joker.children.floating_sprite then
          card.children.floating_sprite.atlas = other_joker.children.floating_sprite.atlas
          card.children.floating_sprite:set_sprite_pos(other_joker.children.floating_sprite.sprite_pos)
        else
          card.children.floating_sprite.atlas = G.ASSET_ATLAS[self.atlas]
          card.children.floating_sprite:set_sprite_pos(self.soul_pos)
        end
      else
        card.children.center.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "nacho_shiny_regionals" or "nacho_regionals"]
        card.children.center:set_sprite_pos(self.pos)
        card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "nacho_shiny_regionals" or "nacho_regionals"]
        card.children.floating_sprite:set_sprite_pos(self.soul_pos)
      end
    elseif poke_is_in_collection(card) and card.children.center.sprite_pos ~= self.pos and card.children.center.atlas.name ~= self.atlas then
      self:set_ability(card)
    end
  end,
}

-- Zoroark 571-1
local hisuian_zoroark = {
  name = "hisuian_zoroark", 
  poke_custom_prefix = "nacho",
  pos = { x = 10, y = 4 },
  soul_pos = { x = 10, y = 5 },
  config = {extra = {hidden_key = nil}},
  rarity = "poke_safari",
  cost = 12,
  stage = "One",
  ptype = "Colorless",
  atlas = "nacho_regionals",
  blueprint_compat = true,
  calculate = function(self, card, context)
    local other_joker = G.jokers.cards[1]
    if other_joker and other_joker ~= card and not context.no_blueprint then
      context.blueprint = (context.blueprint or 0) + 1
      context.blueprint_card = context.blueprint_card or card
      if context.blueprint > #G.jokers.cards + 1 then return end

      local other_joker_ret = Card.calculate_joker(other_joker, context)

      context.blueprint = nil
      local eff_card = context.blueprint_card or card
      context.blueprint_card = nil
      if other_joker_ret then 
        other_joker_ret.card = eff_card
        other_joker_ret.colour = G.C.BLACK
        return other_joker_ret
      end
    end
  end,
  set_card_type_badge = function(self, card, badges)
    local card_type = SMODS.Rarity:get_rarity_badge(card.config.center.rarity)
    local card_type_colour = get_type_colour(card.config.center or card.config, card)
    if card.area ~= G.jokers and not poke_is_in_collection(card) then
      local _o = G.P_CENTERS[card.ability.extra.hidden_key]
      card_type = SMODS.Rarity:get_rarity_badge(_o.rarity)
      card_type_colour = get_type_colour(_o, card)
    end
    badges[#badges + 1] = create_badge(card_type, card_type_colour, nil, 1.2)
  end,
  set_sprites = function(self, card, front)
    if card.ability and card.ability.extra and card.ability.extra.hidden_key then
      self:set_ability(card)
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if not type_sticker_applied(card) then
      apply_type_sticker(card, "Colorless")
    end
    if card.area ~= G.jokers and not poke_is_in_collection(card) and not G.SETTINGS.paused then
      card.ability.extra.hidden_key = card.ability.extra.hidden_key or get_random_poke_key('zoroark', nil, 'poke_safari', nil, nil, {j_poke_zoroark = true})
      local _o = G.P_CENTERS[card.ability.extra.hidden_key]
      card.children.center.atlas = G.ASSET_ATLAS[_o.atlas]
      card.children.center:set_sprite_pos(_o.pos)
    else
      card.children.center.atlas = G.ASSET_ATLAS[self.atlas]
      card.children.center:set_sprite_pos(self.pos)
    end
  end,
  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    local _c = card and card.config.center or card
    card.ability.extra.hidden_key = card.ability.extra.hidden_key or get_random_poke_key('zoroark', nil, 'poke_safari', nil, nil, {j_poke_zoroark = true})
    local _o = G.P_CENTERS[card.ability.extra.hidden_key]
    if card.area ~= G.jokers and not poke_is_in_collection(card) then
      local temp_ability = card.ability
      card.ability = _o.config
      _o:generate_ui(info_queue, card, desc_nodes, specific_vars, full_UI_table)
      card.ability = temp_ability
      if full_UI_table.name then
        local textDyna = full_UI_table.name[1].nodes[1].config.object
        textDyna.string = textDyna.string .. localize("poke_illusion")
        textDyna.config.string = {textDyna.string}
        textDyna.strings = {}
        textDyna:update_text(true)
      end
      card.children.center.atlas = G.ASSET_ATLAS[_o.atlas]
      card.children.center:set_sprite_pos(_o.pos)
      local poketype_list = {Grass = true, Fire = true, Water = true, Lightning = true, Psychic = true, Fighting = true, Colorless = true, Dark = true, Metal = true, Fairy = true, Dragon = true, Earth = true}
      for i = #info_queue, 1, -1 do
        if info_queue[i].set == "Other" and info_queue[i].key and poketype_list[info_queue[i].key] then
          table.remove(info_queue, i)
        end
      end
    else
      if not full_UI_table.name then
        full_UI_table.name = localize({ type = "name", set = _c.set, key = _c.key, nodes = full_UI_table.name })
      end
      card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ''
      card.ability.blueprint_compat_check = nil
      local main_end = (card.area and card.area == G.jokers) and {
        {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
          {n=G.UIT.C, config={ref_table = card, align = "m", colour = G.C.JOKER_GREY, r = 0.05, padding = 0.06, func = 'blueprint_compat'}, nodes={
            {n=G.UIT.T, config={ref_table = card.ability, ref_value = 'blueprint_compat_ui',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
          }}
        }}
      } or nil
      localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes, vars = {}}
      desc_nodes[#desc_nodes+1] = main_end
    end
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN and card.area == G.jokers then
      local other_joker = G.jokers.cards[1]
      card.ability.blueprint_compat = ( other_joker and other_joker ~= card and not other_joker.debuff and other_joker.config.center.blueprint_compat and 'compatible') or 'incompatible'
      if card.ability.blueprint_compat == 'compatible' and not card.debuff then
        card.children.center.atlas = other_joker.children.center.atlas
        card.children.center:set_sprite_pos(other_joker.children.center.sprite_pos)
        if other_joker.children.floating_sprite then
          card.children.floating_sprite.atlas = other_joker.children.floating_sprite.atlas
          card.children.floating_sprite:set_sprite_pos(other_joker.children.floating_sprite.sprite_pos)
        else
          card.children.floating_sprite.atlas = G.ASSET_ATLAS[self.atlas]
          card.children.floating_sprite:set_sprite_pos(self.soul_pos)
        end
      else
        card.children.center.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "nacho_shiny_regionals" or "nacho_regionals"]
        card.children.center:set_sprite_pos(self.pos)
        card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "nacho_shiny_regionals" or "nacho_regionals"]
        card.children.floating_sprite:set_sprite_pos(self.soul_pos)
      end
    elseif poke_is_in_collection(card) and card.children.center.sprite_pos ~= self.pos and card.children.center.atlas.name ~= self.atlas then
      self:set_ability(card)
    end
  end,
}

list = {turtwig, grotle, torterra, chimchar, monferno, infernape, piplup, prinplup, empoleon, hisuian_zorua, hisuian_zoroark}

return {name = "nachopokemon1",
list = list
}
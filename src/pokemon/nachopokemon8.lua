function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Skwovet 819
local skwovet={
  name = "skwovet",
  config = {extra = {mult = 0, mult_mod = 1, rounds = 5, in_blind = false}, evo_rqmt = 12},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod}}
  end,
  designer = "Eternalnacho",
  rarity = 1,
  cost = 5,
  stage = "Basic",
  ptype = "Colorless",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Check if blind starts
    if context.setting_blind and not context.blueprint then
      card.ability.extra.in_blind = true
      return
    end

    -- Consumable Used
    if context.using_consumeable and card.ability.extra.in_blind and not context.blueprint then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
      return {
          message = localize('k_upgrade_ex'),
          colour = G.C.RED
        }
    end

    -- Main Scoring
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          mult = card.ability.extra.mult
        }
      end
    end

    -- reset "in blind" check
    if context.end_of_round and not context.game_over == true and context.main_eval and not context.blueprint then
      card.ability.extra.in_blind = false
    end
    return scaling_evo(self, card, context, "j_nacho_greedent", card.ability.extra.mult, self.config.evo_rqmt)
  end,
}

-- Greedent 820
local greedent={
  name = "greedent",
  config = {extra = {mult = 0, mult_mod = 2, num = 1, den = 4, in_blind = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, 'greedent')
    return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod, num, den}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 10,
  stage = "One",
  ptype = "Colorless",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Check if blind starts
    if context.setting_blind and not context.blueprint then
      card.ability.extra.in_blind = true
      return{}
    end

    -- Consumable used
    if context.using_consumeable and card.ability.extra.in_blind then
      if not context.blueprint then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
      end
      -- 1 in 4 chance for Leftovers
      if SMODS.pseudorandom_probability(card, 'greedent', card.ability.extra.num, card.ability.extra.den, 'greedent') and not card.debuff and
          context.consumeable.config.center.key ~= 'c_poke_leftovers' then
        local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_poke_leftovers')
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_stuff_cheeks_ex'), colour = G.C.FILTER})
      end
      return {
          message = localize('k_upgrade_ex'),
          colour = G.C.RED
        }
    end

    -- Main Scoring
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult = card.ability.extra.mult
        }
      end
    end

    -- reset "in blind" check
    if context.end_of_round and not context.game_over == true and context.main_eval and not context.blueprint then
      card.ability.extra.in_blind = false
    end
  end,
}

-- Meowth 52-2
local galarian_meowth={
  name = "galarian_meowth",
  config = {extra = {metals = 0, retriggers = 1, counter = 0}, evo_rqmt = 2},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		return {vars = {card.ability.extra.retriggers}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 6,
  enhancement_gate = 'm_steel',
  stage = "Basic",
  ptype = "Metal",
  gen = 1,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
      card.ability.extra.counter = 0
      return{}
    end
    if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) 
    and SMODS.has_enhancement(context.other_card, "m_steel") and card.ability.extra.counter < 2 then
      if not context.blueprint and not context.retrigger_joker then
        card.ability.extra.counter = card.ability.extra.counter + 1
      end
      return {
        message = localize('k_again_ex'),
        repetitions = card.ability.extra.retriggers,
        card = card
      }
    end

    return scaling_evo(self, card, context, "j_nacho_perrserker", card.ability.extra.metals, self.config.evo_rqmt)
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN and card.area == G.jokers then
      local metals = 0
      local adjacent_jokers = poke_get_adjacent_jokers(card)
      for i = 1, #adjacent_jokers do
        if is_type(adjacent_jokers[i], "Metal") then metals = metals + 1 end
      end
      card.ability.extra.metals = metals
      return {}
    end
  end,
}

-- Perrserker 863
local perrserker = {
  name = "perrserker",
  config = { extra = {Ymult = 1.5, retriggers = 1, counter = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    return { vars = {card.ability.extra.Ymult} }
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 10,
  stage = "One",
  ptype = "Metal",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
      card.ability.extra.counter = 0
      return{}
    end

    if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) 
    and SMODS.has_enhancement(context.other_card, "m_steel") then
      if not context.blueprint and not context.retrigger_joker then
        card.ability.extra.counter = card.ability.extra.counter + 1
      end
      if card.ability.extra.counter > 3 then return end
      return {
        message = localize('k_again_ex'),
        repetitions = card.ability.extra.retriggers,
        card = card
      }
    end

    if context.other_joker and is_type(context.other_joker, "Metal") then
      G.E_MANAGER:add_event(Event({
        func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
        end
      })) 
      return {
        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Ymult}}, 
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Ymult,
        message_card = context.other_joker,
      }
    end

    if context.retrigger_joker_check and not context.retrigger_joker then
      local metals = 0
      for k, v in pairs(G.jokers.cards) do
          if is_type(v, "Metal") then metals = metals + 1 end
      end
      if metals == #G.jokers.cards and (context.other_card.ability and context.other_card == card) then
        return {
          message = localize("k_again_ex"),
          colour = G.C.BLACK,
          repetitions = 1,
          card = card,
        }
      end
		end
  end,
}

-- Hisuian Zorua 570-1
local hisuian_zorua = {
  name = "hisuian_zorua",
  pos = { x = 0, y = 9 },
  soul_pos = { x = 99, y = 99 },
  config = {extra = {hidden_key = nil, rounds = 5, active = true}},
  designer = "ESN64",
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Colorless",
  gen = 5,
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
    if not type_sticker_applied(card) and not poke_is_in_collection(card) and not G.SETTINGS.paused then
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
      if card.ability.blueprint_compat == 'compatible' and not card.debuff and card.ability.extra.active and other_joker.children.center.atlas.px == 71 then
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
        card.children.center.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_AtlasJokersBasicGen05Shiny" or "poke_AtlasJokersBasicGen05"]
        card.children.center:set_sprite_pos(self.pos)
        card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_AtlasJokersBasicGen05Shiny" or "poke_AtlasJokersBasicGen05"]
        card.children.floating_sprite:set_sprite_pos(self.soul_pos)
      end
    elseif poke_is_in_collection(card) and card.children.center.sprite_pos ~= self.pos and card.children.center.atlas.name ~= self.atlas then
      self:set_ability(card)
    end
  end,
}

-- Hisuian Zoroark 571-1
local hisuian_zoroark = {
  name = "hisuian_zoroark",
  pos = { x = 2, y = 9 },
  soul_pos = { x = 99, y = 99 },
  config = {extra = {hidden_key = nil}},
  designer = "ESN64",
  rarity = "poke_safari",
  cost = 12,
  stage = "One",
  ptype = "Colorless",
  gen = 5,
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
    if not type_sticker_applied(card) and not poke_is_in_collection(card) and not G.SETTINGS.paused then
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
      localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes, vars = {}}
      desc_nodes[#desc_nodes+1] = main_end
    end
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN and card.area == G.jokers then
      local other_joker = G.jokers.cards[1]
      card.ability.blueprint_compat = ( other_joker and other_joker ~= card and not other_joker.debuff and other_joker.config.center.blueprint_compat and 'compatible') or 'incompatible'
      if card.ability.blueprint_compat == 'compatible' and not card.debuff and other_joker.children.center.atlas.px == 71 then
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
        card.children.center.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_AtlasJokersBasicGen05Shiny" or "poke_AtlasJokersBasicGen05"]
        card.children.center:set_sprite_pos(self.pos)
        card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_AtlasJokersBasicGen05Shiny" or "poke_AtlasJokersBasicGen05"]
        card.children.floating_sprite:set_sprite_pos(self.soul_pos)
      end
    elseif poke_is_in_collection(card) and card.children.center.sprite_pos ~= self.pos and card.children.center.atlas.name ~= self.atlas then
      self:set_ability(card)
    end
  end,
}

-- Hisuian Sliggoo 705-1
local hisuian_sliggoo={
  name = "hisuian_sliggoo",
  config = {extra = {flush_houses = 0}, evo_rqmt = 6},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {math.max(0, self.config.evo_rqmt - card.ability.extra.flush_houses),
      self.config.evo_rqmt - card.ability.extra.flush_houses == 1 and "Flush House" or "Flush Houses"}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Metal",
  gen = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- Count # of Flush Houses played
    if context.before and context.main_eval and context.scoring_name == 'Flush House' then
      card.ability.extra.flush_houses = card.ability.extra.flush_houses + 1
      return
    end
    -- Main function
    if context.joker_main and context.scoring_name == 'Flush House' then
      -- Get first rank id + rank, compare id to second rank id, get second rank
      local first_rank_id = nil
      local first_rank = nil
      local second_rank = nil
      for _, scoring_card in pairs(context.scoring_hand) do
          if not first_rank and scoring_card:get_id() > 0 then
            first_rank_id = scoring_card:get_id()
            first_rank = scoring_card.base.nominal
          elseif not second_rank and scoring_card:get_id() > 0 and scoring_card:get_id() ~= first_rank_id then
              second_rank = scoring_card.base.nominal
          end
      end
      -- Create metal coat
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_poke_metalcoat')
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
      end
      -- Create second metal coat if the difference in scoring ranks is > 6
      if math.abs(second_rank - first_rank) > 6 then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_poke_metalcoat')
          _card:add_to_deck()
          G.consumeables:emplace(_card)
          card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
        end
      end
    end
    return scaling_evo(self, card, context, "j_nacho_hisuian_goodra", card.ability.extra.flush_houses, self.config.evo_rqmt)
  end,
}

-- Hisuian Goodra 706-1
local hisuian_goodra={
  name = "hisuian_goodra",
  config = {extra = {Xmult = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 11,
  stage = "Two",
  ptype = "Metal",
  gen = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- Create a Metal Coat if Flush House played
    if context.before and context.main_eval and context.scoring_name == 'Flush House' then
      -- Create metal coat
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_poke_metalcoat')
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
      end
    end
    if context.individual and context.cardarea == G.hand and not context.end_of_round then
      if context.scoring_name == 'Flush House' then
        -- Get first and second ranks of flush house
        local first_rank_id = nil
        local first_rank = nil
        local second_rank = nil
        for _, scoring_card in pairs(context.scoring_hand) do
            if not first_rank and scoring_card:get_id() > 0 then
              first_rank_id = scoring_card:get_id()
              first_rank = scoring_card.base.nominal
            elseif not second_rank and scoring_card:get_id() > 0 and scoring_card:get_id() ~= first_rank_id then
                second_rank = scoring_card.base.nominal
            end
        end
        -- Set Xmult_mod
        card.ability.extra.Xmult = math.abs(second_rank - first_rank) / 3
        -- Score Steel cards in hand
        if SMODS.has_enhancement(context.other_card, 'm_steel') and card.ability.extra.Xmult > 1 then
          return{
            xmult = card.ability.extra.Xmult,
            card = card,
          }
        end
      end
    end
  end,
}


list = {}
if nacho_config.Skwovet then list[#list+1] = skwovet end
if nacho_config.Skwovet then list[#list+1] = greedent end

if nacho_config.Galarian_Meowth then list[#list+1] = galarian_meowth end
if nacho_config.Galarian_Meowth then list[#list+1] = perrserker end

if nacho_config.Hisuian_Zorua then list[#list+1] = hisuian_zorua end
if nacho_config.Hisuian_Zorua then list[#list+1] = hisuian_zoroark end

if nacho_config.Goomy then list[#list+1] = hisuian_sliggoo end
if nacho_config.Goomy then list[#list+1] = hisuian_goodra end

return {name = "nachopokemon8", list = list}

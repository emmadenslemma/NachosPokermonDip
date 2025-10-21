function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end


-- Oranguru 765
local oranguru={
  name = "oranguru",
  config = {extra = {raised = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    common_ranks_tooltip(self, info_queue)
    return {vars = {}}
  end,
  designer = "Eternalnacho",
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Colorless",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.open_booster and not context.blueprint then
      if context.card.ability.name:find('Standard') then
        -- set booster_choice_mod if not raised
        if not card.ability.extra.raised then
          if G.GAME.modifiers.booster_choice_mod then G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod + 1
          else G.GAME.modifiers.booster_choice_mod = 1 end
          -- set booster choices
          G.GAME.pack_choices =
            math.min((context.card.ability.choose or context.card.config.center.config.choose or 1) + (G.GAME.modifiers.booster_choice_mod or 0),
            context.card.ability.extra and math.max(1, context.card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) or
            context.card.config.center.extra and math.max(1, context.card.config.center.extra + (G.GAME.modifiers.booster_size_mod or 0)) or 1)
          -- set raised to true
          card.ability.extra.raised = true
        end
      elseif card.ability.extra.raised then
        -- lower booster_choice_mod if raised, else do nothing
        if G.GAME.modifiers.booster_choice_mod then G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod - 1
        else G.GAME.modifiers.booster_choice_mod = 0 end
        G.GAME.pack_choices =
            math.min((context.card.ability.choose or context.card.config.center.config.choose or 1) + (G.GAME.modifiers.booster_choice_mod or 0),
            context.card.ability.extra and math.max(1, context.card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) or
            context.card.config.center.extra and math.max(1, context.card.config.center.extra + (G.GAME.modifiers.booster_size_mod or 0)) or 1)
        card.ability.extra.raised = false
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if (G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER.ability.name:find('Standard') or G.STATE == G.STATES.STANDARD_PACK) then
      if not card.ability.extra.raised then
        if G.GAME.modifiers.booster_choice_mod then
          G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod + 1
        else
          G.GAME.modifiers.booster_choice_mod = 1
        end
        G.GAME.pack_choices =
            math.min((context.card.ability.choose or context.card.config.center.config.choose or 1) + (G.GAME.modifiers.booster_choice_mod or 0),
            context.card.ability.extra and math.max(1, context.card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) or
            context.card.config.center.extra and math.max(1, context.card.config.center.extra + (G.GAME.modifiers.booster_size_mod or 0)) or 1)
        card.ability.extra.raised = true
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if card.ability.extra.raised then
      if G.GAME.modifiers.booster_choice_mod then
        G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod - 1
      else
        G.GAME.modifiers.booster_choice_mod = 0
      end
      if (G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER.ability.name:find('Standard') or G.STATE == G.STATES.STANDARD_PACK) then
        G.GAME.pack_choices =
            math.min((context.card.ability.choose or context.card.config.center.config.choose or 1) + (G.GAME.modifiers.booster_choice_mod or 0),
            context.card.ability.extra and math.max(1, context.card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) or
            context.card.config.center.extra and math.max(1, context.card.config.center.extra + (G.GAME.modifiers.booster_size_mod or 0)) or 1)
      end
      card.ability.extra.raised = false
    end
  end,
}

-- Passimian 766
local passimian={
  name = "passimian",
  config = {extra = {to_key = nil, kept_vals = {}}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {}}
  end,
  designer = "Eternalnacho",
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Fighting",
  perishable_compat = false,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if not card.ability.received_card then
      if context.selling_card and not context.selling_self and context.cardarea == G.jokers and not context.blueprint
          and not table.contains(self.banlist, context.card.config.center.key) then
        card.ability.extra.to_key = context.card.config.center.key
        self:receive_card(card, context)
      end
      if context.joker_type_destroyed and context.cardarea == G.jokers and not context.blueprint
          and not table.contains(self.banlist, context.card.config.center.key) then
        card.ability.extra.to_key = context.card.config.center.key
        self:receive_card(card, context)
      end
    else
      local ret = card.ability.received_card:calculate(card, context)
      return ret
    end
  end,
  receive_card = function(self, card, context)
    if card.ability.extra.to_key and card.area == G.jokers then
      local _r = G.P_CENTERS[card.ability.extra.to_key]

      -- Keep relevant values stored
      local values_to_keep = {}
      if card.ability.received_card then
        values_to_keep = copy_scaled_values(card)
      elseif context.card and context.card.ability then
        for k, v in pairs(context.card.ability) do
          if type(v) == 'table' then
            values_to_keep[k] = copy_table(v)
          else
            values_to_keep[k] = v
          end
        end
      end

      -- Set ability to received card's
      for k, v in pairs(_r.config) do
        if type(v) == 'table' then
            card.ability[k] = copy_table(v)
        else
            card.ability[k] = v
        end
      end
      card.ability.received_card = _r

      -- Re-add kept values
      if values_to_keep ~= {} then
        for k, v in pairs(values_to_keep) do
          if type(v) == 'table' then
              card.ability[k] = copy_table(v)
          else
              card.ability[k] = v
          end
        end
      end

      if type(card.ability.extra) == "table" and values_to_keep ~= {} then
        for k, v in pairs(values_to_keep) do
          if card.ability.extra[k] or k == "energy_count" or k == "c_energy_count" then
            if type(card.ability.extra[k]) ~= "number" or (type(v) == "number" and v > card.ability.extra[k]) then
              card.ability.extra[k] = v
            end
          end
        end
        if card.ability.extra.energy_count or card.ability.extra.c_energy_count then
          energize(card, nil, true, true)
        end
      end

      if _r.blueprint_compat == true then card.config.center.blueprint_compat = true
      else card.config.center.blueprint_compat = false end

      -- play the funny noises
      if not (card.edition or context.card.edition) then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_receiver_ex')})
      elseif context.card.edition then
        card:juice_up(1, 0.5)
        if context.card.edition.foil then card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'foil2', percent = 1.2, volume = 0.4}) end
        if context.card.edition.holo then card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'holo1', percent = 1.2*1.58, volume = 0.4}) end
        if context.card.edition.polychrome then card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'polychrome1', percent = 1.2, volume = 0.7}) end
        if context.card.edition.poke_shiny then
          card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'e_poke_shiny', percent = 1, volume = 0.2})
        end
        card.ability.received_edition = true
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
      else
        card:juice_up(1, 0.5)
        if card.edition.foil then card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'foil1', percent = 1.2, volume = 0.4}) end
        if card.edition.holo then card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'holo1', percent = 1.2*1.58, volume = 0.4}) end
        if card.edition.polychrome then card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'polychrome1', percent = 1.2, volume = 0.7}) end
        if card.edition.negative then card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'negative', percent = 1.5, volume = 0.4}) end
        if card.edition.poke_shiny then
          card_eval_status_text(card, 'extra', nil, nil, nil,
            {message = localize('poke_receiver_ex'), colour = G.C.DARK_EDITION, sound = 'e_poke_shiny', percent = 1, volume = 0.2})
        end
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if card.ability.received_edition and not from_debuff then
      G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end
  end,
  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    type_tooltip(self, info_queue, card)
    local _c = card and card.config.center or card
    if card and card.ability and card.ability.received_card then
      local r_center = card.ability.received_card
      local r_config = copy_table(card.ability.received_card.config)
      if type(r_center.loc_vars) == "function" then
        local other_queue = {}
        local other_vars = r_center:loc_vars(other_queue, card)
        if other_vars and other_vars.vars then
          r_config.loc_vars_replacement = other_vars.vars
        end
      end
      if not full_UI_table.name then
        full_UI_table.name = localize({ type = "name", set = _c.set, key = _c.key, nodes = full_UI_table.name })
      end
      local r_name = localize({type = "name_text", set = r_center.set, key = r_center.key})
      localize{type = 'descriptions', set = 'Joker', key = r_center.key, name = r_center.name, vars = r_config.loc_vars_replacement, nodes = desc_nodes}
      info_queue[#info_queue + 1] = {set = 'Other', key = 'received_card', vars = {r_name}}
    else
      if not full_UI_table.name then
        full_UI_table.name = localize({ type = "name", set = _c.set, key = _c.key, nodes = full_UI_table.name })
      end
      localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes}
    end
  end,
  banlist = {'j_nacho_passimian', 'j_poke_zorua', 'j_poke_zoroark', 'j_nacho_hisuian_zorua', 'j_nacho_hisuian_zoroark'}
}

-- Turtonator 776
local turtonator={
  name = "turtonator",
  config = {extra = {Xmult_mod = 1.5, trapped = false, set_off = false, boss_trigger = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local active = nil
    if card.ability.extra.trapped then active = "Active!"
    else active = "Inactive" end
    return {vars = {card.ability.extra.Xmult_mod, active}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 8,
  stage = "Basic",
  ptype = "Dragon",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Calculate boss trigger
    if calc_boss_trigger(context) and not card.ability.extra.trapped then
      card.ability.extra.trapped = true
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_shell_trap_ex')})
    end

    -- Scoring Bit Here
    if context.before and context.main_eval and card.ability.extra.trapped then
      return{
        message = localize('poke_shell_trap_ex'),
        colour = G.C.XMULT,
        card = card,
      }
    end
    if context.individual and context.cardarea == G.play and context.scoring_hand then 
      if card.ability.extra.trapped then
        card.ability.extra.set_off = true
        return{
          xmult = card.ability.extra.Xmult_mod,
          colour = G.C.XMULT,
        }
      end
    end

    -- Shell Trap on/off switch
    if (context.joker_main or context.debuffed_hand) and card.ability.extra.trapped and card.ability.extra.set_off then
      card.ability.extra.trapped = false
      card.ability.extra.set_off = false
    end
  end,
}

list = {}
if nacho_config.Oranguru then list[#list+1] = oranguru end
if nacho_config.Passimian then list[#list+1] = passimian end
if nacho_config.Turtonator then list[#list+1] = turtonator end

return {name = "nachopokemon7", list = list}

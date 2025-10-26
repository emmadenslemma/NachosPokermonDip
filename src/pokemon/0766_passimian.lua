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
        self:receive_card(card, context.card.config.center.key, context)
      end
      if context.joker_type_destroyed and context.cardarea == G.jokers and not context.blueprint
          and not table.contains(self.banlist, context.card.config.center.key) then
        self:receive_card(card, context.card.config.center.key, context)
      end
    elseif card.ability.received_card.calculate then
      local ret = card.ability.received_card:calculate(card, context)
      return ret
    end
  end,
  receive_card = function(self, card, to_key, context)
    if to_key and card.area == G.jokers then
      local _r = G.P_CENTERS[to_key]
      -- Keep relevant values stored
      local values_to_keep = {}
      if card.ability.received_card then
        values_to_keep = copy_scaled_values(card)
      elseif context and context.card and context.card.ability then
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

      if _r.add_to_deck then _r:add_to_deck(card) end

      -- play the funny noises
      if not (card.edition or context and context.card and context.card.edition) then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_receiver_ex')})
      elseif context.card and context.card.edition then
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
    if card.ability.received_card and card.ability.received_card.remove_from_deck then
      card.ability.received_card:remove_from_deck(card)
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
  banlist = {'j_nacho_passimian', 'j_poke_zorua', 'j_poke_zoroark', 'j_nacho_hisuian_zorua', 'j_nacho_hisuian_zoroark', 'j_poke_smeargle'},
  load = function(self, card, card_table, other_card)
    if card_table.ability.received_card then
      card_table.ability.received_card = G.P_CENTERS[card_table.received_key]
    end
  end,
}

local init = function()
  remove = function(self, card, context, check_shiny, skip_joker_type_destroyed)
    if not skip_joker_type_destroyed then
      card.getting_sliced = true
      local flags = SMODS.calculate_context({ joker_type_destroyed = true, card = card })
      if flags.no_destroy then
        card.getting_sliced = nil
        return
      end
    end
    if check_shiny and card.edition and card.edition.poke_shiny then
      SMODS.change_booster_limit(-1)
    end
    play_sound('tarot1')
    card.T.r = -0.2
    card:juice_up(0.3, 0.4)
    card.states.drag.is = true
    card.children.center.pinch.x = true
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.3,
      blockable = false,
      func = function()
        G.jokers:remove_card(card)
        card:remove()
        card = nil
        return true
      end
    }))
    card.gone = true
    return true
  end

  local save_card = Card.save
  Card.save = function (self)
    local saved_table = save_card(self)
    if self.config.center_key == 'j_nacho_passimian' and self.area == G.jokers and self.ability.received_card then
      saved_table.received_key = self.ability.received_card.key
    end
    return saved_table
  end
end

return {
  name = "Nacho's Passimian",
  enabled = nacho_config.Passimian or false,
  init = init,
  list = { passimian }
}

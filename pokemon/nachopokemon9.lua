function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end


-- Terapagos 1024
local terapagos={
  name = "terapagos",
  pos = {x = 11, y = 10},
  soul_pos = {x = 12, y = 10},
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    info_queue[#info_queue+1] = {set = 'Other', key = 'energize'}
    return {vars = {}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Colorless",
  atlas = "Pokedex9",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable and context.consumeable.ability then
      if context.consumeable.ability.name == 'teraorb' then
        apply_type_sticker(card, "Colorless")
        if G.jokers.highlighted[1] == card and #G.jokers.highlighted == 1 then
          poke_evolve(card, 'j_nacho_terapagos_terastal')
        elseif G.jokers.cards[1] == card and #G.jokers.highlighted == 0 then
          poke_evolve(card, 'j_nacho_terapagos_terastal')
        end
      end
    end
    if context.end_of_round and not context.individual and context.main_eval and not from_debuff then
      local _card = create_card("Item", G.consumeables, nil, nil, nil, nil, "c_poke_teraorb")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.ARGS.LOC_COLOURS.item})
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      local _card = create_card("Item", G.consumeables, nil, nil, nil, nil, "c_poke_teraorb")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.ARGS.LOC_COLOURS.item})
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Terapagos-Terastal 1024-1
local terapagos_terastal={
  name = "terapagos_terastal",
  pos = {x = 11, y = 10},
  soul_pos = {x = 13, y = 10},
  config = {extra = {Xmult_multi = 0.1, Xmult = 1, energy_total = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    info_queue[#info_queue+1] = {set = 'Other', key = 'energize'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'typechangerother', vars = {"Random Type", colours = {G.ARGS.LOC_COLOURS.pink}}}
    return {vars = {card.ability.extra.Xmult_multi, card.ability.extra.Xmult}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Colorless",
  atlas = "Pokedex9",
  blueprint_compat = true,
  custom_pool_func = true,
  aux_poke = true,
  in_pool = function(self)
    return false
  end,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable and context.consumeable.ability then
      if context.consumeable.ability.name == 'teraorb' then
        if (G.jokers.highlighted[1] == card and #G.jokers.highlighted == 1) or (G.jokers.cards[1] == card and #G.jokers.highlighted == 0) then
          for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card then
              apply_type_sticker(G.jokers.cards[i])
              energy_increase(G.jokers.cards[i], type_sticker_applied(G.jokers.cards[i]))
            end
          end
          apply_type_sticker(card, "Colorless")
          if get_total_energy(card) >= 6 then
            poke_evolve(card, 'j_nacho_terapagos_stellar')
          end
        end
      end
    end
    if context.joker_main then
      return{
        xmult = 1 + card.ability.extra.Xmult_multi * card.ability.extra.energy_total
      }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      if not G.GAME.energy_plus then
        G.GAME.energy_plus = 3
      else
        G.GAME.energy_plus = G.GAME.energy_plus + 3
      end
      for i = 1, #G.jokers.cards do
        energy_increase(G.jokers.cards[i], G.jokers.cards[i].ability.extra.ptype)
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not G.GAME.energy_plus then
      G.GAME.energy_plus = 0
    else
      G.GAME.energy_plus = G.GAME.energy_plus - 3
    end
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN and card.area == G.jokers then
      local energy_total = 0
      for i = 1, #G.jokers.cards do
        energy_total = energy_total + get_total_energy(G.jokers.cards[i])
      end
      card.ability.extra.energy_total = energy_total
      card.ability.extra.Xmult = 1 + card.ability.extra.Xmult_multi * card.ability.extra.energy_total
      return {}
    end
  end,
}


-- Terapagos-Stellar 1024-2
local terapagos_stellar={
  name = "terapagos_stellar",
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 0},
  soul_pos = {x = 0, y = 0,
    draw = function(card, scale_mod, rotate_mod)
      -- AAAAA
      card.children.center.VT.w = card.T.w
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.center.VT.w = card.T.w
    end},
  config = {extra = {Xmult_mod = 0.2, Xmult = 1, energy_total = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    info_queue[#info_queue+1] = {set = 'Other', key = 'energize'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'stellar_type'}
    return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.Xmult}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Stellar",
  atlas = "j_nacho_terapagos_stellar",
  blueprint_compat = true,
  custom_pool_func = true,
  aux_poke = true,
  in_pool = function(self)
    return false
  end,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable and context.consumeable.ability then
      if context.consumeable.ability.name == 'teraorb' then
        if (G.jokers.highlighted[1] == card and #G.jokers.highlighted == 1) or (G.jokers.cards[1] == card and #G.jokers.highlighted == 0) then
          for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card then
              energy_increase(G.jokers.cards[i], G.jokers.cards[i].ability.extra.ptype)
              apply_type_sticker(G.jokers.cards[i], "Stellar")
            end
          end
        end
      end
    end
    if context.other_joker and is_type(context.other_joker, "Stellar") then
      local xmult = 1 + card.ability.extra.Xmult_mod * get_total_energy(context.other_joker)
      G.E_MANAGER:add_event(Event({
        func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
        end
      }))
      return{
        message = localize{type = 'variable', key = 'a_xmult', vars = {xmult}},
        colour = G.C.XMULT,
        Xmult_mod = xmult
      }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.0, func = function()
              card.children.center:reset()
              if card.children.floating_sprite then
                card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.children.center.atlas.name .. "_soul"]
                card.children.floating_sprite:reset()
              end
              return true end }))
    if not G.GAME.energy_plus then
      G.GAME.energy_plus = 5
    else
      G.GAME.energy_plus = G.GAME.energy_plus + 5
    end
    if not from_debuff then
      for i = 1, #G.jokers.cards do
        apply_type_sticker(G.jokers.cards[i], G.jokers.cards[i].config.center.ptype)
        apply_type_sticker(G.jokers.cards[i], "Stellar")
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not G.GAME.energy_plus then
      G.GAME.energy_plus = 0
    else
      G.GAME.energy_plus = G.GAME.energy_plus - 5
    end
  end,
  set_sprites = function(self, card, front)
    if self.discovered or card.bypass_discovery_center then
      card.children.center:reset()
      if card.children.floating_sprite then
        card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.children.center.atlas.name .. "_soul"]
        card.children.floating_sprite:reset()
      end
    end
  end,
  update = function(self, card, dt)
    card.children.center.VT.x = 0.35 + card.T.x - (G.CARD_H - G.CARD_W) / 2
    card.children.floating_sprite.VT.x = card.children.center.VT.x
    card.children.center.VT.w = card.T.w
    if poke_is_in_collection(card) then
      apply_type_sticker(card, "Stellar")
    end
  end,
}

list = {terapagos, terapagos_terastal, terapagos_stellar}

return {name = "nachopokemon9", list = list}


function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end


-- Ralts 280
local ralts={
  name = "ralts",
  poke_custom_prefix = "nacho",
  pos = {x = 8, y = 2},
  config = {extra = {mult_mod = 1, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Foxthor, One Punch Idiot"}}
    local mult = 0
    for _, v in pairs(G.GAME.hands) do
      mult = mult + (v.level - 1) * card.ability.extra.mult_mod
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.rounds}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Base",
  ptype = "Psychic",
  atlas = "poke_Pokedex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  set_badges = function(self, card, badges)
    poke_set_type_badge(self, card, badges)
    local size = 0.9
    local font = G.LANG.font
    local max_text_width = 2 - 2*0.05 - 4*0.03*size - 2*0.03
    local calced_text_width = 0
    local scale_fac = calced_text_width > max_text_width and max_text_width/calced_text_width or 1
    local modcredits = string.sub(localize('maelmc'), 1, 20)
    for _, c in utf8.chars(modcredits) do
      local tx = font.FONT:getWidth(c)*(0.33*size)*G.TILESCALE*font.FONTSCALE + 2.7*1*G.TILESCALE*font.FONTSCALE
      calced_text_width = calced_text_width + tx/(G.TILESIZE*G.TILESCALE)
    end
    badges[#badges+1] = {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.R, config={align = "cm", colour = HEX('EA6F22'), r = 0.1, minw = 2, minh = 0.36, emboss = 0.05, padding = 0.03*size}, nodes={
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                  {n=G.UIT.O, config={object = DynaText({string = modcredits, colours = {HEX('FFFFFF')}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1*scale_fac, scale = 0.27*size*scale_fac})}},
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                }}
              }}
 	end,
  calculate = function(self, card, context)

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = 0
        for _, v in pairs(G.GAME.hands) do
          mult = mult + (v.level - 1) * card.ability.extra.mult_mod
        end
        if mult > 0 then
          return {
            colour = G.C.MULT,
            mult = mult,
            card = card
          }
        end
      end
    end

    return level_evo(self, card, context, "j_nacho_kirlia")
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Kirlia 281
local kirlia={
  name = "kirlia",
  poke_custom_prefix = "nacho",
  pos = {x = 9, y = 2},
  config = {extra = {mult_mod = 2, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Foxthor, One Punch Idiot"}}
    local mult = 0
    for _, v in pairs(G.GAME.hands) do
      mult = mult + (v.level - 1) * card.ability.extra.mult_mod
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 9,
  item_req = "dawnstone",
  stage = "One",
  ptype = "Psychic",
  atlas = "poke_Pokedex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  set_badges = function(self, card, badges)
    poke_set_type_badge(self, card, badges)
    local size = 0.9
    local font = G.LANG.font
    local max_text_width = 2 - 2*0.05 - 4*0.03*size - 2*0.03
    local calced_text_width = 0
    local scale_fac = calced_text_width > max_text_width and max_text_width/calced_text_width or 1
    local modcredits = string.sub(localize('maelmc'), 1, 20)
    for _, c in utf8.chars(modcredits) do
      local tx = font.FONT:getWidth(c)*(0.33*size)*G.TILESCALE*font.FONTSCALE + 2.7*1*G.TILESCALE*font.FONTSCALE
      calced_text_width = calced_text_width + tx/(G.TILESIZE*G.TILESCALE)
    end
    badges[#badges+1] = {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.R, config={align = "cm", colour = HEX('EA6F22'), r = 0.1, minw = 2, minh = 0.36, emboss = 0.05, padding = 0.03*size}, nodes={
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                  {n=G.UIT.O, config={object = DynaText({string = modcredits, colours = {HEX('FFFFFF')}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1*scale_fac, scale = 0.27*size*scale_fac})}},
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                }}
              }}
 	end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = 0
        for _, v in pairs(G.GAME.hands) do
          mult = mult + (v.level - 1) * card.ability.extra.mult_mod
        end
        if mult > 0 then
          return {
            colour = G.C.MULT,
            mult = mult,
            card = card
          }
        end
      end
    end
    local evolve = item_evo(self, card, context, "j_nacho_gallade")
    if evolve then
      return evolve
    else 
      return level_evo(self, card, context, "j_nacho_gardevoir")
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Gardevoir 282
local gardevoir={
  name = "gardevoir",
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 3},
  config = {extra = {Xmult_mod = 0.1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Foxthor, One Punch Idiot"}}
    local xmult = 1
    for _, v in pairs(G.GAME.hands) do
      xmult = xmult + (v.level - 1) * card.ability.extra.Xmult_mod
    end
    return {vars = {card.ability.extra.Xmult_mod, xmult}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Psychic",
  atlas = "poke_Pokedex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  set_badges = function(self, card, badges)
    poke_set_type_badge(self, card, badges)
    local size = 0.9
    local font = G.LANG.font
    local max_text_width = 2 - 2*0.05 - 4*0.03*size - 2*0.03
    local calced_text_width = 0
    local scale_fac = calced_text_width > max_text_width and max_text_width/calced_text_width or 1
    local modcredits = string.sub(localize('maelmc'), 1, 20)
    for _, c in utf8.chars(modcredits) do
      local tx = font.FONT:getWidth(c)*(0.33*size)*G.TILESCALE*font.FONTSCALE + 2.7*1*G.TILESCALE*font.FONTSCALE
      calced_text_width = calced_text_width + tx/(G.TILESIZE*G.TILESCALE)
    end
    badges[#badges+1] = {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.R, config={align = "cm", colour = HEX('EA6F22'), r = 0.1, minw = 2, minh = 0.36, emboss = 0.05, padding = 0.03*size}, nodes={
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                  {n=G.UIT.O, config={object = DynaText({string = modcredits, colours = {HEX('FFFFFF')}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1*scale_fac, scale = 0.27*size*scale_fac})}},
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                }}
              }}
 	end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xmult = 1
        for _, v in pairs(G.GAME.hands) do
          xmult = xmult + (v.level - 1) * card.ability.extra.Xmult_mod
        end
        if xmult > 1 then
          return {
            colour = G.C.MULT,
            xmult = xmult,
            card = card
          }
        end
      end
    end
  end,
  megas = {"mega_gardevoir"},
  prefix_config = {
    atlas = false,
  },
}

-- Mega Gardevoir 282-1
local mega_gardevoir={
  name = "mega_gardevoir",
  poke_custom_prefix = "nacho",
  pos = {x = 3, y = 3},
  soul_pos = { x = 4, y = 3 },
  config = {extra = {blackhole_amount = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho, Maelmc"}}
    info_queue[#info_queue+1] = {key = 'tag_orbital', set = 'Tag', specific_vars = {"Random Hand", 3}}
    return {vars = {card.ability.extra.blackhole_amount}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Psychic",
  atlas = "poke_Megas",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  set_badges = function(self, card, badges)
    poke_set_type_badge(self, card, badges)
    local size = 0.9
    local font = G.LANG.font
    local max_text_width = 2 - 2*0.05 - 4*0.03*size - 2*0.03
    local calced_text_width = 0
    local scale_fac = calced_text_width > max_text_width and max_text_width/calced_text_width or 1
    local modcredits = string.sub(localize('maelmc'), 1, 20)
    for _, c in utf8.chars(modcredits) do
      local tx = font.FONT:getWidth(c)*(0.33*size)*G.TILESCALE*font.FONTSCALE + 2.7*1*G.TILESCALE*font.FONTSCALE
      calced_text_width = calced_text_width + tx/(G.TILESIZE*G.TILESCALE)
    end
    badges[#badges+1] = {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.R, config={align = "cm", colour = HEX('EA6F22'), r = 0.1, minw = 2, minh = 0.36, emboss = 0.05, padding = 0.03*size}, nodes={
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                  {n=G.UIT.O, config={object = DynaText({string = modcredits, colours = {HEX('FFFFFF')}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1*scale_fac, scale = 0.27*size*scale_fac})}},
                  {n=G.UIT.B, config={h=0.1,w=0.03}},
                }}
              }}
 	end,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable and context.consumeable.ability then
      if context.consumeable.ability.set == 'Planet' then
        local tag = Tag('tag_orbital')
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
          if v.visible then
            _poker_hands[#_poker_hands + 1] = k
          end
        end
        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed('mega_gardevoir'))
        G.E_MANAGER:add_event(Event({
          func = (function()
              add_tag(tag)
              play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
              play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
              return true
          end)
        }))
      end
    end

    if context.end_of_round and not context.blueprint then
      for k, v in ipairs(G.consumeables.cards) do
        if v.ability.set == 'Planet' and not v.edition then
          local edition = {polychrome = true}
          v:set_edition(edition, true)
        end
      end
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      local _card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_black_hole")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Turtwig 387
local turtwig={
  name = "turtwig",
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 0},
  config = {extra = {h_size = 1, interest = 5, counter = 0, raised = false, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.h_size, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Grass",
  atlas = "poke_Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers then
      local evolved = level_evo(self, card, context, "j_nacho_grotle")
      if evolved then
        return evolved
      end
      card.ability.extra.counter = card.ability.extra.counter + 1
      G.GAME.interest_cap = G.GAME.interest_cap + (card.ability.extra.counter * card.ability.extra.interest)
      card.ability.extra.raised = true
      return {
          message = localize("poke_leech_seed_ex"),
          card = card,
        }
    end
    if context.ending_shop and card.ability.extra.raised then
      G.GAME.interest_cap = G.GAME.interest_cap - (card.ability.extra.counter * card.ability.extra.interest)
      card.ability.extra.raised = false
      return
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
    if card.ability.extra.raised then
      G.GAME.interest_cap = G.GAME.interest_cap - card.ability.extra.counter * card.ability.extra.interest
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Grotle 388
local grotle={
  name = "grotle",
  poke_custom_prefix = "nacho",
  pos = {x = 1, y = 0},
  config = {extra = {h_size = 1, interest = 10, counter = 0, raised = false, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.h_size, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Grass",
  atlas = "poke_Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers then
      local evolved = level_evo(self, card, context, "j_nacho_torterra")
      if evolved then
        return evolved
      end
      card.ability.extra.counter = card.ability.extra.counter + 1
      G.GAME.interest_cap = G.GAME.interest_cap + (card.ability.extra.counter * card.ability.extra.interest)
      card.ability.extra.raised = true
      return {
          message = localize("poke_leech_seed_ex"),
          card = card,
        }
    end
    if context.ending_shop and card.ability.extra.raised then
      G.GAME.interest_cap = G.GAME.interest_cap - (card.ability.extra.counter * card.ability.extra.interest)
      card.ability.extra.raised = false
      return
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
    if card.ability.extra.raised then
      G.GAME.interest_cap = G.GAME.interest_cap - card.ability.extra.counter * card.ability.extra.interest
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Torterra 389
local torterra={
  name = "torterra",
  poke_custom_prefix = "nacho",
  pos = {x = 2, y = 0},
  config = {extra = {h_size = 1, mult = 2, interest = 15, counter = 0, raised = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.h_size, card.ability.extra.mult}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Grass",
  atlas = "poke_Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.mult * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 5) }
    end
    if context.end_of_round and context.cardarea == G.jokers then
      card.ability.extra.counter = card.ability.extra.counter + 1
      G.GAME.interest_cap = G.GAME.interest_cap + (card.ability.extra.counter * card.ability.extra.interest)
      card.ability.extra.raised = true
      return {
          message = localize("poke_leech_seed_ex"),
          card = card,
        }
    end
    if context.ending_shop and card.ability.extra.raised then
      G.GAME.interest_cap = G.GAME.interest_cap - (card.ability.extra.counter * card.ability.extra.interest)
      card.ability.extra.raised = false
      return
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
    if card.ability.extra.raised then
      G.GAME.interest_cap = G.GAME.interest_cap - card.ability.extra.counter * card.ability.extra.interest
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Chimchar 390
local chimchar={
  name = "chimchar",
  poke_custom_prefix = "nacho",
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
  atlas = "poke_Pokedex4",
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
  prefix_config = {
    atlas = false,
  },
}

-- Monferno 391
local monferno={
  name = "monferno",
  poke_custom_prefix = "nacho",
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
  atlas = "poke_Pokedex4",
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
  prefix_config = {
    atlas = false,
  },
}

-- Infernape 392
local infernape = {
  name = "infernape",
  poke_custom_prefix = "nacho",
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
  atlas = "poke_Pokedex4",
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
  prefix_config = {
    atlas = false,
  },
}

-- Piplup 393
local piplup={
  name = "piplup",
  poke_custom_prefix = "nacho",
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
  atlas = "poke_Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
     if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local chip_total = card.ability.extra.chips - card.ability.extra.chip_loss * (#context.scoring_hand)
        if chip_total < 0 then chip_total = 0 end
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
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Prinplup 394
local prinplup={
  name = "prinplup",
  poke_custom_prefix = "nacho",
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
  atlas = "poke_Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)    
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      card.ability.extra.chip_mod = context.other_card.base.nominal
      return {
        h_chips = card.ability.extra.chip_mod,
        card = card,
      }
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
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Empoleon 395
local empoleon={
  name = "empoleon",
  poke_custom_prefix = "nacho",
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
  atlas = "poke_Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)    
     if context.individual and not context.end_of_round and context.cardarea == G.hand then
      card.ability.extra.chip_mod = context.other_card.base.nominal * 2
      return {
        h_chips = card.ability.extra.chip_mod,
        card = card,
      }
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
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Gallade 475
local gallade={
  name = "gallade",
  poke_custom_prefix = "nacho",
  pos = {x = 4, y = 6},
  config = {extra = {planets = 0, mult_mod = 1, Xmult_mod = 0.1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.planets, card.ability.extra.mult_mod, card.ability.extra.Xmult_mod}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fighting",
  atlas = "poke_Pokedex4",
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
          local _hand, _tally = nil, 0
          for k, v in ipairs(G.handlist) do
              if G.GAME.hands[v].visible and G.GAME.hands[v].played >= _tally then
                  _hand = v
                  _tally = G.GAME.hands[v].played
              end
          end
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
        local mult = 2 * G.GAME.hands[context.scoring_name].played
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
  prefix_config = {
    atlas = false,
  },
}

-- Mega-Gallade 475-1
local mega_gallade={
  name = "mega_gallade",
  poke_custom_prefix = "nacho",
  pos = {x = 2, y = 6},
  soul_pos = { x = 3, y = 6 },
  config = {extra = {mult_mod = 2, Xmult_mod = 0.2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.mult_mod, card.ability.extra.Xmult_mod}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Fighting",
  atlas = "poke_Megas",
  perishable_compat = true,
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
  prefix_config = {
    atlas = false,
  },
}

-- Carbink 703
local carbink = {
  name = "carbink", 
  poke_custom_prefix = "nacho",
  pos = {x = 11, y = 3},
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    return {vars = {}}
  end,
  rarity = 3,
  cost = 9,
  stage = "Basic",
  ptype = "Fairy",
  atlas = "poke_Pokedex6",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.check_enhancement and not context.blueprint then
      if context.other_card.config.center.key == "m_poke_hazard" then
        return {m_gold = true}
      end
    end
  end,
  in_pool = function(self, args)
    for _, joker in ipairs(G.jokers.cards or {}) do
        if joker.ability.extra.hazard_ratio ~= nil then return true end
    end
    return false
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Goomy 704
local goomy={
  name = "goomy", 
  poke_custom_prefix = "nacho",
  pos = {x = 12, y = 3},
  config = {extra = {mult_mod = 1, triggers = 0, flush_houses = 0}, evo_rqmt1 = 18, evo_rqmt2 = 1},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.mult_mod, math.max(0, self.config.evo_rqmt1 - card.ability.extra.triggers)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic", 
  ptype = "Dragon",
  atlas = "poke_Pokedex6",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- Check if Flush House played
    if context.before and context.main_eval and context.scoring_name == 'Flush House' then
      card.ability.extra.flush_houses = card.ability.extra.flush_houses + 1
      return
    end
    -- Main scoring bit
    if context.individual and context.cardarea == G.hand and not context.end_of_round then
      if next(context.poker_hands['Flush']) then
        -- Get cards specifically in Flush
        local scoring_flush = get_flush(context.scoring_hand)[1]
        local wildcount = 0
        local matching_suit = nil
        -- Count # of wilds and determine Flush suit
        for i = 1, #scoring_flush do
          if SMODS.has_enhancement(scoring_flush[i], 'm_wild') then wildcount = wildcount + 1
          else matching_suit = scoring_flush[i].config.card.suit end
        end
        -- Give cards in hand with matching suit permamult
        if wildcount == #scoring_flush or context.other_card:is_suit(matching_suit) then
          card.ability.extra.triggers = card.ability.extra.triggers + 1
          context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
          context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult_mod
          return {
            extra = {message = localize('k_upgrade_ex'), colour = G.C.MULT},
            colour = G.C.MULT,
            card = card
          }
        end
      end
    end
    local evolve = scaling_evo(self, card, context, "j_nacho_hisuian_sliggoo", card.ability.extra.flush_houses, self.config.evo_rqmt2)
    if evolve then
      return evolve
    else
      return scaling_evo(self, card, context, "j_nacho_sliggoo", card.ability.extra.triggers, self.config.evo_rqmt1)
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Sliggoo 705
local sliggoo={
  name = "sliggoo", 
  poke_custom_prefix = "nacho",
  pos = {x = 13, y = 3},
  config = {extra = {mult_mod = 1, flushes = 0}, evo_rqmt = 12},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.mult_mod, math.max(0, self.config.evo_rqmt - card.ability.extra.flushes)}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dragon",
  atlas = "poke_Pokedex6",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- Count # of Flushes played
    if context.before and context.main_eval and context.scoring_name == 'Flush' then
      card.ability.extra.flushes = card.ability.extra.flushes + 1
      return
    end
    if context.individual and (context.cardarea == G.hand or G.play) and not context.end_of_round then
      if context.scoring_name == 'Flush' then
        -- Get the scoring cards that make up the Flush only
        local scoring_flush = get_flush(context.scoring_hand)[1]
        local wildcount = 0
        local matching_suit = nil
        local unique_ranks = {}
        -- Count the unique ranks in scoring hand
        for i = 1, #context.scoring_hand do
          local contains = false
          if unique_ranks ~= {} then
            for j = 1, #unique_ranks do
              if context.scoring_hand[i]:get_id() == unique_ranks[j] then contains = true end
            end
          end
          if not contains then
            unique_ranks[#unique_ranks+1] = context.scoring_hand[i]:get_id()
          end
        end
        -- Count the # of wild cards and determine Flush suit
        for i = 1, #scoring_flush do
          if SMODS.has_enhancement(scoring_flush[i], 'm_wild') then wildcount = wildcount + 1
          else matching_suit = scoring_flush[i].config.card.suit end
        end
        -- Increment permamult if card matches Flush suit
        if wildcount == #scoring_flush or context.other_card:is_suit(matching_suit) then
          context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
          context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult_mod * #unique_ranks
          return {
            extra = {message = localize('k_upgrade_ex'), colour = G.C.MULT},
            colour = G.C.MULT,
            card = card
          }
        end
      end
    end
    return scaling_evo(self, card, context, "j_nacho_goodra", card.ability.extra.flushes, self.config.evo_rqmt)
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Goodra 706
local goodra={
  name = "goodra", 
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 4},
  config = {extra = {Xmult_multi = 0.02}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.Xmult_multi}}
  end,
  rarity = "poke_safari",
  cost = 11,
  stage = "Two",
  ptype = "Dragon",
  atlas = "poke_Pokedex6",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and (context.cardarea == G.hand or G.play) and not context.end_of_round then
      if context.scoring_name == 'Flush' then
        -- Get the scoring cards that make up the Flush only
        local scoring_flush = get_flush(context.scoring_hand)[1]
        local wildcount = 0
        local matching_suit = nil
        local unique_ranks = {}
        -- Count the unique ranks in scoring hand
        for i = 1, #context.scoring_hand do
          local contains = false
          if unique_ranks ~= {} then
            for j = 1, #unique_ranks do
              if context.scoring_hand[i]:get_id() == unique_ranks[j] then contains = true end
            end
          end
          if not contains then
            unique_ranks[#unique_ranks+1] = context.scoring_hand[i]:get_id()
          end
        end
        -- Count the # of wild cards and determine Flush suit
        for i = 1, #scoring_flush do
          if SMODS.has_enhancement(scoring_flush[i], 'm_wild') then wildcount = wildcount + 1
          else matching_suit = scoring_flush[i].config.card.suit end
        end
        -- Increment permamult if card matches Flush suit
        if wildcount == #scoring_flush or context.other_card:is_suit(matching_suit) then
          context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
          context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.Xmult_multi * #unique_ranks
          return {
            extra = {message = localize('k_upgrade_ex'), colour = G.C.MULT},
            colour = G.C.MULT,
            card = card
          }
        end
      end
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Turtonator 776
local turtonator={
  name = "turtonator",
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 5},
  config = {extra = {Xmult_mod = 1.5, trapped = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    local active = nil
    if card.ability.extra.trapped then active = "Active!"
    else active = "Inactive" end
    return {vars = {card.ability.extra.Xmult_mod, active}}
  end,
  rarity = 2,
  cost = 8,
  stage = "Basic",
  ptype = "Dragon",
  atlas = "poke_Pokedex7",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and context.main_eval and card.ability.extra.trapped then
      return{
        message = localize('poke_shell_trap_ex'),
        colour = G.C.XMULT,
        card = card,
      }
    end
    if context.individual and context.cardarea == G.play and context.scoring_hand then 
      if card.ability.extra.trapped then
        return{
        xmult = card.ability.extra.Xmult_mod,
        colour = G.C.XMULT,
        }
      end
    end
    if context.joker_main then
      if not card.ability.extra.trapped and G.GAME.blind.triggered then
        card.ability.extra.trapped = true
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_shell_trap_ex')})
        return
      elseif card.ability.extra.trapped then card.ability.extra.trapped = false end
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Skwovet 819
local skwovet={
  name = "skwovet", 
  poke_custom_prefix = "nacho",
  pos = {x = 9, y = 0}, 
  config = {extra = {mult = 0, mult_mod = 1, rounds = 5, in_blind = false}, evo_rqmt = 12},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod}}
  end,
  rarity = 1, 
  cost = 5, 
  stage = "Basic", 
  ptype = "Colorless",
  atlas = "poke_Pokedex8",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Check if blind starts
    if context.setting_blind and not context.blueprint then
      card.ability.extra.in_blind = true
      return{}
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
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult = card.ability.extra.mult
        }
      end
    end

    return scaling_evo(self, card, context, "j_nacho_greedent", card.ability.extra.mult, self.config.evo_rqmt)
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Greedent 820
local greedent={
  name = "greedent", 
  poke_custom_prefix = "nacho",
  pos = {x = 10, y = 0}, 
  config = {extra = {mult = 0, mult_mod = 2, odds = 4, in_blind = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.odds}}
  end,
  rarity = "poke_safari",
  cost = 10, 
  stage = "One", 
  ptype = "Colorless",
  atlas = "poke_Pokedex8",
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
      if (pseudorandom('greedent') < G.GAME.probabilities.normal/card.ability.extra.odds) and not from_debuff and context.consumeable.ability.name ~= 'leftovers' then
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
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Meowth 52-2
local galarian_meowth={
  name = "galarian_meowth", 
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 2},
  config = {extra = {metals = 0, retriggers = 1, counter = 0}, evo_rqmt = 2},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		return {vars = {card.ability.extra.retriggers}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Metal",
  atlas = "poke_Regionals",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint then
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
  prefix_config = {
    atlas = false,
  },
}

-- Perrserker 863
local perrserker = {
  name = "perrserker",
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 4},
  config = { extra = {Ymult = 1.5} },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return { vars = {card.ability.extra.Ymult} }
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "One",
  atlas = "poke_Pokedex8",
  ptype = "Metal",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
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
      if metals == #G.jokers.cards and (context.other_card.ability and context.other_card.ability.name == "perrserker") then
        return {
          message = localize("k_again_ex"),
          colour = G.C.BLACK,
          repetitions = 1,
          card = card,
        }
      end
		end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Hisuian Zorua 570-1
local hisuian_zorua = {
  name = "hisuian_zorua", 
  poke_custom_prefix = "nacho",
  pos = { x = 9, y = 4 },
  soul_pos = { x = 9, y = 5 },
  config = {extra = {hidden_key = nil, rounds = 5, active = true}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"ESN64"}}
    return { vars = {} }
  end,
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "poke_Regionals",
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
        card.children.center.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_ShinyRegionals" or "poke_Regionals"]
        card.children.center:set_sprite_pos(self.pos)
        card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_ShinyRegionals" or "poke_Regionals"]
        card.children.floating_sprite:set_sprite_pos(self.soul_pos)
      end
    elseif poke_is_in_collection(card) and card.children.center.sprite_pos ~= self.pos and card.children.center.atlas.name ~= self.atlas then
      self:set_ability(card)
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Hisuian Zoroark 571-1
local hisuian_zoroark = {
  name = "hisuian_zoroark", 
  poke_custom_prefix = "nacho",
  pos = { x = 10, y = 4 },
  soul_pos = { x = 10, y = 5 },
  config = {extra = {hidden_key = nil}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"ESN64"}}
    return { vars = {} }
  end,
  rarity = "poke_safari",
  cost = 12,
  stage = "One",
  ptype = "Colorless",
  atlas = "poke_Regionals",
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
        card.children.center.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_ShinyRegionals" or "poke_Regionals"]
        card.children.center:set_sprite_pos(self.pos)
        card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.edition and card.edition.poke_shiny and "poke_ShinyRegionals" or "poke_Regionals"]
        card.children.floating_sprite:set_sprite_pos(self.soul_pos)
      end
    elseif poke_is_in_collection(card) and card.children.center.sprite_pos ~= self.pos and card.children.center.atlas.name ~= self.atlas then
      self:set_ability(card)
    end
  end,
  prefix_config = {
    atlas = false,
  },
}

-- Hisuian Sliggoo 705-1
local hisuian_sliggoo={
  name = "hisuian_sliggoo",
  poke_custom_prefix = "nacho",
  pos = {x = 0, y = 5},
  config = {extra = {flush_houses = 0}, evo_rqmt = 6},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {math.max(0, self.config.evo_rqmt - card.ability.extra.flush_houses)}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Metal",
  atlas = "poke_Regionals",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- Count # of Flush Houses played
    if context.before and context.main_eval and context.scoring_name == 'Flush House' then
      card.ability.extra.flush_houses = card.ability.extra.flush_houses + 1
      return
    end
    -- Main function
    if context.joker_main and context.scoring_name == 'Flush House' then
      -- Create table of scoring ranks
      local ranks = {}
      for i = 1, #context.scoring_hand do
        local contains = false
        if ranks ~= {} then
          for j = 1, #ranks do
            if context.scoring_hand[i].base.nominal == ranks[j] then contains = true end
          end
        end
        if not contains then
          ranks[#ranks+1] = context.scoring_hand[i].base.nominal
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
      if math.abs(ranks[2] - ranks[1]) > 6 then
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
  prefix_config = {
    atlas = false,
  },
}

-- Hisuian Goodra 706-1
local hisuian_goodra={
  name = "hisuian_goodra", 
  poke_custom_prefix = "nacho",
  pos = {x = 1, y = 5},
  config = {extra = {Xmult = 0.0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Eternalnacho"}}
    return {vars = {card.ability.extra.Xmult_multi}}
  end,
  rarity = "poke_safari",
  cost = 11,
  stage = "Two",
  ptype = "Metal",
  atlas = "poke_Regionals",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round then
      if context.scoring_name == 'Flush House' then
        -- Create table of scoring ranks
        local ranks = {}
        for i = 1, #context.scoring_hand do
          local contains = false
          if ranks ~= {} then
            for j = 1, #ranks do
              if context.scoring_hand[i].base.nominal == ranks[j] then contains = true end
            end
          end
          if not contains then
            ranks[#ranks+1] = context.scoring_hand[i].base.nominal
          end
        end
         -- Create metal coat
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_poke_metalcoat')
          _card:add_to_deck()
          G.consumeables:emplace(_card)
          card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
        end
        -- Set Xmult_mod
        card.ability.extra.Xmult = math.abs(ranks[2] - ranks[1]) / 3.0
        if SMODS.has_enhancement(context.other_card, 'm_steel') then
          return{
            xmult = card.ability.extra.Xmult,
            card = card,
          }
        end
      end
    end
  end,
  prefix_config = {
    atlas = false,
  },
}


list = {ralts, kirlia, gardevoir, mega_gardevoir, turtwig, grotle, torterra, chimchar, monferno, infernape, piplup, prinplup, empoleon, gallade, mega_gallade,
       carbink, goomy, sliggoo, goodra, turtonator, skwovet, greedent, galarian_meowth, perrserker, hisuian_zorua, hisuian_zoroark, hisuian_sliggoo, hisuian_goodra}
return {name = "nachopokemon1", list = list}
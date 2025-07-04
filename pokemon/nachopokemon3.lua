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
  atlas = "Pokedex3",
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
          if (SMODS.Mods["Talisman"] or {}).can_load then
            mult = mult + (to_number(v.level) - 1) * card.ability.extra.mult_mod
          else
            mult = mult + (v.level - 1) * card.ability.extra.mult_mod
          end
        end
        return {
          mult = mult,
          card = card
        }
      end
    end
    return level_evo(self, card, context, "j_nacho_kirlia")
  end,
}

-- Kirlia 281
local kirlia={
  name = "kirlia",
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
  atlas = "Pokedex3",
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
          if (SMODS.Mods["Talisman"] or {}).can_load then
            mult = mult + (to_number(v.level) - 1) * card.ability.extra.mult_mod
          else
            mult = mult + (v.level - 1) * card.ability.extra.mult_mod
          end
        end
        return {
          mult = mult,
          card = card
        }
      end
    end
    local evolve = item_evo(self, card, context, "j_nacho_gallade")
    if evolve then
      return evolve
    else
      return level_evo(self, card, context, "j_nacho_gardevoir")
    end
  end,
}

-- Gardevoir 282
local gardevoir={
  name = "gardevoir",
  pos = {x = 0, y = 3},
  config = {extra = {Xmult_mod = 0.1, Xmult = 1.0}},
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
  atlas = "Pokedex3",
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
          if (SMODS.Mods["Talisman"] or {}).can_load then
            xmult = xmult + (to_number(v.level) - 1) * card.ability.extra.Xmult_mod
          else
            xmult = xmult + (v.level - 1) * card.ability.extra.Xmult_mod
          end
        end
        if xmult > 1 then
          return {
            xmult = xmult,
            card = card
          }
        end
      end
    end
  end,
  megas = {"mega_gardevoir"},
}

-- Mega Gardevoir 282-1
local mega_gardevoir={
  name = "mega_gardevoir",
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
  atlas = "Megas",
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
    -- Create Orbital Tag on Planet Use
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
    -- Set Planet Cards in Hand to Polychrome at end of round
    if context.end_of_round and not context.blueprint then
      for k, v in ipairs(G.consumeables.cards) do
        if v.ability.set == 'Planet' and not v.edition then
          local edition = {polychrome = true}
          v:set_edition(edition, true)
        end
      end
    end
  end,
  -- Negative Black Hole generation on entry
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
}


list = {ralts, kirlia, gardevoir, mega_gardevoir}
return {name = "nachopokemon3", list = list}

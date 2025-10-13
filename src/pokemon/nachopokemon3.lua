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
  config = {extra = {mult_mod = 1, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local mult = 0
    for _, v in pairs(G.GAME.hands) do
      mult = mult + (v.level - 1) * card.ability.extra.mult_mod
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.rounds}}
  end,
  designer = "Foxthor, One Punch Idiot",
  rarity = 3,
  cost = 8,
  stage = "Base",
  ptype = "Psychic",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
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
  config = {extra = {mult_mod = 2, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local mult = 0
    for _, v in pairs(G.GAME.hands) do
      mult = mult + (v.level - 1) * card.ability.extra.mult_mod
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.rounds}}
  end,
  designer = "Foxthor, One Punch Idiot",
  rarity = "poke_safari",
  cost = 9,
  item_req = "dawnstone",
  stage = "One",
  ptype = "Psychic",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
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
  config = {extra = {Xmult_multi = 0.1, Xmult = 1.0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local xmult = 1
    for _, v in pairs(G.GAME.hands) do
      xmult = xmult + (v.level - 1) * card.ability.extra.Xmult_multi
    end
    return {vars = {card.ability.extra.Xmult_multi, xmult}}
  end,
  designer = "Foxthor, One Punch Idiot",
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Psychic",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xmult = 1
        for _, v in pairs(G.GAME.hands) do
          if (SMODS.Mods["Talisman"] or {}).can_load then
            xmult = xmult + (to_number(v.level) - 1) * card.ability.extra.Xmult_multi
          else
            xmult = xmult + (v.level - 1) * card.ability.extra.Xmult_multi
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
  config = {extra = {blackhole_amount = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {key = 'tag_orbital', set = 'Tag', specific_vars = {"Random Hand", 3}}
    return {vars = {card.ability.extra.blackhole_amount}}
  end,
  designer = "Eternalnacho, Maelmc",
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Psychic",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
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

-- Bagon 371
local bagon={
  name = "bagon",
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local deck_data = ''
    if G.playing_cards then
      local high_count = 0
      for k, v in pairs(G.playing_cards) do
        if v.base.nominal >= 9 then high_count = high_count + 1 end
      end
      deck_data = ' ['..tostring(high_count)..'/'..tostring(math.ceil(#G.playing_cards * 9 / 16))..']'
    end
    return {vars = {deck_data}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Dragon",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and context.scoring_name == "Two Pair" then
      for k, v in pairs(G.hand.cards) do
        if v == G.hand.cards[#G.hand.cards] then
          -- This whole set of events is just the Strength Tarot from VanillaRemade
          G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
              play_sound('tarot1')
              card:juice_up(0.3, 0.5)
              return true
          end
          }))
          local percent = 1.15 - ((v:get_id() / 7) - 0.999) / ((v:get_id() / 7) - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.15,
              func = function()
                  v:flip()
                  play_sound('card1', percent)
                  v:juice_up(0.3, 0.3)
                  return true
              end
          }))
          delay(0.2)
          G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.1,
              func = function()
                  -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                  assert(SMODS.modify_rank(v, math.min(14 - v:get_id(), 1)))
                  return true
              end
          }))
          local percent = 0.85 + ((v:get_id() / 7) - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.15,
              func = function()
                  v:flip()
                  play_sound('tarot2', percent, 0.6)
                  v:juice_up(0.3, 0.3)
                  return true
              end
          }))
          delay(0.5)
        end
      end
    end
    -- Scoring effect
    if context.individual and context.cardarea == G.play and context.scoring_name == "Two Pair" then
      return{
        mult = context.other_card.base.nominal / 3,
        card = context.other_card or card
      }
    end
    if context.cardarea == G.jokers and context.scoring_hand and context.scoring_name == "Two Pair" then
      if context.joker_main then
        if not context.blueprint then
          local high_count = 0
          for k, v in pairs(G.playing_cards) do
            if v.base.nominal > 9 then high_count = high_count + 1 end
          end
          card.ability.extra.high_ranks = high_count
        end
      end
    end
    return deck_rank_evo(self, card, context, "j_nacho_shelgon", 9, .57)
  end
}

-- Shelgon 372
local shelgon={
  name = "shelgon",
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local deck_data = ''
    if G.playing_cards then
      local high_count = 0
      for k, v in pairs(G.playing_cards) do
        if v.base.nominal >= 9 then high_count = high_count + 1 end
      end
      deck_data = ' ['..tostring(high_count)..'/'..tostring(math.ceil(#G.playing_cards * 3 / 4))..']'
    end
    return {vars = {deck_data}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Dragon",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and context.scoring_name == "Two Pair" then
      for k, v in pairs(G.hand.cards) do
        if v == G.hand.cards[#G.hand.cards] or v == G.hand.cards[#G.hand.cards - 1] then
          -- This whole set of events is just the Strength Tarot from VanillaRemade
          G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
              play_sound('tarot1')
              card:juice_up(0.3, 0.5)
              return true
          end
          }))
          local percent = 1.15 - ((v:get_id() / 7) - 0.999) / ((v:get_id() / 7) - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.15,
              func = function()
                  v:flip()
                  play_sound('card1', percent)
                  v:juice_up(0.3, 0.3)
                  return true
              end
          }))
          delay(0.2)
          G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.1,
              func = function()
                  -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                  assert(SMODS.modify_rank(v, math.min(14 - v:get_id(), 1)))
                  return true
              end
          }))
          local percent = 0.85 + ((v:get_id() / 7) - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.15,
              func = function()
                  v:flip()
                  play_sound('tarot2', percent, 0.6)
                  v:juice_up(0.3, 0.3)
                  return true
              end
          }))
          delay(0.5)
        end
      end
    end
    -- Scoring effect
    if context.individual and context.cardarea == G.play and context.scoring_name == "Two Pair" then
      return{
        mult = context.other_card.base.nominal / 2,
        card = context.other_card or card
      }
    end
    if context.cardarea == G.jokers and context.scoring_hand and context.scoring_name == "Two Pair" then
      if context.joker_main then
        if not context.blueprint then
          local high_count = 0
          for k, v in pairs(G.playing_cards) do
            if v.base.nominal > 9 then high_count = high_count + 1 end
          end
          card.ability.extra.high_ranks = high_count
        end
      end
    end
    return deck_rank_evo(self, card, context, "j_nacho_salamence", 9, .75)
  end
}

-- Salamence 373
local salamence={
  name = "salamence",
  config = {extra = {Xmult = 0.1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 11,
  stage = "Two",
  ptype = "Dragon",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.scoring_name == "Two Pair" then
        local avg_rank = 0
          for k, v in pairs(G.playing_cards) do
            avg_rank = v.base.nominal + avg_rank
          end
        avg_rank = avg_rank / #G.playing_cards
        return{
          Xmult = 1 + avg_rank * card.ability.extra.Xmult,
          card = context.other_card or card
        }
      end
    end
  end,
  megas = {"mega_salamence"},
}

-- Mega Salamence 373-1
local mega_salamence={
  name = "mega_salamence",
  config = {extra = {Xmult = 1.5, retriggers = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Dragon",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.scoring_name == "Two Pair" then
      return {
        xmult = card.ability.extra.Xmult,
        card = context.other_card or card
      }
    end
    if context.repetition and not context.end_of_round and context.cardarea == G.play and context.other_card:get_id() > 9 then
      card.ability.extra.retriggers = math.max(context.other_card.base.nominal - 9, 0)
      return {
        message = localize('k_again_ex'),
        repetitions = card.ability.extra.retriggers,
        card = card
      }
    end
  end,
}


list = {}
if nacho_config.Ralts then list[#list+1] = ralts end
if nacho_config.Ralts then list[#list+1] = kirlia end
if nacho_config.Ralts then list[#list+1] = gardevoir end
if nacho_config.Ralts then list[#list+1] = mega_gardevoir end

if nacho_config.Bagon then list[#list+1] = bagon end
if nacho_config.Bagon then list[#list+1] = shelgon end
if nacho_config.Bagon then list[#list+1] = salamence end
if nacho_config.Bagon then list[#list+1] = mega_salamence end

return {name = "nachopokemon3", list = list}

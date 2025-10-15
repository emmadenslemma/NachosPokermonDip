function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Clauncher 692
local clauncher = {
  name = "clauncher",
  config = {extra = {mult = 6, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.mult, card.ability.extra.rounds}}
  end,
  designer = "Eternalnacho",
  rarity = 1,
  cost = 5,
  stage = "Basic",
  ptype = "Water",
  blueprint_compat = true,
  custom_pool_func = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local editions = 0
      for k, v in pairs(G.play.cards) do
        if v.edition and (v.edition.foil or v.edition.holographic or v.edition.polychrome) then editions = editions + 1 end
      end
      return {
        mult = card.ability.extra.mult * (editions),
        card = card
      }
    end
    return level_evo(self, card, context, "j_nacho_clawitzer")
  end,
  in_pool = function(self, args)
    for k, v in pairs(G.playing_cards) do
      if v.edition and (v.edition.foil or v.edition.holographic or v.edition.polychrome) then return true end
    end
    return false
  end,
}

-- Clawitzer 693
local clawitzer = {
  name = "clawitzer",
  config = {extra = {Xchips = 1.5, Xmult = 1.3, Xmult1 = 1.2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xchips, card.ability.extra.Xmult, card.ability.extra.Xmult1}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 10,
  stage = "One",
  ptype = "Water",
  blueprint_compat = true,
  custom_pool_func = true,
  calculate = function(self, card, context)
    if context.individual and context.other_card.edition then
      if context.other_card.edition.foil and context.cardarea == G.play then
        return{
          chips = card.ability.extra.Xchips * poke_total_chips(context.other_card),
          card = context.other_card or card
        }
      elseif context.other_card.edition.holographic and context.cardarea == G.play then
        return{
          xmult = card.ability.extra.Xmult,
          card = context.other_card or card
        }
      elseif context.other_card.edition.polychrome and context.cardarea == G.hand and not context.end_of_round then
        return{
          xmult = card.ability.extra.Xmult1,
          card = context.other_card or card
        }
      end
    end
  end,
  in_pool = function(self, args)
    for k, v in pairs(G.playing_cards) do
      if v.edition and (v.edition.foil or v.edition.holographic or v.edition.polychrome) then return true end
    end
    return false
  end,
}

-- Dedenne 702
local dedenne = {
  name = "dedenne",
  config = {extra = {odds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    return {vars = {card.ability.extra.odds}}
  end,
  designer = "Eternalnacho",
  rarity = 1,
  cost = 4,
  enhancement_gate = "m_gold",
  stage = "Basic",
  ptype = "Lightning",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.hand then
      if (next(context.card_effects[1]) or #context.card_effects > 1) and SMODS.has_enhancement(context.other_card, 'm_gold') and
      #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if pseudorandom('dedenne') < G.GAME.probabilities.normal/card.ability.extra.odds then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (function()
                  local _card = create_card('Item', G.consumeables, nil, nil, nil, nil)
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.ARGS.LOC_COLOURS.item})
                  G.GAME.consumeable_buffer = 0
                  return true
          end)}))
          return {
            repetitions = 0,
            card = card,
          }
        end
      end
    end
  end,
}

-- Carbink 703
local carbink = {
  name = "carbink",
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    return {vars = {}}
  end,
  designer = "Eternalnacho",
  rarity = 1,
  cost = 5,
  stage = "Basic",
  ptype = "Fairy",
  blueprint_compat = true,
  custom_pool_func = true, 
  calculate = function(self, card, context)
    if context.check_enhancement and not context.blueprint then
      if context.other_card.config.center.key == "m_poke_hazard" then
        return {m_gold = true}
      end
    end
  end,
  in_pool = function(self, args)
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].ability and G.jokers.cards[i].ability.extra and type(G.jokers.cards[i].ability.extra) == "table" and
        G.jokers.cards[i].ability.extra.hazards ~= nil then return true end
    end
    return false
  end,
}

-- Goomy 704
local goomy={
  name = "goomy",
  config = {extra = {mult_mod = 1, flushes = 0, flush_houses = 0}, evo_rqmt1 = 6, evo_rqmt2 = 1},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.mult_mod, math.max(0, self.config.evo_rqmt1 - card.ability.extra.flushes)}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Dragon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- Check if Flush House played
    if context.before and context.main_eval then
      if context.scoring_name == 'Flush' then
        card.ability.extra.flushes = card.ability.extra.flushes + 1
        return
      elseif context.scoring_name == 'Flush House' then
        card.ability.extra.flush_houses = card.ability.extra.flush_houses + 1
        return
      end
    end
    -- Main scoring bit
    if context.individual and (context.cardarea == G.hand or context.cardarea == G.play) and not context.end_of_round then
      if next(context.poker_hands['Flush']) then
        -- Get cards specifically in Flush
        local scoring_flush = get_flush(context.scoring_hand)[1]
        local wildcount = 0
        local matching_suit = nil
        -- Count # of wilds and determine Flush suit
        if scoring_flush then
          for i = 1, #scoring_flush do
            if SMODS.has_enhancement(scoring_flush[i], 'm_wild') then wildcount = wildcount + 1
            else matching_suit = scoring_flush[i].config.card.suit end
          end
          -- Give cards in hand with matching suit permamult
          if wildcount == #scoring_flush or context.other_card:is_suit(matching_suit) then
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
    end
    local evolve = scaling_evo(self, card, context, "j_nacho_hisuian_sliggoo", card.ability.extra.flush_houses, self.config.evo_rqmt2)
    if evolve then
      return evolve
    else
      return scaling_evo(self, card, context, "j_nacho_sliggoo", card.ability.extra.flushes, self.config.evo_rqmt1)
    end
  end
}

-- Sliggoo 705
local sliggoo={
  name = "sliggoo",
  config = {extra = {mult_mod = 1, flushes = 0}, evo_rqmt = 8},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.mult_mod, math.max(0, self.config.evo_rqmt - card.ability.extra.flushes)}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dragon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- Count # of Flushes played
    if context.before and context.main_eval and context.scoring_name == 'Flush' then
      card.ability.extra.flushes = card.ability.extra.flushes + 1
      return
    end
    if context.individual and (context.cardarea == G.hand or context.cardarea == G.play) and not context.end_of_round then
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
}

-- Goodra 706
local goodra={
  name = "goodra",
  config = {extra = {Xmult_mod = 0.02}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult_mod}}
  end,
  designer = "Eternalnacho",
  rarity = "poke_safari",
  cost = 11,
  stage = "Two",
  ptype = "Dragon",
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
          context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.Xmult_mod * #unique_ranks
          return {
            extra = {message = localize('k_upgrade_ex'), colour = G.C.MULT},
            colour = G.C.MULT,
            card = card
          }
        end
      end
    end
  end,
}


list = {}
if nacho_config.Clauncher then list[#list+1] = clauncher end
if nacho_config.Clauncher then list[#list+1] = clawitzer end

if nacho_config.Dedenne then list[#list+1] = dedenne end
if nacho_config.Carbink then list[#list+1] = carbink end

if nacho_config.Goomy then list[#list+1] = goomy end
if nacho_config.Goomy then list[#list+1] = sliggoo end
if nacho_config.Goomy then list[#list+1] = goodra end

return {name = "nachopokemon6", list = list}


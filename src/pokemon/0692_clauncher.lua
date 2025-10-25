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

return {
  name = "Nacho's Clauncher Evo Line",
  enabled = nacho_config.Clauncher or false,
  list = { clauncher, clawitzer }
}

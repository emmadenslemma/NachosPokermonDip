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

return {
  name = "Nacho's Carbink",
  enabled = nacho_config.Carbink or false,
  list = { carbink }
}

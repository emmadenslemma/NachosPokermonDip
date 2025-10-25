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

return {
  name = "Nacho's Dedenne",
  enabled = nacho_config.Dedenne or false,
  list = { dedenne }
}

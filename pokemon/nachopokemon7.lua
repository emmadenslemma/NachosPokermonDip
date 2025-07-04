function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Turtonator 776
local turtonator={
  name = "turtonator",
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
  atlas = "Pokedex7",
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
}

list = {turtonator}
return {name = "nachopokemon7", list = list}

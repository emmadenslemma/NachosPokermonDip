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
  config = {extra = {Xmult_mod = 1.5, trapped = false, boss_blind = nil, boss_trigger = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local active = nil
    if card.ability.extra.trapped then active = "Active!"
    else active = "Inactive" end
    return {vars = {card.ability.extra.Xmult_mod, active}}
  end,
  designer = "Eternalnacho",
  rarity = 2,
  cost = 8,
  stage = "Basic",
  ptype = "Dragon",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and context.blind and context.blind.boss and not context.blueprint then
      card.ability.extra.boss_blind = context.blind.name
      local boss_name = card.ability.extra.boss_blind
      -- These boss blinds trigger only at the start
      -- The Wall, The Water, The Manacle, The Needle, Amber Acorn, Violet Vessel
      if (boss_name == "The Wall" or boss_name == "The Water" or boss_name == "The Manacle"
        or boss_name == "The Needle" or boss_name == "Amber Acorn" or boss_name == "Violet Vessel")
        and not G.GAME.blind.disabled then
          card.ability.extra.boss_trigger = true
          if boss_name == "The Needle" then
            card.ability.extra.trapped = true
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_shell_trap_ex')})
          end
      end
    end

    -- Scoring Bit Here
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

    -- Boss Blind Trigger Logic
    if card.ability.extra.boss_blind then
      local boss_name = card.ability.extra.boss_blind

      -- The Window, The Head, The Club, The Goad, The Plant, The Pillar, The Flint, The Eye, The Mouth, The Psychic, The Arm, The Ox, Verdant Leaf
      if context.debuffed_hand or context.joker_main then
        if G.GAME.blind.triggered then card.ability.extra.boss_trigger = true end
        
      -- The House
      elseif context.first_hand_drawn and boss_name == "The House" then
        card.ability.extra.boss_trigger = true

      -- The Serpent
      elseif (context.press_play or context.pre_discard) and boss_name == "The Serpent" and #G.hand.highlighted > 3 then
        card.ability.extra.boss_blind = "okserpent"

      -- The Hook, The Tooth, Crimson Heart, Cerulean Bell, Chartreuse Chamber (cgoose)
      elseif context.press_play then
        local jokdebuff = false
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i].debuff then
            jokdebuff = true
            break
          end
        end
        local forcedselection = false
        for k, v in pairs(G.hand.highlighted) do
          if v.ability.forced_selection or v.ability.pokermon_forced_selection then
            v.ability.pokermon_forced_selection = nil
            forcedselection = true
          end
        end
        if (boss_name == "The Hook" and (#G.hand.cards - #G.hand.highlighted) > 0) or
          boss_name == "The Tooth" or
          ((boss_name == "Crimson Heart" or boss_name == "bl_poke_cgoose") and jokdebuff) or
          (boss_name == "Cerulean Bell" and forcedselection) then
            card.ability.extra.boss_trigger = true
        end

      -- The Serpent (cont.), The Wheel, The Mark, The Fish
      elseif context.hand_drawn then
        local facedown = false
        for _, v in pairs(context.hand_drawn) do
          if v.facing == 'back' then
              facedown = true
          end
        end
        if boss_name == "okserpent" or
        ((boss_name == "The Wheel" or boss_name == "The Mark" or boss_name == "The Fish") and facedown) then
          card.ability.extra.boss_trigger = true
          -- first set the flag when hand is played or discarded, then
          -- only apply boss_trigger when the hand is drawn
          if boss_name == "okserpent" then card.ability.extra.boss_blind = "The Serpent" end
        end
      end

      -- Shell Trap on/off switch
      if (context.debuffed_hand or context.joker_main) and not card.ability.extra.trapped and card.ability.extra.boss_trigger then
        card.ability.extra.trapped = true
        if card.ability.extra.boss_trigger then card.ability.extra.boss_trigger = false end
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_shell_trap_ex')})
        return
      elseif (context.debuffed_hand or context.joker_main) and card.ability.extra.trapped then card.ability.extra.trapped = false end
    end
  end,
}

list = {}
if nacho_config.Turtonator then list[#list+1] = turtonator end

return {name = "nachopokemon7", list = list}

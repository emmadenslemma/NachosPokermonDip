-- Describe all the logic for debuffing or undebuffing

-- return values: true, false, or 'prevent_debuff'
SMODS.current_mod.set_debuff = function(card)  
   -- prevent debuffs
   if card.ability.name == "mega_gallade" then return 'prevent_debuff' end

   return false
end

-- calculate most played hand
calc_most_played_hand = function()
   local _hand, _tally = nil, 0
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible and G.GAME.hands[v].played >= _tally then
                _hand = v
                _tally = G.GAME.hands[v].played
            end
        end
   return _hand
end

-- salamence evo line conditions
deck_rank_evo = function(self, card, context, forced_key, rank, percentage, flat)
  if can_evolve(self, card, context, forced_key) then
    local high_count = 0
    for k, v in pairs(G.playing_cards) do
      if v.base.nominal >= rank then high_count = high_count + 1 end
    end
    if percentage and (high_count/#G.playing_cards >= percentage) then
      return {
        message = poke_evolve(card, forced_key)
      }
    elseif flat and (_count >= flat) then
      return {
        message = poke_evolve(card, forced_key)
      }
    end
  end
end

-- mega gallade card debuffing/un-debuffing function
local parse_highlighted = CardArea.parse_highlighted
CardArea.parse_highlighted = function(self)
  for _, card in ipairs(self.highlighted) do
    if card.debuff then card:set_debuff(false) end
  end
  local text, _, _ = G.FUNCS.get_poker_hand_info(self.highlighted)
  for _, card in ipairs(self.cards) do
    SMODS.recalc_debuff(card)
  end
  if text == calc_most_played_hand() and next(SMODS.find_card('j_nacho_mega_gallade')) then
    for _, card in ipairs(self.highlighted) do
      if card.debuff then card:set_debuff(false) end
    end
  end
  parse_highlighted(self)
end

-- Calculate Boss Triggers
calc_boss_trigger = function(context)
  if context.setting_blind and context.blind and context.blind.boss then
    local boss_name = context.blind.name
    G.GAME.blind.nametracker = context.blind.name
    -- These boss blinds trigger only at the start
    -- The Wall, The Water, The Manacle, The Needle, Amber Acorn, Violet Vessel
    if (boss_name == "The Wall" or boss_name == "The Water" or boss_name == "The Manacle"
      or boss_name == "The Needle" or boss_name == "Amber Acorn" or boss_name == "Violet Vessel")
      and not G.GAME.blind.disabled then
        return true
    end
  end

  if G.GAME.blind.nametracker then
    local boss_name = G.GAME.blind.nametracker
    -- The Window, The Head, The Club, The Goad, The Plant, The Pillar, The Flint, The Eye, The Mouth, The Psychic, The Arm, The Ox, Verdant Leaf
    if context.debuffed_hand or context.joker_main then
      if G.GAME.blind.triggered then
        return true
      end
      
    -- The House
    elseif context.first_hand_drawn and boss_name == "The House" then
      return true

    -- The Serpent
    elseif (context.press_play or context.pre_discard) and boss_name == "The Serpent" and #G.hand.highlighted > 3 then
      G.GAME.blind.serpentcheck = true

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
          return true
      end

    -- The Serpent (cont.), The Wheel, The Mark, The Fish
    elseif context.hand_drawn then
      local facedown = false
      for _, v in pairs(context.hand_drawn) do
        if v.facing == 'back' then
            facedown = true
        end
      end
      if (boss_name == "The Serpent" and G.GAME.blind.serpentcheck) or
      ((boss_name == "The Wheel" or boss_name == "The Mark" or boss_name == "The Fish") and facedown) then
        -- first set the flag when hand is played or discarded, then
        -- only apply boss_trigger when the hand is drawn
        if G.GAME.blind.serpentcheck then G.GAME.blind.serpentcheck = nil end
        return true
      end

    -- End of round, AKA cleaning up the mess
    elseif context.end_of_round then
      G.GAME.blind.nametracker = nil
    end
  end
end
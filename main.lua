--Load all Atlas
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
})

SMODS.Atlas({
    key = "stakes",
    px = 29,
    py = 29,
    path = "stakes.png"
}):register()

SMODS.Atlas({
    key = "stake_stickers",
    px = 71,
    py = 95,
    path = "stakes_stickers.png"
}):register()

SMODS.Atlas({
    key = "stickers",
    px = 71,
    py = 95,
    path = "stickers.png"
}):register()

pokermon.add_family({"ralts", "kirlia", "gardevoir", "mega_gardevoir", "gallade", "mega_gallade"})
pokermon.add_family({"turtwig", "grotle", "torterra"})
pokermon.add_family({"chimchar", "monferno", "infernape"})
pokermon.add_family({"piplup", "prinplup", "empoleon"})
pokermon.add_family({"goomy", "sliggoo", "goodra", "hisuian_sliggoo", "hisuian_goodra"})
pokermon.add_family({"skwovet", "greedent"})
pokermon.add_family({"galarian_meowth", "perrserker"})
pokermon.add_family({"hisuian_zorua", "hisuian_zoroark"})
pokermon.add_family({"terapagos", "terapagos_terastal", "terapagos_stellar"})


nacho_config = SMODS.current_mod.config
SMODS.current_mod.optional_features = { retrigger_joker = true, quantum_enhancements = true }
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

--Load Joker Display if the mod is enabled
if (SMODS.Mods["JokerDisplay"] or {}).can_load then
  local jokerdisplays = NFS.getDirectoryItems(mod_dir.."jokerdisplay")

  for _, file in ipairs(jokerdisplays) do
    sendDebugMessage ("The file is: "..file)
    local helper, load_error = SMODS.load_file("jokerdisplay/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      helper()
    end
  end
end

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
    --Load backs
    local backs = NFS.getDirectoryItems(mod_dir.."backs")
  
    for _, file in ipairs(backs) do
      sendDebugMessage ("The file is: "..file)
      local back, load_error = SMODS.load_file("backs/"..file)
      if load_error then
        sendDebugMessage ("The error is: "..load_error)
      else
        local curr_back = back()
        if curr_back.init then curr_back:init() end
        
        for i, item in ipairs(curr_back.list) do
          SMODS.Back(item)
        end
      end
    end
  end

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
    --Load stakes
    local stakes = NFS.getDirectoryItems(mod_dir.."stakes")
  
    for _, file in ipairs(stakes) do
      sendDebugMessage ("The file is: "..file)
      local stakes, load_error = SMODS.load_file("stakes/"..file)
      if load_error then
        sendDebugMessage ("The error is: "..load_error)
      else
        local curr_stake = stakes()
        if curr_stake.init then curr_stake:init() end
        
        for i, item in ipairs(curr_stake.list) do
          SMODS.Stake(item)
        end
      end
    end
  end

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
    --Load stickers
    local stickers = NFS.getDirectoryItems(mod_dir.."stickers")
  
    for _, file in ipairs(stickers) do
      sendDebugMessage ("The file is: "..file)
      local sticker, load_error = SMODS.load_file("stickers/"..file)
      if load_error then
        sendDebugMessage ("The error is: "..load_error)
      else
        local curr_sticker = sticker()
        if curr_sticker.init then curr_sticker:init() end
        
        for i, item in ipairs(curr_sticker.list) do
          item.hide_badge = true
          SMODS.Sticker(item)
        end
      end
    end
  end

local pconsumables = NFS.getDirectoryItems(mod_dir.."consumables")

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pconsumables) do
    sendDebugMessage ("The file is: "..file)
    local consumable, load_error = SMODS.load_file("consumables/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_consumable = consumable()
      if curr_consumable.init then curr_consumable:init() end
      
      for i, item in ipairs(curr_consumable.list) do
        if ((not pokermon_config.jokers_only and not item.pokeball) or (item.pokeball and pokermon_config.pokeballs)) or (item.evo_item and not pokermon_config.no_evos) then
          SMODS.Consumable(item)
        end
      end
    end
  end 
end

--Load vouchers
local vouchers = NFS.getDirectoryItems(mod_dir.."vouchers")

for _, file in ipairs(vouchers) do
  sendDebugMessage ("The file is: "..file)
  local voucher, load_error = SMODS.load_file("vouchers/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_voucher = voucher()
    if curr_voucher.init then curr_voucher:init() end
    
    for i, item in ipairs(curr_voucher.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Voucher(item)
    end
  end
end

-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

print("DEBUG")

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pfiles) do
    sendDebugMessage ("The file is: "..file)
    local pokemon, load_error = SMODS.load_file("pokemon/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_pokemon = pokemon()
      if curr_pokemon.init then curr_pokemon:init() end
      
      if curr_pokemon.list and #curr_pokemon.list > 0 then
        for i, item in ipairs(curr_pokemon.list) do
          if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only then
            if item.name ~= "terapagos_stellar" then
              pokermon.Pokemon(item, 'nacho', nil)
            else
              pokermon.load_pokemon(item)
            end
          end
        end
      end
    end
  end
end 

--Load Draw Logic file
local sprite, load_error = SMODS.load_file("functions/nacho_pokedraw.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end

--Load Animation file
local sprite, load_error = SMODS.load_file("functions/nacho_pokeanimations.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end


--Load Debuff logic
local sprite, load_error = SMODS.load_file("functions/functions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end

--Load Sleeves if able
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
  if (SMODS.Mods["CardSleeves"] or {}).can_load then
    local sleeves = NFS.getDirectoryItems(mod_dir.."sleeves")
    for _, file in ipairs(sleeves) do
      sendDebugMessage ("the file is: "..file)
      local sleeve, load_error = SMODS.load_file("sleeves/"..file)
      if load_error then
        sendDebugMessage("The error is: "..load_error)
      else
        local curr_sleeve = sleeve()
        if curr_sleeve.init then curr_sleeve.init() end
        
        for i,item in ipairs (curr_sleeve.list) do
          CardSleeves.Sleeve(item)
        end
      end
    end
  end
end

--Load challenges file
local pchallenges = NFS.getDirectoryItems(mod_dir.."challenges")

for _, file in ipairs(pchallenges) do
  local challenge, load_error = SMODS.load_file("challenges/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_challenge = challenge()
    if curr_challenge.init then curr_challenge:init() end
    
    for i, item in ipairs(curr_challenge.list) do
      SMODS.Challenge(item)
    end
  end
end 



-- Take ownership of ralts line if Maelmc mod found
if next(SMODS.find_mod("PokermonMaelmc")) then
  SMODS.Joker:take_ownership('maelmc_ralts', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	  aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end, 
		-- more on this later

    },
    true -- silent | suppresses mod badge
  )
  SMODS.Joker:take_ownership('maelmc_kirlia',
    { 
	  aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end, 
		

    },
    true 
  )
  SMODS.Joker:take_ownership('maelmc_gardevoir', 
    { 
	  aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,

    },
    true
  )
  SMODS.Joker:take_ownership('maelmc_mega_gardevoir',
    {
	  aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,

    },
    true
  )
  SMODS.Challenge:take_ownership('maelmc_ralts',
    {
	  jokers = {
        {id = "j_poke_sentret"},
        {id = "j_poke_natu"},
        {id = "j_nacho_ralts"},
        {id = "j_poke_elgyem"},
    },

    },
    true
  )
end
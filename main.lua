nacho_config = SMODS.current_mod.config
SMODS.current_mod.optional_features = { retrigger_joker = true, quantum_enhancements = true }
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

--Load atlases
assert(SMODS.load_file("src/atlases.lua"))()

-- Load functions
assert(SMODS.load_file("src/functions.lua"))()

--Load config tab setup file
assert(SMODS.load_file("src/settings.lua"))()

--Load stakes setup file
assert(SMODS.load_file("src/stakes.lua"))()

--Load stickers setup file
assert(SMODS.load_file("src/stickers.lua"))()

--Load pokemon setup file
assert(SMODS.load_file("src/pokemon.lua"))()

--Load challenges file
assert(SMODS.load_file("src/challenges.lua"))()


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

-- if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
--     --Load backs
--     local backs = NFS.getDirectoryItems(mod_dir.."backs")
  
--     for _, file in ipairs(backs) do
--       sendDebugMessage ("The file is: "..file)
--       local back, load_error = SMODS.load_file("backs/"..file)
--       if load_error then
--         sendDebugMessage ("The error is: "..load_error)
--       else
--         local curr_back = back()
--         if curr_back.init then curr_back:init() end
        
--         for i, item in ipairs(curr_back.list) do
--           SMODS.Back(item)
--         end
--       end
--     end
--   end


-- local pconsumables = NFS.getDirectoryItems(mod_dir.."consumables")

-- if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
--   for _, file in ipairs(pconsumables) do
--     sendDebugMessage ("The file is: "..file)
--     local consumable, load_error = SMODS.load_file("consumables/"..file)
--     if load_error then
--       sendDebugMessage ("The error is: "..load_error)
--     else
--       local curr_consumable = consumable()
--       if curr_consumable.init then curr_consumable:init() end
      
--       for i, item in ipairs(curr_consumable.list) do
--         if ((not pokermon_config.jokers_only and not item.pokeball) or (item.pokeball and pokermon_config.pokeballs)) or (item.evo_item and not pokermon_config.no_evos) then
--           SMODS.Consumable(item)
--         end
--       end
--     end
--   end
-- end

-- --Load vouchers
-- local vouchers = NFS.getDirectoryItems(mod_dir.."vouchers")

-- for _, file in ipairs(vouchers) do
--   sendDebugMessage ("The file is: "..file)
--   local voucher, load_error = SMODS.load_file("vouchers/"..file)
--   if load_error then
--     sendDebugMessage ("The error is: "..load_error)
--   else
--     local curr_voucher = voucher()
--     if curr_voucher.init then curr_voucher:init() end
    
--     for i, item in ipairs(curr_voucher.list) do
--       item.discovered = not pokermon_config.pokemon_discovery
--       SMODS.Voucher(item)
--     end
--   end
-- end

-- --Load Sleeves if able
-- if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
--   if (SMODS.Mods["CardSleeves"] or {}).can_load then
--     local sleeves = NFS.getDirectoryItems(mod_dir.."sleeves")
--     for _, file in ipairs(sleeves) do
--       sendDebugMessage ("the file is: "..file)
--       local sleeve, load_error = SMODS.load_file("sleeves/"..file)
--       if load_error then
--         sendDebugMessage("The error is: "..load_error)
--       else
--         local curr_sleeve = sleeve()
--         if curr_sleeve.init then curr_sleeve.init() end
        
--         for i,item in ipairs (curr_sleeve.list) do
--           CardSleeves.Sleeve(item)
--         end
--       end
--     end
--   end
-- end
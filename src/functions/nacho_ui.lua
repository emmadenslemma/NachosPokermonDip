-- Placing the loaded jokers in dex order
local sinnoh_starters = {'turtwig', 'grotle', 'torterra', 'chimchar', 'monferno', 'infernape', 'piplup', 'prinplup', 'empoleon'}

PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'galarian_meowth'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'swablu', 'altaria', 'mega_altaria'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'ralts', 'kirlia', 'gardevoir', 'mega_gardevoir'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'bagon', 'shelgon', 'salamence', 'mega_salamence'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = sinnoh_starters
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'gallade', 'mega_gallade'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'hisuian_zorua', 'hisuian_zoroark'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'clauncher', 'clawitzer'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'dedenne', 'carbink', 'goomy', 'sliggoo', 'goodra', 'hisuian_sliggoo', 'hisuian_goodra'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'oranguru', 'passimian'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'turtonator'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'skwovet', 'greedent'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'perrserker'}
PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = {'terapagos', 'terapagos_terastal', 'terapagos_stellar'}


-- modifying this function for *two* different config settings
SMODS.collection_pool = function(_base_pool)
  local pool = {}
  if type(_base_pool) ~= 'table' then return pool end
  local is_array = _base_pool[1]
  local ipairs = is_array and ipairs or pairs
  for _, v in ipairs(_base_pool) do
    local moved = false
    if (not G.ACTIVE_MOD_UI or v.mod == G.ACTIVE_MOD_UI) and not v.no_collection then

      if nacho_config.orderJokers then
        for x, y in pairs(PkmnDip.dex_order_groups) do
          if table.contains(y, v.name) then
            local next_index = PkmnDip.dex_order[PkmnDip.find_next_dex_number(v.name)]
            if type(next_index) == "table" then next_index = next_index[1] end
            table.insert(pool, next_index and PkmnDip.find_pool_index(pool, 'j_poke_'..next_index) or #pool + 1, v)
            moved = true
          end
        end
      end
      local empty_vanilla = v.set == 'Joker' and not v.stage and nacho_config.pokemon_only

      if not moved and not empty_vanilla then pool[#pool+1] = v end
    end
  end
  if not is_array then table.sort(pool, function(a,b) return a.order < b.order end) end
  return pool
end

PkmnDip.find_pool_index = function(pool, key)
    for k, v in pairs(pool) do
      if v.key == key then return k end
    end
end

PkmnDip.get_dex_number = function(name)
  for i, pokemon in ipairs(PkmnDip.dex_order) do
    if type(pokemon) == 'table' then
      for x, y in ipairs(pokemon) do
        if name == y then return i + (x - 1)/10 end
      end
    elseif type(pokemon) == "string" and name == pokemon then return i end
  end
end

PkmnDip.find_next_dex_number = function(name)
  local dexNo = PkmnDip.get_dex_number(name)
  local group_list
  for k, v in pairs(PkmnDip.dex_order_groups) do
    if table.contains(v, name) then group_list = v break end
  end
  for i, pokemon in ipairs(PkmnDip.dex_order) do
    if type(pokemon) == 'table' then
      for _, mon in ipairs(pokemon) do
        if i > dexNo and not table.contains(group_list, mon) and G.P_CENTERS['j_poke_'..mon] then
          --for k, v in pairs(poke_get_family_list(mon)) do if string.find(name, v) then goto continue end end
          return i
        end
      end
    elseif i > dexNo and not table.contains(group_list, pokemon) and G.P_CENTERS['j_poke_'..pokemon] then
      --for k, v in pairs(poke_get_family_list(mon)) do if string.find(name, v) then goto continue end end
      return i
    elseif pokemon == "missingno" then return i end
    --::continue::
  end
end


-- Wide Gallery Settings
local joker_collection_box = create_UIBox_your_collection_jokers
if nacho_config.gallery_width then
  create_UIBox_your_collection_jokers = function()
    local w = nacho_config.gallery_width * 10 % 10 < 5 and math.floor(nacho_config.gallery_width) or math.ceil(nacho_config.gallery_width)
    return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Joker, {w,w,w}, {
        no_materialize = true, 
        modify_card = function(card, center) card.sticker = get_joker_win_sticker(center) end,
        h_mod = 0.95,
    })
  end
else
  create_UIBox_your_collection_jokers = joker_collection_box
end

-- Take out vanilla jokers from collection maybe?


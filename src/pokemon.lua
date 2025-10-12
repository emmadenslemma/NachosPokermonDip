-- Name relevant sprite locations and add families

PokemonSprites["mega_gardevoir"] = {base = {pos = {x = 6, y = 4}, soul_pos = {x = 7, y = 4}}, gen_atlas = true}
PokemonSprites["mega_salamence"] = {base = {pos = {x = 8, y = 6}, soul_pos = {x = 9, y = 6}}, gen_atlas = true}
PokemonSprites["mega_gallade"] = {base = {pos = {x = 0, y = 7}, soul_pos = {x = 1, y = 7}}, gen_atlas = true}
PokemonSprites["galarian_meowth"] = {base = {pos = {x = 8, y = 4}}, gen_atlas = true}
PokemonSprites["hisuian_zorua"] = {base = {pos = {x = 0, y = 9}, soul_pos = {x = 99, y = 99}}, gen_atlas = true}
PokemonSprites["hisuian_zoroark"] = {base = {pos = {x = 2, y = 9}, soul_pos = {x = 99, y = 99}}, gen_atlas = true}
PokemonSprites["hisuian_sliggoo"] = {base = {pos = {x = 0, y = 12}}, gen_atlas = true}
PokemonSprites["hisuian_goodra"] = {base = {pos = {x = 2, y = 12}}, gen_atlas = true}
PokemonSprites["terapagos"] = {base = {pos = {x = 0, y = 6}, soul_pos = {x = 1, y = 6}}, gen_atlas = true}
PokemonSprites["terapagos_terastal"] = {base = {pos = {x = 2, y = 6}, soul_pos = {x = 3, y = 6}}, gen_atlas = true}

pokermon.add_family({"ralts", "kirlia", "gardevoir", "mega_gardevoir", "gallade", "mega_gallade"})
pokermon.add_family({"bagon", "shelgon", "salamence", "mega_salamence"})
pokermon.add_family({"turtwig", "grotle", "torterra"})
pokermon.add_family({"chimchar", "monferno", "infernape"})
pokermon.add_family({"piplup", "prinplup", "empoleon"})
pokermon.add_family({"goomy", "sliggoo", "goodra", "hisuian_sliggoo", "hisuian_goodra"})
pokermon.add_family({"skwovet", "greedent"})
pokermon.add_family({"galarian_meowth", "perrserker"})
pokermon.add_family({"hisuian_zorua", "hisuian_zoroark"})
pokermon.add_family({"terapagos", "terapagos_terastal", "terapagos_stellar"})

-- load pokemon folder

local subdir = "src/pokemon/"

local function load_pokemon_folder(folder)
    local pfiles = NFS.getDirectoryItems(mod_dir..folder)
    if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
        for _, file in ipairs(pfiles) do
            sendDebugMessage ("The file is: "..file)
            local pokemon, load_error = SMODS.load_file(folder..file)
            if load_error then
                sendDebugMessage ("The error is: "..load_error)
            else
                local curr_pokemon = pokemon()
                if curr_pokemon.init then curr_pokemon:init() end
                if curr_pokemon.list and #curr_pokemon.list > 0 then
                    for i, item in ipairs(curr_pokemon.list) do
                        if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only then
                            item.discovered = true
                            if not item.key then
                                item.key = item.name
                            end
                            if not pokermon_config.no_evos and not item.custom_pool_func then
                                item.in_pool = function(self)
                                    return pokemon_in_pool(self)
                                end
                            end
                            if not item.config then
                                item.config = {}
                            end
                            if not item.pos then
                                local sprite = PokemonSprites[item.name]
                                if sprite and sprite.base then
                                    item.pos = sprite.base.pos
                                end
                                if sprite.base.soul_pos then 
                                    item.soul_pos = sprite.base.soul_pos
                                end
                            end
                            if not item.atlas then
                                local sprite = PokemonSprites[item.name]
                                local gen_string = nil
                                local atlas_prefix = nil
                                if not item.custom_art then
                                    atlas_prefix = "AtlasJokersBasic"
                                else 
                                    atlas_prefix = "AtlasJokersSeriesA"
                                end
                                if sprite.gen_atlas and item.gen then
                                    if item.gen < 10 then
                                    gen_string = 'Gen0'..item.gen 
                                    else
                                    gen_string = 'Gen'..item.gen
                                    end
                                    item.atlas = atlas_prefix..gen_string
                                else
                                    item.atlas = atlas_prefix.."Natdex"
                                end
                            end
                            if item.ptype then
                                if item.config and item.config.extra then
                                    item.config.extra.ptype = item.ptype
                                elseif item.config then
                                    item.config.extra = {ptype = item.ptype}
                                end
                            end
                            if not item.set_badges then
                                item.set_badges = poke_set_type_badge
                            end
                            if item.item_req then
                                if item.config and item.config.extra then
                                    item.config.extra.item_req = item.item_req
                                elseif item.config then
                                    item.config.extra = {item_req = item.item_req}
                                end
                            end
                            if item.evo_list then
                                if item.config and item.config.extra then
                                    item.config.extra.evo_list = item.evo_list
                                elseif item.config then
                                    item.config.extra = {item_req = item.evo_list}
                                end
                            end
                            if pokermon_config.jokers_only and item.rarity == "poke_safari" then
                                item.rarity = 3
                            end
                            item.discovered = not pokermon_config.pokemon_discovery 
                            if item.name ~= "terapagos_stellar" then
                                pokermon.Pokemon(item, 'nacho', nil)
                            else
                                pokermon.Pokemon(item, 'nacho', true)
                            end
                        end
                    end
                end
            end
        end
    end
end

load_pokemon_folder(subdir)

-- Take ownership of ralts line if Maelmc mod found and Ralts config enabled
if next(SMODS.find_mod("PokermonMaelmc")) and nacho_config.Ralts then
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
end
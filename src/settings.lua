-- Config Tab UI

SMODS.current_mod.config_tab = function()
    return {
      n = G.UIT.ROOT,
      config = {
          align = "cm",
          padding = 0.05,
          colour = G.C.CLEAR,
      },
      nodes = {
        {
          n = G.UIT.R,
          config = {
              align = "tm",
              padding = 0.05,
              colour = G.C.CLEAR,
          },
          nodes =
          {
            {
              n = G.UIT.C,
              config = {
                  align = "tl",
                  padding = 0.05,
                  colour = G.C.CLEAR,
              },
              nodes =
              {
                create_toggle({
                  label = localize("ralts_line"),
                  ref_table = nacho_config,
                  ref_value = "Ralts",
                }),
                create_toggle({
                    label = localize("bagon_line"),
                    ref_table = nacho_config,
                    ref_value = "Bagon",
                }),
                create_toggle({
                    label = localize("turtwig_line"),
                    ref_table = nacho_config,
                    ref_value = "Turtwig",
                }),
                create_toggle({
                    label = localize("chimchar_line"),
                    ref_table = nacho_config,
                    ref_value = "Chimchar",
                }),
                create_toggle({
                label = localize("piplup_line"),
                ref_table = nacho_config,
                ref_value = "Piplup",
                }),
                create_toggle({
                    label = localize("dedenne"),
                    ref_table = nacho_config,
                    ref_value = "Dedenne",
                }),
                create_toggle({
                    label = localize("carbink"),
                    ref_table = nacho_config,
                    ref_value = "Carbink",
                }),
              }
            },
            {
              n = G.UIT.C,
              config = {
                  align = "tr",
                  padding = 0.05,
                  colour = G.C.CLEAR,
              },
              nodes =
              {
                create_toggle({
                    label = localize("goomy_line"),
                    ref_table = nacho_config,
                    ref_value = "Goomy",
                }),
                create_toggle({
                    label = localize("turtonator"),
                    ref_table = nacho_config,
                    ref_value = "Turtonator",
                }),
                create_toggle({
                    label = localize("skwovet_line"),
                    ref_table = nacho_config,
                    ref_value = "Skwovet",
                }),
                create_toggle({
                    label = localize("galarian_meowth_line"),
                    ref_table = nacho_config,
                    ref_value = "Galarian_Meowth",
                }),
                create_toggle({
                    label = localize("hisuian_zorua_line"),
                    ref_table = nacho_config,
                    ref_value = "Hisuian_Zorua",
                }),
                create_toggle({
                    label = localize("terapagos_line"),
                    ref_table = nacho_config,
                    ref_value = "Terapagos",
                }),
              }
            },
          }
        },
        {
          n = G.UIT.R,
          config = {
              align = "bm",
              padding = 0.05,
              colour = G.C.CLEAR,
          },
          nodes =
          {
            create_toggle({
                label = localize("custom_jokers"),
                ref_table = nacho_config,
                ref_value = "customJokers",
            }),
            create_toggle({
                label = "Allow Custom Stakes?",
                ref_table = nacho_config,
                ref_value = "customStakes",
            }),
          }
        }
      },
    }
end
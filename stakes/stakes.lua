local elite = { -- Elite Stake
    key = 'elite_stake',
    applied_stakes = {'gold'},
    above_stake = 'gold',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},

    modifiers = function()
        if next(SMODS.find_mod("SonfivesPokermonPlus")) and G.GAME.selected_back.effect.center.key == "b_sonfive_megadeck" then
            G.GAME.modifiers.elite4 = true
        else
            G.GAME.win_ante = (G.GAME.win_ante + 2)
            G.GAME.modifiers.elite4 = true
        end
    end,

    pos = {x = 0, y = 0},
    sticker_pos = {x = 0, y = 0},
    atlas = 'stakes',
    sticker_atlas = 'stake_stickers',
    shiny = true
}



return {name = "Stakes",
      list = {elite}
}
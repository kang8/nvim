-- Copy from https://github.com/catppuccin/nvim/blob/5b5e3aef9ad7af84f463d17b5479f06b87d5c429/lua/reactive/presets/catppuccin-latte-cursorline.lua
local lighten = require('catppuccin.utils.colors').lighten
local palette = require('catppuccin.palettes').get_palette('latte')

return {
  name = 'catppuccin-latte-cursorline-custoimze',
  static = {
    winhl = {
      inactive = {
        CursorLine = { bg = lighten(palette.surface0, 0.5) },
        CursorLineNr = { bg = lighten(palette.surface0, 0.5) },
      },
    },
  },
  modes = {
    i = {
      winhl = {
        CursorLine = { bg = lighten(palette.teal, 0.4) },
        CursorLineNr = { bg = lighten(palette.teal, 0.4) },
      },
    },
    no = {
      operators = {
        [{ 'gu', 'gU', 'g~', '~' }] = {
          winhl = {
            CursorLine = { bg = palette.surface2 },
            CursorLineNr = { bg = palette.surface2 },
          },
        },
        -- delete operator
        d = {
          winhl = {
            CursorLine = { bg = lighten(palette.red, 0.3) },
            CursorLineNr = { bg = lighten(palette.red, 0.3) },
          },
        },
        -- yank operator
        y = {
          winhl = {
            CursorLine = { bg = lighten(palette.peach, 0.3) },
            CursorLineNr = { bg = lighten(palette.peach, 0.3) },
          },
        },
        -- change operator
        c = {
          winhl = {
            CursorLine = { bg = lighten(palette.blue, 0.3) },
            CursorLineNr = { bg = lighten(palette.blue, 0.3) },
          },
        },
      },
    },
    -- visual
    [{ 'v', 'V', '\x16' }] = {
      winhl = {
        Visual = { bg = lighten(palette.mauve, 0.3) },
      },
    },
    -- select
    [{ 's', 'S', '\x13' }] = {
      winhl = {
        Visual = { bg = lighten(palette.pink, 0.3) },
      },
    },
    R = {
      winhl = {
        CursorLine = { bg = lighten(palette.flamingo, 0.2) },
        CursorLineNr = { bg = lighten(palette.flamingo, 0.2) },
      },
    },
  },
}

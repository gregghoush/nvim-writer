return {
  "loctvl842/monokai-pro.nvim",
  name = "monokai-pro",
  lazy = false,
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
      -- Enable this will disable filter option
      day_night = {
        enable = false, -- turn off by default
        day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
        night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
      },
      inc_search = "background", -- underline | background
      background_clear = {
        -- "float_win",
        "toggleterm",
        "telescope",
        -- "which-key",
        "renamer",
        "notify",
        -- "nvim-tree",
        -- "neo-tree",
        -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
      }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
      override = function(c)
        local hp = require("monokai-pro.color_helper")
        local common_fg = hp.lighten(c.sideBar.foreground, 30)
        return {
          SnacksPicker = { bg = c.editor.background, fg = common_fg },
          SnacksPickerBorder = { bg = c.editor.background, fg = c.tab.unfocusedActiveBorder },
          SnacksPickerTree = { fg = c.editorLineNumber.foreground },
          NonText = { fg = c.base.dimmed2 }, -- not sure if this should be broken into all hl groups importing NonText
          -- SnacksPickerDirectory = { fg = c.editorLineNumber.foreground },
          SnacksPickerDirectory = { fg = common_fg },
        }
      end,
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = "default", -- default | pro
          context_start_underline = false,
        },
      },
    })
    vim.cmd.colorscheme("monokai-pro")
  end,
}

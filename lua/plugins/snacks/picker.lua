local git = require("utils.git")
local picker_utils = require("utils.snacks.picker")

return {
  "snacks.nvim",
  opts = {
    picker = {
      layout = {
        -- preset => "default", "dropdown", "ivy", "select", "telescope", "vertical", "vscode"
        preset = function()
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-f>"] = false,
            ["<c-b>"] = false,
            ["<c-h>"] = { "toggle_help", mode = { "n", "i" } },
            ["?"] = false,
          },
        },
        list = {
          keys = {
            ["<c-d>"] = "preview_scroll_down",
            ["<c-u>"] = "preview_scroll_up",
            ["<c-f>"] = false,
            ["<c-b>"] = false,
          },
        },
      },
      sources = {
        files = {
          actions = {
            switch_grep_files = function(picker, _)
              picker_utils.status = {
                is_grep = false,
                is_git = false,
              }
              picker_utils.switch_grep_files(picker, _)
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-\\>"] = { "switch_grep_files", desc = "Switch to grep", mode = { "i", "v" } },
              },
            },
          },
        },
        git_files = {
          actions = {
            switch_grep_files = function(picker, _)
              picker_utils.status = {
                is_grep = false,
                is_git = true,
              }
              picker_utils.switch_grep_files(picker, _)
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-\\>"] = { "switch_grep_files", desc = "Switch to grep", mode = { "i", "v" } },
              },
            },
          },
        },
        grep = {
          actions = {
            switch_grep_files = function(picker, _)
              picker_utils.status = {
                is_grep = true,
                is_git = git.is_git_repo(),
              }
              picker_utils.switch_grep_files(picker, _)
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-\\>"] = { "switch_grep_files", desc = "Switch to files", mode = { "i", "v" } },
              },
            },
          },
        },
      },
    },
  },
}

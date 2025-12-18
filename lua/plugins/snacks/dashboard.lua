local git = require("utils.git")

return {
  "snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "n", desc = " New file", action = "<CMD>ene | startinsert<CR>" },
          {
            icon = " ",
            key = "<backspace>",
            desc = " Restore last session",
            action = function()
              local session = require("mini.sessions")
              local latest_session_name = session.get_latest()
              session.read(latest_session_name)
              vim.notify("Session read: " .. latest_session_name, vim.log.levels.INFO)
            end,
          },
          {
            icon = " ",
            key = "<leader>ff",
            desc = " Find files",
            action = function()
              local Snacks = require("snacks")
              Snacks.dashboard.pick("files")
            end,
          },
          {
            icon = " ",
            key = "<leader>fg",
            desc = " Grep text",
            action = function()
              require("telescope.builtin").live_grep({ cwd = git.get_workspace_root() })
            end,
          },
          {
            icon = " ",
            key = "<leader>fr",
            desc = " Recent files",
            action = function()
              local Snacks = require("snacks")
              Snacks.dashboard.pick("recent")
            end,
          },
          {
            icon = " ",
            key = "<leader>cc",
            desc = " Config",
            action = function()
              local Snacks = require("snacks")
              Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })
            end,
          },
          { icon = "✓ ", key = "<leader>,", desc = " Mason", action = "<CMD>Mason<CR>" },
          { icon = "󰒲 ", key = "<leader>.", desc = " Lazy", action = "<CMD>Lazy sync<CR>" },
          { icon = " ", key = "q", desc = " Quit", action = "<CMD>qa<CR>" },
        },
        header = require("utils.ui").get_dashboard_header(vim.g.dashboard_header),
      },
      sections = {
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        -- { section = "header", pane = 2 },
        -- { section = "startup" },
      },
    },
  },
}

---@diagnostic disable: redundant-parameter
-- Simplified Plugin Management Tests
local test = require("tests.run_tests")

test.describe("Plugin Management (Critical Writing Plugins)", function()
  test.it("should check for critical writing plugin files", function()
    local config_path = os.getenv("NVIM_CONFIG_PATH") or vim.fn.expand("~/.config/nvim-writer")

    -- Critical writing plugins
    local critical_plugins = {
      "lua/plugins/iwe.lua",
      "lua/plugins/neowiki.lua",
      "lua/plugins/pencil.lua",
      "lua/plugins/markdown.lua",
      "lua/plugins/treesitter.lua",
      "lua/plugins/telescope.lua",
      "lua/plugins/lualine.lua",
      "lua/plugins/which-key.lua",
      "lua/plugins/auto-save.lua",
      "lua/plugins/formatter.lua",
      "lua/plugins/linter.lua",
    }

    local missing_plugins = {}
    for _, plugin_path in ipairs(critical_plugins) do
      local full_path = config_path .. "/" .. plugin_path
      local file = io.open(full_path, "r")
      if file then
        file:close()
      else
        table.insert(missing_plugins, plugin_path)
      end
    end

    if #missing_plugins > 0 then
      print("Missing critical writing plugins:")
      for _, p in ipairs(missing_plugins) do
        print("  " .. p)
      end
      test.expect(false).to_be_truthy("Critical writing plugins missing")
    else
      test.expect(true).to_be_truthy("All critical writing plugins present")
    end
  end)

  test.it("should have plugins directory structure", function()
    local config_path = os.getenv("NVIM_CONFIG_PATH") or vim.fn.expand("~/.config/nvim-writer")
    local plugins_dir = config_path .. "/lua/plugins"
    local snacks_dir = config_path .. "/lua/plugins/snacks"

    local plugins_exists = vim.fn.isdirectory(plugins_dir) == 1
    local snacks_exists = vim.fn.isdirectory(snacks_dir) == 1

    if plugins_exists and snacks_exists then
      test.expect(true).to_be_truthy("Plugin directories exist")
    else
      print("Plugins dir: " .. tostring(plugins_exists))
      print("Snacks dir: " .. tostring(snacks_exists))
      test.expect(false).to_be_truthy("Plugin directory structure incomplete")
    end
  end)
end)

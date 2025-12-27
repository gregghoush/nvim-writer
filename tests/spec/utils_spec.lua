---@diagnostic disable: redundant-parameter, param-type-mismatch
-- Utility Modules Tests
local test = require("tests.run_tests")

test.describe("Utility Modules", function()
  -- Test utils.common module (CRITICAL for writing workflows)
  test.it("should have utils.common module with writing functions", function()
    -- First check if file exists
    local common_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/utils/common.lua"), "r")
    if common_file then
      common_file:close()
      test.expect(true).to_be_truthy("utils.common module exists")
    else
      test.expect(false).to_be_truthy("utils.common module not found")
    end
  end)

  -- Test utils.notes module (book/notes management)
  test.it("should have utils.notes module for note management", function()
    local notes_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/utils/notes.lua"), "r")
    if notes_file then
      notes_file:close()
      test.expect(true).to_be_truthy("utils.notes module exists")
    else
      test.expect(false).to_be_truthy("utils.notes module not found")
    end
  end)

  -- Test utils.neowiki plugin (wiki system - it's a plugin, not utility)
  test.it("should have neowiki plugin for wiki management", function()
    local neowiki_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/neowiki.lua"), "r")
    if neowiki_file then
      neowiki_file:close()
      test.expect(true).to_be_truthy("neowiki plugin exists")
    else
      test.expect(false).to_be_truthy("neowiki plugin not found")
    end
  end)

  -- Test utils.git module (git utilities)
  test.it("should have utils.git module for git operations", function()
    local git_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/utils/git.lua"), "r")
    if git_file then
      git_file:close()
      test.expect(true).to_be_truthy("utils.git module exists")
    else
      test.expect(false).to_be_truthy("utils.git module not found")
    end
  end)

  -- Test utils.keymap module
  test.it("should have utils.keymap module for keybinding utilities", function()
    local keymap_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/utils/keymap.lua"), "r")
    if keymap_file then
      keymap_file:close()
      test.expect(true).to_be_truthy("utils.keymap module exists")
    else
      test.expect(false).to_be_truthy("utils.keymap module not found")
    end
  end)
end)

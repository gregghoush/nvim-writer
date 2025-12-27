---@diagnostic disable: redundant-parameter
-- Writing-Specific Tests
local test = require("tests.run_tests")

test.describe("Writing Features", function()
  -- Test book management plugin
  test.it("should have iwe plugin configured", function()
    local iwe_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/iwe.lua"), "r")
    if iwe_file then
      iwe_file:close()
      test.expect(true).to_be_truthy("iwe.lua plugin exists for book management")
    else
      test.expect(false).to_be_truthy("iwe.lua plugin not found - book management may not work")
    end
  end)

  -- Test wiki system plugin
  test.it("should have neowiki plugin configured", function()
    local neowiki_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/neowiki.lua"), "r")
    if neowiki_file then
      neowiki_file:close()
      test.expect(true).to_be_truthy("neowiki.lua plugin exists for wiki system")
    else
      test.expect(false).to_be_truthy("neowiki.lua plugin not found - wiki may not work")
    end
  end)

  -- Test prose editing plugin
  test.it("should have pencil plugin configured", function()
    local pencil_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/pencil.lua"), "r")
    if pencil_file then
      pencil_file:close()
      test.expect(true).to_be_truthy("pencil.lua plugin exists for prose editing")
    else
      test.expect(false).to_be_truthy("pencil.lua plugin not found - prose editing may not work")
    end
  end)

  -- Test markdown support plugin
  test.it("should have markdown plugin configured", function()
    local markdown_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/markdown.lua"), "r")
    if markdown_file then
      markdown_file:close()
      test.expect(true).to_be_truthy("markdown.lua plugin exists for markdown support")
    else
      test.expect(false).to_be_truthy("markdown.lua plugin not found - markdown may not work")
    end
  end)

  -- Test auto-save plugin (critical for writing)
  test.it("should have auto-save plugin configured", function()
    local autosave_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/auto-save.lua"), "r")
    if autosave_file then
      autosave_file:close()
      test.expect(true).to_be_truthy("auto-save.lua plugin exists for writing safety")
    else
      test.expect(false).to_be_truthy("auto-save.lua plugin not found - writing safety at risk")
    end
  end)

  -- Test writing-specific UI plugins
  test.it("should have md-headers and md-list plugins", function()
    local md_headers_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/md-headers.lua"), "r")
    local md_list_file = io.open(vim.fn.expand("~/.config/nvim-writer/lua/plugins/md-list.lua"), "r")

    local md_headers_exists = md_headers_file ~= nil
    local md_list_exists = md_list_file ~= nil

    if md_headers_file then
      md_headers_file:close()
    end
    if md_list_file then
      md_list_file:close()
    end

    -- At least one should exist
    test.expect(md_headers_exists or md_list_exists).to_be_truthy("Markdown helper plugins configured")
  end)
end)

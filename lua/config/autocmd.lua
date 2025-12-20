------------------------------------
-- UNDOFILE ON GIT REPOSITORY ONLY
------------------------------------
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function()
    vim.o.undofile = require("utils.git").is_git_repo()
  end,
})

------------------------------------
-- Fix .md.md file problems.
------------------------------------
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md.md" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(buf)
    -- vim.notify(".md.md file open caught: \n" .. filename, vim.log.levels.ERROR)
    local newfile = string.gsub(filename, "%.md.md$", ".md")
    vim.cmd("edit " .. newfile)
    vim.bo.filetype = "markdown"
    vim.cmd("SoftPencil")
  end,
})

------------------------------------
-- make softpencil default on markdown files.
------------------------------------
vim.api.nvim_create_augroup("Pencil", {})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    require("preservim/vim-pencil").init()
    vim.g.pencil_wrap_mode_default = "soft"
  end,
  group = "Pencil",
})

------------------------------------
-- HIGHLIGHT ON YANK
------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

------------------------------------
-- DEPENDENCIES
------------------------------------
require("utils.dependencies").missing_dependencies_notification()

------------------------------------
-- MAINTENANCE
------------------------------------
-- Setup automatic maintenance for Neovim with user commands
require("utils.maintenance").setup()

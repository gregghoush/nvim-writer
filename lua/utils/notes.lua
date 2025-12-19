local M = {}
local common = require("utils.common")
local notes_dir = common.get_iwe_root() .. "/notes/"

function M.select_note()
  vim.cmd("!mkdir -p " .. notes_dir)
  require("telescope.builtin").find_files({ cwd = notes_dir })
end

function M.new_note()
  local new_file = common.get_markdown_filename()
  vim.cmd("edit " .. notes_dir .. "/" .. new_file)
  vim.cmd(":write ++p")
end

return M

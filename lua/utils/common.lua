local M = {}

-- Define common configuration values and utilities
-- Note: We don't define ignored_filetypes here anymore.
-- Use vim.g.ignore_filetypes from config/options.lua instead.

function M.get_iwe_root()
  local project_marker = { ".iwe" }

  local project_root = vim.fs.root(0, project_marker)
  return project_root
end

return M

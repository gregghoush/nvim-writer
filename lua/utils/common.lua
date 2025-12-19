local M = {}

-- Define common configuration values and utilities
-- Note: We don't define ignored_filetypes here anymore.
-- Use vim.g.ignore_filetypes from config/options.lua instead.

function M.get_iwe_root()
  local project_marker = { ".iwe" }

  local project_root = vim.fs.root(0, project_marker)
  return project_root
end

function M.is_empty(s)
  return s == nil or s == ""
end

function M.get_markdown_filename()
  local file_name = vim.fn.input("Name: ")

  if M.is_empty(file_name) then
    vim.notify("Name can't be empty.", vim.log.levels.ERROR)
    return nil
  end

  file_name = file_name:gsub(" ", "_")

  if not string.match(file_name, "%.%.%w+$") then
    file_name = file_name .. ".md" -- Add .txt extension if none found
  end

  return string.lower(file_name)
end

return M

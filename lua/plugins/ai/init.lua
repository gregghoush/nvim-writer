if not vim.g.ai then
  return {}
end

local plugins = {}

if vim.g.ai == "copilot" then
  table.insert(plugins, require("plugins.ai.copilot"))
end

return plugins

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

function M.get_notes_root()
  return M.get_iwe_root() .. "/notes"
end

function M.get_books_root()
  return M.get_iwe_root() .. "/books"
end

function M.get_book_1_root()
  return M.get_books_root() .. "/book_1_the_first_awakening"
end

function M.get_book_2_root()
  return M.get_books_root() .. "/book_2_the_price_of_leadership"
end

function M.get_book_3_root()
  return M.get_books_root() .. "/book_3_the_vanguard_trial"
end

function M.get_book_4_root()
  return M.get_books_root() .. "/book_4_the_claiming"
end

function M.get_book_5_root()
  return M.get_books_root() .. "/book_5_the_iron_siege"
end

function M.get_book_6_root()
  return M.get_books_root() .. "/book_6_city_of_dawn"
end

function M.get_book_7_root()
  return M.get_books_root() .. "/book_7_the_reckoning"
end

function M.get_book_8_root()
  return M.get_books_root() .. "/book_8_echoes_of_the_fallen"
end

function M.get_book_9_root()
  return M.get_books_root() .. "/book_9_humanitys_ascent"
end

function M.get_lore_root()
  return M.get_iwe_root() .. "/lore"
end

function M.get_lore_character_root()
  return M.get_lore_root() .. "/characters"
end

function M.get_lore_spell_root()
  return M.get_lore_root() .. "/spells"
end

function M.get_lore_ability_root()
  return M.get_lore_root() .. "/abilities"
end

function M.get_lore_location_root()
  return M.get_lore_root() .. "/locations"
end

function M.get_lore_organization_root()
  return M.get_lore_root() .. "/organizations"
end

function M.get_lore_rule_root()
  return M.get_lore_root() .. "/rules"
end

function M.get_book_root(book)
  return M.get_iwe_root() .. "/book_" .. book
end

return M

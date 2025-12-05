return {
  "preservim/vim-pencil",
  config = function()
    vim.g["pencil#autoformat"] = 1
    vim.g["pencil#textwidth"] = 80
    vim.g["pencil#wrapModeDefault"] = "soft"
    vim.fn["pencil#init"]({ wrap = "soft", autoformat = 1 })
  end,
  ft = {
    "mkd",
    "markdown",
    "tex",
    "latex",
    "text",
    "txt"
  },
}


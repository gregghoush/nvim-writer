-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        markdown = { "prettier" },
        yaml = { "prettier" },
      },
      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
        quiet = true,
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
      notify_on_error = true,
      log_level = vim.log.levels.ERROR,
      formatters = {
        prettier = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim-writer/.prettierrc.json"),
          },
        },
      },
    })
  end,
}

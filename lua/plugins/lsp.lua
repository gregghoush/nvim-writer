local language_id_mapping = {
  bib = "bibtex",
  pandoc = "markdown",
  plaintex = "tex",
  rnoweb = "rsweave",
  rst = "restructuredtext",
  tex = "latex",
  text = "plaintext",
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      },
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  },
  config = function()
    ---------------------
    -- lsp servers
    ---------------------
    local util = require("lspconfig.util")

    local servers = {
      harper_ls = {
        enabled = true,
        filetypes = { "markdown", "mkd", "gitcommit", "text", "plaintext" },
        settings = {
          ["harper-ls"] = {
            userDictPath = "/usr/share/dict/words",
            linters = {
              ToDoHyphen = false,
              -- SentenceCapitalization = true,
              -- SpellCheck = true,
            },
            isolateEnglish = true,
            markdown = {
              -- [ignores this part]()
              -- [[ also ignores my marksman links ]]
              IgnoreLinkTitle = true,
            },
          },
        },
      },
      yamlls = {},
      html = {},
      jsonls = {},
      lua_ls = {
        settings = {
          lua = {
            diagnostics = {
              globals = { "vim", "snacks" },
            },
            completion = {
              callsnippet = "replace",
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkthirdparty = false,
            },
          },
        },
      },
      emmet_language_server = {
        fileeypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "php" },
      },
      cssls = {},
      bashls = {},
      oxlint = {
        cmd = { "oxc_language_server" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        workspace_required = true,
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local root_markers = util.insert_package_json({ ".oxlintrc.json" }, "oxlint", fname)
          on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
        end,
      },
      ltex_plus = {
        cmd = { "ltex-ls-plus" },
        language = "en-US",
        filetypes = {
          "bib",
          "context",
          "gitcommit",
          "html",
          "markdown",
          "org",
          "pandoc",
          "plaintex",
          "quarto",
          "mail",
          "mdx",
          "rmd",
          "rnoweb",
          "rst",
          "tex",
          "text",
          "typst",
          "xhtml",
        },
        root_markers = { ".git" },
        get_language_id = function(_, filetype)
          return language_id_mapping[filetype] or filetype
        end,
        settings = {
          ltex = {
            enabled = {
              "bib",
              "context",
              "gitcommit",
              "html",
              "markdown",
              "org",
              "pandoc",
              "plaintex",
              "quarto",
              "mail",
              "mdx",
              "rmd",
              "rnoweb",
              "rst",
              "tex",
              "latex",
              "text",
              "typst",
              "xhtml",
            },
          },
        },
      },
    }

    ---------------------
    -- LSP tools
    ---------------------
    local LSP_TOOLS = {
      mmdc = {},
      prettier = {},
      proselint = {},
    }

    ---------------------
    -- capabilities
    ---------------------
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Load blink.cmp capabilities safely
    local has_blink, blink = pcall(require, "blink.cmp")
    if has_blink then
      capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
    end

    -- Add folding range capability
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    ---------------------
    -- memory limiting for LSP servers
    ---------------------
    -- local function get_memory_limit_mb()
    --   -- Adapt based on available system memory
    --   return 1024 -- 1GB limit for LSP servers
    -- end

    ---------------------
    -- mason
    ---------------------
    local ensure_installed = vim.tbl_keys(servers or {})
    local ensure_lsptools_installed = vim.tbl_keys(LSP_TOOLS or {})

    -- vim.list_extend(ensure_lsptools_installed, LSP_TOOLS)

    require("mason-tool-installer").setup({ ensure_installed = ensure_lsptools_installed })
    local lspconfig = require("mason-lspconfig")

    lspconfig.setup({
      ensure_installed = ensure_installed,
      automatic_enable = true,
    })

    ---------------------
    -- keybinds
    ---------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
        local bind = require("utils.keymap-bind")
        local map_cr = bind.map_cr
        local map_callback = bind.map_callback
        local Snacks = require("snacks")
        if client.name == "ltex_plus" then
          -- vim.notify("ltex_plus on_attach has happened.", vim.log.levels.ERROR)

          require("ltex_extra").setup({
            -- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
            -- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
            load_langs = { "en-US" },
            -- boolean : whether to load dictionaries on startup
            init_check = true,
            -- string : relative or absolute path to store dictionaries
            -- e.g. subfolder in the project root or the current working directory: ".ltex"
            -- e.g. shared files for all projects:  vim.fn.expand("~") .. "/.local/share/ltex"
            path = require("utils.common").get_iwe_root() .. "/.ltex", -- project root or current working directory
            -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
            log_level = "none",
            -- table : configurations of the ltex language server.
            -- Only if you are calling the server from ltex_extra
            server_opts = nil,
          })
        end
        local lsp_map = {
          ["n|gr"] = map_callback(function()
              Snacks.picker.lsp_references()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP references"),
          ["n|gD"] = map_callback(function()
              vim.lsp.buf.declaration()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Go to declaration"),
          ["n|gd"] = map_callback(function()
              Snacks.picker.lsp_definitions()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP definitions"),
          ["n|gi"] = map_callback(function()
              Snacks.picker.lsp_implementations()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP implementations"),
          ["n|gt"] = map_callback(function()
              Snacks.picker.lsp_type_definitions()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP type definitions"),
          ["n|gb"] = map_callback(function()
              Snacks.picker.diagnostics_buffer()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show buffer diagnostics"),
          ["n|gl"] = map_callback(function()
              vim.diagnostic.open_float()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show line diagnostics"),
          ["n|gp"] = map_callback(function()
              vim.diagnostic.goto_prev()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Go to previous diagnostic"),
          ["n|gn"] = map_callback(function()
              vim.diagnostic.goto_next()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Go to next diagnostic"),

          ["n|<leader>lr"] = map_callback(function()
              Snacks.picker.lsp_references()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP references"),
          ["n|<leader>lk"] = map_callback(function()
              vim.lsp.buf.declaration()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Go to declaration"),
          ["n|<leader>ld"] = map_callback(function()
              Snacks.picker.lsp_definitions()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP definitions"),
          ["n|<leader>li"] = map_callback(function()
              Snacks.picker.lsp_implementations()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP implementations"),
          ["n|<leader>lt"] = map_callback(function()
              Snacks.picker.lsp_type_definitions()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show LSP type definitions"),
          ["n|<leader>lb"] = map_callback(function()
              Snacks.picker.diagnostics_buffer()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show buffer diagnostics"),
          ["n|<leader>ll"] = map_callback(function()
              vim.diagnostic.open_float()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Show line diagnostics"),
          ["n|<leader>l["] = map_callback(function()
              vim.diagnostic.jump({ count = -1 })
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Go to previous diagnostic"),
          ["n|<leader>l]"] = map_callback(function()
              vim.diagnostic.jump({ count = 1 })
            end)
            :with_noremap()
            :with_silent()
            :with_desc("Go to next diagnostic"),
          ["n|<leader>lz"] = map_cr("LspRestart"):with_noremap():with_silent():with_desc("Restart LSP"),
        }

        bind.nvim_load_mapping(lsp_map)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<F4>", vim.lsp.buf.rename, opts)
      end,
    })

    ---------------------
    -- diagnostic signs
    ---------------------
    local signs = { ERROR = " ", WARN = " ", HINT = "󰠠 ", INFO = " " }
    local diagnostic_signs = {}
    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end
    vim.diagnostic.config({ signs = { text = diagnostic_signs } })

    ---------------------
    -- error lens
    ---------------------
    vim.diagnostic.config({
      float = {
        border = "rounded",
        max_width = 100,
        max_height = 20,
        focusable = false,
        close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
      },
      severity_sort = true,
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        format = function(diagnostic)
          -- Trim long diagnostics
          if #diagnostic.message > 80 then
            return diagnostic.message:sub(1, 77) .. "..."
          end
          return diagnostic.message
        end,
      },
    })

    ---------------------
    -- signature help handler
    ---------------------
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
      close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
      focusable = false,
      relative = "cursor",
      max_height = 20,
      max_width = 120,
    })

    ---------------------
    -- inlay hints
    ---------------------
    -- vim.lsp.inlay_hint.enable() -- enabled by default
    -- Keymap is defined in lua/config/keymaps.lua
  end,
}

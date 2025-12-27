<h1 align="center">
  <img src="https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-300x87.png" alt="Neovim">
</h1>

<div align="center">

_A modern Neovim configuration focused on writing and Markdown workflows_

<p>
This configuration is optimized for writing novels and managing large Markdown projects.
</p>

[![License](https://img.shields.io/github/license/greggh/nvim-writer?style=flat-square)](https://github.com/greggh/nvim-writer/blob/main/LICENSE)
</div>

## ⚡ Features

- **Markdown-focused**: Optimized for writing novels in Markdown format
- **Wiki System**: Personal wiki via NeoWiki for organizing knowledge
- **Prose Editing**: Pencil plugin for distraction-free writing
- **Book Management**: Dedicated keybindings for managing multiple book projects
- **Git Integration**: LazyGit for version control of your writing
- **Modern UI**: Catppuccin theme with clean, distraction-free interface
- **AI Assistance**: Copilot integration for writing assistance
- **LSP Support**: Language server support for Markdown and other formats
- **Telescope Integration**: Fuzzy finding for files and notes

## 📚 Key Writing Features

- **Book Navigation**: Quick access to 9 book projects (`<leader>mb1-9`)
- **Wiki System**: Create, link, and navigate wiki pages (`<leader>mw...`)
- **Note Management**: Create and open notes (`<leader>mn...`)
- **Markdown Editing**: Heading manipulation, preview, and outline (`<leader>mo...`, `<leader>mh...`)
- **Lore Management**: Organize characters, spells, abilities, and locations
- **Project Structure**: Supports `.iwe` project marker for writing projects

## Requirements

- [Nerd Font](https://www.nerdfonts.com/)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)

## Installation

> **REQUIRES NEOVIM 0.10+**. This configuration uses Neovim 0.10+ exclusive features including:
> - `vim.system()` for async operations
> - `splitkeep` option for better window management
> - Updated LSP handlers and APIs
> - Modern UI capabilities
>
> Always review code before installing a configuration.

Clone repository:

```sh
git clone git@github.com:greggh/nvim-writer ~/.config/nvim-writer
```

Open Neovim with this config:

```sh
NVIM_APPNAME=nvim-writer nvim
```

## Writing Workflow

This configuration is designed for novel writing with these key concepts:

- **Books**: Each novel has its own directory with chapters organized as Markdown files
- **Wiki**: Personal knowledge base linked to your writing projects
- **Lore**: Organize story elements (characters, spells, abilities, locations, etc.)
- **Notes**: Quick notes related to any aspect of your writing

## Key Bindings

> 💡 Press `<Space>` to see available key bindings via which-key

| Category | Key Binding | Description |
|----------|-------------|-------------|
| Book 1-9 | `<leader>mb1-9` | Open book index |
| Wiki Find | `<leader>mwf` | Search wiki files |
| Wiki New | `<leader>mnn` | Create new wiki page |
| Note New | `<leader>mnn` | Create new note |
| Note Open | `<leader>mno` | Open existing note |
| Outline | `<leader>mo` | Toggle sidebar outline |
| Preview | `<leader>mp` | Toggle markdown preview |
| LazyGit | `<leader>gg` | Open git interface |
| Save | `<C-s>` | Save file |

## Contributing

Contributions are welcome! If you'd like to help improve this configuration:

1. Check [open issues](https://github.com/greggh/nvim-writer/issues) or create a new one to discuss your idea
2. Fork repository
3. Create a new branch for your feature
4. Make your changes
5. Run tests (`make test`) and ensure they pass
6. Submit a pull request

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines and [DEVELOPMENT.md](DEVELOPMENT.md) for development setup.

## Development

This configuration includes a testing framework and development tools:

- **Testing**: Run `make test` to execute all tests
- **Linting**: Run `make lint` to check code quality
- **Formatting**: Run `make format` to format Lua code
- **Git Hooks**: Run `./scripts/setup-hooks.sh` to set up pre-commit hooks

For a complete development environment setup, see [DEVELOPMENT.md](DEVELOPMENT.md).

## 💤 Plugin manager

- [lazy.nvim](https://github.com/folke/lazy.nvim)

## 🔌 Plugins

- [actions-preview.nvim](https://github.com/aznhe21/actions-preview.nvim)
- [auto-save.nvim](https://github.com/okuuva/auto-save.nvim)
- [blink-cmp-dictionary](https://github.com/Kaiser-Yang/blink-cmp-dictionary)
- [blink-cmp-words](https://github.com/archie-judd/blink-cmp-words)
- [blink-ripgrep.nvim](https://github.com/mikavilpas/blink-ripgrep.nvim)
- [blink.cmp](https://github.com/saghen/blink.cmp)
- [blink.compat](https://github.com/saghen/blink.compat)
- [boole.nvim](https://github.com/nat-418/boole.nvim)
- [cmp-cmdline-history](https://github.com/dmitmel/cmp-cmdline-history)
- [conform.nvim](https://github.com/stevearc/conform.nvim)
- [diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [edgy.nvim](https://github.com/folke/edgy.nvim)
- [emoji.nvim](https://github.com/allaman/emoji.nvim)
- [flash.nvim](https://github.com/folke/flash.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)
- [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim)
- [helpview.nvim](https://github.com/OXY2DEV/helpview.nvim)
- [highlight-undo.nvim](https://github.com/tzachar/highlight-undo.nvim)
- [incline.nvim](https://github.com/b0o/incline.nvim)
- [iwe.nvim](https://github.com/iwe-org/iwe.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [ltex_extra.nvim](https://github.com/barreiroleo/ltex_extra.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [markview.nvim](https://github.com/OXY2DEV/markview.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [md-headers.nvim](https://github.com/AntonVanAssche/md-headers.nvim)
- [md-list.nvim](https://github.com/oliver-hughes/md-list.nvim)
- [mini.icons](https://github.com/echasnovski/mini.icons)
- [mini.sessions](https://github.com/echasnovski/mini.sessions)
- [monokai-pro](https://github.com/loctvl842/monokai-pro.nvim)
- [neowiki.nvim](https://github.com/echaya/neowiki.nvim)
- [noice.nvim](https://github.com/folke/noice.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
- [nvim-lint](https://github.com/mfussenegger/nvim-lint)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [quicker.nvim](https://github.com/stevearc/quicker.nvim)
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)
- [screenkey.nvim](https://github.com/NStefan002/screenkey.nvim)
- [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim)
- [snacks.nvim](https://github.com/folke/snacks.nvim)
- [suda](https://github.com/lambdalisue/suda.vim)
- [symbol-usage.nvim](https://github.com/Wansmer/symbol-usage.nvim)
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [tide.nvim](https://github.com/jackMort/tide.nvim)
- [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [vim-pencil](https://github.com/preservim/vim-pencil)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
- [workspace-diagnostics.nvim](https://github.com/artemave/workspace-diagnostics.nvim)
- [yazi.nvim](https://github.com/mikavilpas/yazi.nvim)
- [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)

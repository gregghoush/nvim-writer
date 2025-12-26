# nvim-writer Configuration Guidelines

## Project Overview
nvim-writer is a specialized Neovim configuration for writing novels and managing large Markdown projects. It evolved from a general-purpose coding config into a writer-focused environment.

## Requirements
- Neovim 0.10+ (required for vim.system(), splitkeep, modern LSP features)
- Nerd Font for icons
- External dependencies: ripgrep, fd, fzf, lazygit

## Project Structure
nvim-writer uses the `.iwe` project marker to identify writing projects:
- Root directory contains `.iwe` file
- Subdirectories: `books/`, `notes/`, `lore/`
- Books are organized in `books/book_*_title/` directories

## Writing Commands and Keybindings

### Book Management (prefix: `<leader>m`)
- `<leader>mb1-9` - Open book index (books 1-9)
- `<leader>mi` - Go to index

### Wiki System (prefix: `<leader>mw`)
- `<leader>mwf` - Wiki Find Files
- `<leader>mwp` - Wiki Paths
- `<leader>mwr` - Wiki Roots
- `<leader>mwg` - Wiki Grep
- `<leader>mwi` - Open Wiki
- `<leader>mww` - Open Wiki in Floating Window
- `<leader>mwt` - Open Wiki in Tab
- `<leader>mwd` - Delete Wiki Page
- `<leader>mwl` - Insert Wiki Link
- `<leader>mwc` - Cleanup Bad Links

### Note Management (prefix: `<leader>mn`)
- `<leader>mnn` - Create Note
- `<leader>mno` - Open Existing Note

### Markdown Editing (prefix: `<leader>m`)
- `<leader>mo` - Toggle Sidebar Outline
- `<leader>mto` - Toggle Telescope Outline
- `<leader>mhi` - Increase Heading #
- `<leader>mhd` - Decrease Heading #
- `<leader>mp` - Toggle Preview
- `<leader>ms` - Toggle Split View
- `<leader>mr` - List References
- `<leader>mc` - Toggle Checkbox

### General Commands
- Leader key: `<Space>`
- Save: `<C-s>` or `<leader>qs`
- Quit: `<C-q>` or `<leader>qq`
- Force quit: `<leader>qz`
- File explorer: `<leader>e`
- LazyGit: `<leader>gg`
- Search and replace: `<leader>r`
- Code actions: `<leader>ca`
- Folding: `<leader>z0` (toggle level 0), `<leader>z1` (toggle level 1), `<leader>z2` (toggle level 2)
- Window management: `<leader>wm` (toggle maximize window)
- Buffer management: `<leader>bw` (close buffer safely), `<leader>bo` (close all buffers except current)
- Claude Code: `<leader>ac` (toggle in normal mode), `<C-o>` (toggle in terminal mode)
- Help view: `<leader>hh` - Toggle enhanced view
- Format: `<leader>cf` - Format buffer
- Inlay hints: `<leader>oi` - Toggle inlay hints

## Lore Organization
The lore system helps organize story elements:
- Characters: stored in `lore/characters/`
- Spells: stored in `lore/spells/`
- Abilities: stored in `lore/abilities/`
- Locations: stored in `lore/locations/`
- Organizations: stored in `lore/organizations/`
- Rules: stored in `lore/rules/`

## Code Style Guidelines
- Use 2 spaces for indentation (tabstop=2, shiftwidth=2)
- Plugin declarations use return table format with dependencies
- Keymap definitions use utils.keymap-bind utilities
- Group related functionality in subdirectories (e.g., plugins/ai/, plugins/snacks/)
- Use diagnostic disable comments when needed
- Comments use dashes for section separators (---------------------)

## Plugin Development
- Define plugins in lua/plugins/ directory
- Organize complex plugins in subdirectories (e.g., plugins/ai/, plugins/snacks/)
- Use lazy.nvim format: return { "author/plugin", config = function() ... end }
- Add new keybindings through bind.nvim_load_mapping()
- Register keybinding groups in which-key.lua

## AI Integration
Copilot integration for writing assistance:
- Toggles: `<leader>ac` (normal mode), `<C-o>` (terminal mode)
- Window settings: 50% height at bottom of screen
- Git integration: Automatically uses git project root as CWD when available

## Git Commands
For development of nvim-writer itself:
- `git -C ~/.config/nvim-writer status` - Check current status
- `git -C ~/.config/nvim-writer add .` - Stage all changes
- `git -C ~/.config/nvim-writer commit -m "message"` - Commit changes
- `git -C ~/.config/nvim-writer push` - Push changes

## Version Management
- Current version: v0.4.2
- Version file: `lua/version.lua`

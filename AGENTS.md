# AGENTS.md

This document provides essential information for AI agents working on nvim-writer, a specialized Neovim configuration for writing novels and managing Markdown projects.

## Project Overview

nvim-writer is a modern Neovim configuration focused on writing and Markdown workflows. It uses Lua exclusively and targets Neovim 0.10+.

**Key characteristics:**
- Plugin manager: lazy.nvim
- Language: Lua 5.1 (via LuaJIT)
- Versioning: Semantic versioning (current: 0.4.2)
- Target Neovim version: 0.10.0 or higher
- Purpose: Novel writing and Markdown project management

## Essential Commands

### Development Workflow

```bash
# Run all tests
make test

# Run tests with verbose output
make test-verbose

# Run specific test suites
make test-basic    # Basic Vim script tests
make test-config   # Configuration tests

# Lint Lua code
make lint

# Format Lua code
make format

# Run complete checks (lint, format, test)
make all

# Install git hooks (pre-commit)
make hooks
```

### Manual Installation of Git Hooks

```bash
./scripts/setup-hooks.sh
```

The pre-commit hook automatically runs: stylua formatting, luacheck linting, and tests.

## Code Organization

### Directory Structure

```
.
├── init.lua                    # Main entry point - loads all core modules
├── lua/
│   ├── config/                 # Core configuration modules
│   │   ├── autocmd.lua        # Autocommands
│   │   ├── flags.lua          # Feature flags (ai, suggestions, etc.)
│   │   ├── keymaps.lua        # Keybinding definitions
│   │   ├── lazy.lua           # lazy.nvim setup and plugin loading
│   │   └── options.lua        # Neovim options/settings
│   ├── plugins/               # Plugin configurations
│   │   ├── ai/               # AI-related plugins (copilot, etc.)
│   │   ├── snacks/           # Snacks.nvim modular configurations
│   │   ├── lsp.lua           # LSP server configuration
│   │   ├── telescope.lua     # Telescope setup
│   │   └── [other plugins]   # Individual plugin configs
│   ├── utils/                 # Utility functions
│   │   ├── common.lua        # Common helper functions
│   │   ├── keymap-bind.lua   # Keybinding utility
│   │   ├── git.lua           # Git workspace utilities
│   │   ├── notes.lua         # Notes/book management
│   │   └── [other utils]     # Additional utilities
│   └── version.lua            # Version information
├── tests/
│   ├── run_tests.lua          # Custom test framework
│   ├── minimal-init.lua       # Minimal init for isolated testing
│   └── spec/                 # Test specifications
│       ├── basic_spec.lua
│       ├── config_spec.lua
│       └── [other specs]
├── test/                      # Legacy Vim script tests
│   ├── basic_test.vim
│   ├── config_test.vim
│   └── minimal.vim
├── Makefile                   # Development commands
├── .luacheckrc               # Lua linter configuration
├── .stylua.toml              # Lua formatter configuration
└── CHANGELOG.md              # Version history (Keep a Changelog format)
```

## Plugin Configuration Pattern

### Basic Plugin Structure

All plugin configurations follow the lazy.nvim format:

```lua
return {
  "author/plugin-name",
  dependencies = {
    "other/plugin",
  },
  keys = {
    { "<leader>key", function() ... end, desc = "Description" },
  },
  cmd = { "CommandName" },
  event = { "EventName" },
  ft = { "filetype" },
  config = function()
    -- Plugin setup code
  end,
}
```

### Plugin Categories

- **Root-level**: Single-file plugins (e.g., `telescope.lua`, `lsp.lua`)
- **Subdirectory**: Complex multi-file plugins (e.g., `plugins/ai/`, `plugins/snacks/`)
- **Conditional**: Plugins loaded based on feature flags (e.g., `plugins/ai/init.lua`)

### Conditional Plugin Loading

Some plugins use feature flags defined in `lua/config/options.lua`:

```lua
vim.g.ai = require("utils.flags").get_flags("ai") or false
vim.g.suggestions = require("utils.flags").get_flags("suggestions") or false
```

Conditional plugins return early if the flag is false:

```lua
if not vim.g.ai then
  return {}
end
```

## Keybinding System

### Keybinding Utilities

All keybindings use the `utils.keymap-bind` module:

```lua
local bind = require("utils.keymap-bind")
local map_cr = bind.map_cr      -- :command<CR>
local map_cu = bind.map_cu      -- :<C-u>command<CR>
local map_cmd = bind.map_cmd    -- raw command string
local map_callback = bind.map_callback

-- Examples:
["n|<leader>qs"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),
["n|<leader>k"] = map_cr("nohlsearch"):with_noremap():with_silent(),
```

### Keybinding Registration

1. **Plugin keybindings**: Defined in plugin `keys` field (lazy.nvim native)
2. **Global keybindings**: Registered in `lua/config/keymaps.lua`
3. **Which-key groups**: Registered in `lua/plugins/which-key.lua`

### Which-Key Integration

Register keybinding groups for discoverability:

```lua
{ "<leader>f", group = "Files", icon = "" },
{ "<leader>g", group = "Git" },
```

## Code Style and Conventions

### Formatting

**Tool**: stylua

**Configuration**: `.stylua.toml`
- Column width: 120
- Indentation: 2 spaces
- Quote style: AutoPreferDouble
- Call parentheses: Always

### Linting

**Tool**: luacheck

**Configuration**: `.luacheckrc`

**Key Rules**:
- Max line length: 120 characters
- Unused parameters: Allowed if prefixed with underscore (e.g., `_config`)
- Globals: Neovim `vim` global is allowed
- Test files have relaxed rules

### Code Patterns

**Module Pattern**:
```lua
local M = {}

function M.function_name()
  -- Implementation
end

return M
```

**Table Return Pattern** (for plugins):
```lua
return {
  -- Plugin spec
}
```

**Separators**: Use dashes for section comments:
```lua
------------------------------------
-- SECTION NAME
------------------------------------
```

**Variable Naming**:
- Use snake_case for variables and functions
- Use PascalCase for metaclasses
- Prefix local functions with underscore if intentionally unused

## Testing

### Test Framework

Custom BDD-style framework in `tests/run_tests.lua`:

```lua
local test = require("tests.run_tests")

test.describe("Feature name", function()
  test.it("should do something", function()
    test.expect(result).to_be(expected)
    test.expect(value).to_be_truthy()
    test.expect(table).to_contain(item)
    test.expect(actual).to_equal(expected)
    test.expect(string).to_match(pattern)
  end)
end)
```

### Test Types

1. **Lua Spec Tests**: `tests/spec/*_spec.lua` (preferred)
2. **Vim Script Tests**: `test/*_test.vim` (legacy)

### Test Execution

Tests run with minimal init (`tests/minimal-init.lua`) to isolate from personal config:

```bash
# Run spec tests
nvim --headless --noplugin -u tests/minimal-init.lua \
  -c "lua require('tests.run_tests').run_tests('tests/spec')" \
  -c "qa!"
```

### Test Mode Flag

Set `vim.g._test_mode = true` in test environment to conditionally disable features.

## Version Management

**File**: `lua/version.lua`

```lua
local M = {
  major = 0,
  minor = 1,
  patch = 0,
}

function M.string()
  return string.format("%d.%d.%d", M.major, M.minor, M.patch)
end
```

**Update Procedure**:
1. Update version numbers in `lua/version.lua`
2. Add entry to `CHANGELOG.md` following Keep a Changelog format
3. Follow Semantic Versioning (MAJOR.MINOR.PATCH)

## Important Gotchas

### Neovim Version Requirements

- **Minimum**: Neovim 0.10.0 (required for `vim.system()`, `splitkeep`, modern LSP features)
- Some features may not work in older versions

### Module Preloading

The configuration uses smart module preloading (`utils/preload.lua`) for performance. Be careful when modifying module loading order in `init.lua`.

### Git Hooks

Pre-commit hooks are configured via `.githooks/` directory:
- Run `make hooks` to install
- Bypass with `git commit --no-verify` (use sparingly)

### Global Variables

**Configuration Globals** (`lua/config/options.lua`):
- `vim.g.mapleader` = " "
- `vim.g.ai` = AI feature flag
- `vim.g.suggestions` = Suggestions flag
- `vim.g.ignore_filetypes` = List of filetypes to ignore

**Ignored Filetypes**: Used for buffer exclusion, LSP disabling, etc. Always check this list before adding LSP or completion for new filetypes.

### Plugin Loading Order

Core modules load sequentially in `init.lua`:
1. `config.flags`
2. `config.options`
3. `config.lazy` (loads all plugins)
4. `config.keymaps`
5. `config.autocmd`

Never modify the loading order unless necessary for dependency resolution.

### Lazy.nvim Performance Settings

- Plugin caching enabled (7 day TTL)
- Disabled built-in plugins for performance
- Change detection throttled (1000ms)
- Checker runs daily (86400s)

### Custom Utilities

**Keybinding builder**: Always use `utils.keymap-bind` for consistent keybinding definitions

**Git workspace**: Use `utils.git.get_workspace_root()` for git-aware operations

**Notes/Books**: Custom note-taking system via `utils.notes.lua` for managing book indexes and markdown notes

### LSP Configuration

LSP servers defined in `lua/plugins/lsp.lua`:
- Always check `filetypes` list
- Use `root_dir` for workspace detection
- Settings follow standard LSP config format

### Filetype-Specific Gotchas

The config uses a comprehensive `vim.g.ignore_filetypes` list. When adding features:
1. Check if the filetype is in the ignore list
2. Consider whether the feature should work in UI buffers (Telescope, lazygit, etc.)
3. Update ignore list if necessary

## External Dependencies

### Required for Core Functionality

- **Neovim**: 0.10+ (system package or compiled from source)
- **Git**: For version control and git integration features
- **Make**: For running development commands

### Optional but Recommended

- **lazygit**: Git TUI (keybinding: `<leader>gg`)
- **ripgrep**: Fast search (used by Telescope, grug-far)
- **fd**: Fast file finding (used by Telescope, fuzzy finders)
- **fzf**: Fuzzy finder (Telescope extension)

### Development Tools

- **stylua**: Lua formatter (`make format`)
- **luacheck**: Lua linter (`make lint`)

## Common Tasks

### Adding a New Plugin

1. Create file in `lua/plugins/` (e.g., `new-plugin.lua`)
2. Follow lazy.nvim format
3. Add keybindings via `keys` field or register in `keymaps.lua`
4. Add which-key group if applicable
5. Test with `nvim --headless -u tests/minimal-init.lua`

### Adding a New LSP Server

1. Edit `lua/plugins/lsp.lua`
2. Add server configuration to `servers` table
3. Specify `filetypes` and settings
4. Verify server is installed (via Mason if needed)

### Adding a New Keybinding

1. Determine if plugin-specific or global
2. For plugins: Add to plugin `keys` field
3. For global: Add to `lua/config/keymaps.lua`
4. Use `utils.keymap-bind` utilities
5. Add which-key group registration if needed

### Debugging Plugin Loading

Set `NVIM_PROFILE=1` environment variable for detailed startup profiling:

```bash
NVIM_PROFILE=1 nvim
```

This generates logs in `~/.local/state/nvim/cache/nvim_startup_*.log`

## Project-Specific Features

### Writing/Book System

The config includes a custom writing system:
- **Book indexes**: Multiple books (book_1 through book_9)
- **Lore management**: Characters, spells, abilities, locations, organizations, rules
- **Notes system**: Markdown note-taking in project structure
- **Keybindings**: Book navigation under `<leader>m` prefix

### AI Integration

Conditional AI features based on flags:
- **Copilot**: GitHub Copilot integration
- **Claude Code**: Toggle via `<leader>ac` (normal) or `<C-o>` (terminal)
- **Suggestions**: Can be toggled via feature flags

### Performance Optimizations

- Module preloading after core initialization
- Lazy loading for most plugins
- Caching for lazy.nvim (7 days)
- Disabled heavy built-in plugins
- Smart module loading based on filetype

## Recent Session Context

### Session: Documentation Refactor & Test Infrastructure (2024-12-26)

**Major Changes Made:**
1. Fixed all failing tests (2 failures → 0 failures, 20/20 passing)
2. Updated all documentation for nvim-writer project (writing-focused)
3. Updated README generation function in keymaps.lua
4. Expanded test suite from 20 to 30 tests (+10 tests, all passing)
5. Identified missing external tool dependencies

**Test Fixes Applied:**
- Fixed keymap utility functions test to recognize `utils.keymap` module functions (amend, replace)
- Updated essential plugins test to detect lazy.nvim in `config/lazy.lua` (not plugin specs)
- Added mocks for `utils.common.get_iwe_root()` in `tests/minimal-init.lua` to prevent nil concatenation errors
- Updated all test paths to use `nvim-writer` directory instead of old generic paths

**New Test Files Added:**
- `tests/spec/writing_spec.lua` - Tests writing-specific plugins (6 tests)
- `tests/spec/utils_spec.lua` - Tests utility modules (5 tests)
- `tests/spec/writing_plugins_spec.lua` - Tests critical plugin files (3 tests)

**Test Coverage Summary:**
| Test File | Tests | Description |
|-----------|--------|-------------|
| basic_spec.lua | 3 | Neovim version, test mode |
| config_spec.lua | 5 | Config modules (options, keymaps, autocmd) |
| keymappings_spec.lua | 3 | Leader key, keymap utils, which-key |
| ui_components_spec.lua | 5 | Colorscheme, statusline, notifications, explorer |
| utils_spec.lua | 5 (NEW) | Utility modules (common, notes, git, keymap) |
| writing_spec.lua | 6 (NEW) | Writing plugins (iwe, neowiki, pencil, markdown) |
| writing_plugins_spec.lua | 3 (NEW) | Critical plugin files validation |

**Critical Writing Plugins Now Tested:**
- iwe.lua - Book/notes management (CORE)
- neowiki.lua - Wiki system (CORE)
- pencil.lua - Prose editing (CORE)
- markdown.lua - Markdown support (CORE)
- auto-save.lua - Auto-save (CRITICAL for writing)
- treesitter.lua - Syntax highlighting
- telescope.lua - Fuzzy finding
- lualine.lua - Status line
- which-key.lua - Key binding help
- formatter.lua - Prettier for Markdown
- linter.lua - Proselint for Markdown

**Documentation Overhaul:**
- CLAUDE.md: Complete rewrite for writing workflows (books, wiki, lore, notes)
- DEVELOPMENT.md: Updated project structure and paths for nvim-writer
- AGENTS.md: Updated project overview and version info
- SUPPORT.md: Complete rewrite for nvim-writer project
- ROADMAP.md: Writing-specific goals and features
- README generation: Updated to generate writing-focused README.md

**External Tool Dependencies Identified:**

### Required Tools (Must Install Manually):
1. **Prettier** (Node.js)
   ```bash
   npm install -g prettier
   ```
   Purpose: Markdown formatter

2. **Proselint** (Python)
   ```bash
   pip install proselint
   ```
   Purpose: Prose linter for Markdown

### Optional LSP Servers (Install via Mason or manually):
3. **ltex-ls-plus** (LanguageTool LSP)
   ```bash
   npm install -g @valentjn/ltex-ls
   ```
   Purpose: Language server for LaTeX/Markdown

4. **Oxlint** (JavaScript/TypeScript LSP)
   ```bash
   npm install -g oxlint
   ```
   Purpose: JavaScript/TypeScript LSP server

**Already Installed Tools:**
- Neovim, Go, Python, Node.js ✅
- lazygit, ripgrep, fd, fzf ✅
- yazi (file explorer) ✅
- iwe, iwes (writing tools) ✅
- Mason (LSP manager) - available in Neovim ✅

**Key nvim-writer Features:**
- Book Management: 9 book projects with dedicated keybindings (`<leader>mb1-9`)
- Wiki System: NeoWiki for personal knowledge base (`<leader>mw...`)
- Note Management: Create/open notes (`<leader>mn...`)
- Lore Organization: Characters, spells, abilities, locations, rules, organizations
- Project Structure: Uses `.iwe` file as project marker for writing projects
- Key Workflows: Books, Wiki, Lore, Notes

**Important Utilities:**
- `utils.common.get_iwe_root()` - Finds project root with `.iwe` marker
- `utils.common.get_lore_root()` - Finds lore directory
- `utils.common.get_notes_root()` - Finds notes directory
- `utils.notes` - Note and book management functions
- `utils.neowiki` - Wiki system for knowledge organization
- `utils.git.get_git_root()` - Git workspace utilities
- `utils.keymap` - Keybinding utilities (amend, replace functions)

**When Running Tests:**
- Tests use `tests/minimal-init.lua` for isolated environment
- Mocks are required for external dependencies (utils.common, cmp, etc.)
- All tests must pass before commits (pre-commit hook enforcement)
- Run `make test` to verify changes
- Run `make test-verbose` for detailed output

**Generating README:**
- Press `<leader>pr` in nvim-writer to regenerate README.md
- README is dynamically generated from installed plugins
- Content reflects current nvim-writer configuration

**Recent Commits:**
- `99f2cfe` - Refactor config as nvim-writer: writing-focused configuration
- `d73d8b1` - docs: Add session context to AGENTS.md
- `a5a2013` - test: Add writing-specific tests and expand test coverage

**Installation Status:**
- Neovim 0.10+ ✅
- Plugin dependencies (Go, Python, Node.js) ✅
- Rust tools (iwe, iwes) ✅
- Git tools (lazygit) ✅
- Search tools (ripgrep, fd, fzf) ✅
- File explorer (yazi) ✅
- PENDING: prettier (npm)
- PENDING: proselint (pip)
- Review this AGENTS.md file for recent session context

## Troubleshooting

### Common Issues

1. **Plugin not loading**: Check if in ignored filetypes list
2. **Keybinding not working**: Verify which-key registration, check for conflicts
3. **LSP not starting**: Check filetype match, verify Mason installation
4. **Tests failing**: Run with `make test-verbose` for details
5. **Formatting issues**: Run `make format` before committing
6. **utils.common nil errors**: Ensure `tests/minimal-init.lua` has proper mocks

### Getting Help

- Check error messages carefully
- Verify Neovim version (`nvim --version`)
- Review test output with verbose mode
- Check existing issues in GitHub repository
- Review CLAUDE.md for writing workflow context
- Review this AGENTS.md file for recent session context

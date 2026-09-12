# LazyVim Cheat Sheet

Personal reference for this config · `<leader>sk` = search all keymaps · `<leader>sC` = this sheet · `q` closes

Leader is **Space**. LSP needs an attached server (`:LspInfo`).

---

## Launch

| Command | Config |
|---------|--------|
| `nvl` / `NVIM_APPNAME=nvim-lazyvim nvim` | LazyVim |
| `nvim` / `nvc` | NvChad (unchanged) |

---

## LSP navigation (Go · C/C++ · Rust · Java · Lua)

| Key | Action | Notes |
|-----|--------|-------|
| `gd` | Definition | Jump to symbol definition |
| `gD` | Declaration | When the server supports it |
| `gr` | References | **Where is this used?** (all files) |
| `gI` | Implementation | Interfaces → concrete types (Go/Java) |
| `gy` | Type definition | Jump to the type |
| `K` | Hover | Docs / signature |
| `<leader>ca` | Code action | Fix / refactor / import |
| `<leader>cr` | Rename | Rename symbol project-wide |
| `]d` / `[d` | Next / prev diagnostic | |
| `<leader>cd` | Line diagnostics | |
| `<leader>cl` | LSP info | |

**Go tip:** `gI` works on an **interface** (or interface method). On a concrete func use `gd` / `gr`.

**C/C++ tip:** Prefer a `compile_commands.json` (e.g. via `bear`) so `clangd` resolves includes.

---

## Search & files

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fb` | Buffers |
| `<leader>sg` | Live grep (project) |
| `<leader>sw` | Grep word under cursor |
| `<leader>ss` | Document symbols |
| `<leader>sS` | Workspace symbols |
| `<leader>sk` | **Search all keymaps** (built-in, do not replace) |
| `<leader>sC` | **This cheat sheet** |
| `<leader>sh` | Help tags |

---

## Buffers · windows · tabs

| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |
| `<S-h>` / `<S-l>` | Prev / next buffer |
| `<C-h/j/k/l>` | Move to window |
| `<leader>ww` | Other window |
| `<leader>wd` | Delete window |
| `<leader>-` / `<leader>\|` | Split below / right |
| `<leader>qq` | Quit all |

---

## Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gs` | Git status (picker) |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff this |
| `]h` / `[h` | Next / prev hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghp` | Preview hunk |

---

## Editing · UI

| Key | Action |
|-----|--------|
| `<leader>cf` | Format |
| `<leader>e` | Explorer (Neo-tree / snacks) |
| `<leader>E` | Explorer (cwd root) |
| `<leader>uz` | Toggle zen |
| `<leader>uw` | Toggle wrap |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers |
| `<esc><esc>` | Clear search highlight |
| `gcc` | Comment line |
| `gc` | Comment (visual / motion) |

---

## Language tooling (this machine)

| Lang | Server | Extra / notes |
|------|--------|----------------|
| Go | `gopls` | system binary · `lang.go` |
| C / C++ | `clangd` | system · `lang.clangd` |
| Rust | `rust-analyzer` | rustup · `lang.rust` / rustaceanvim |
| Java | `jdtls` | Mason + OpenJDK **21** |
| Lua | `lua_ls` | Mason · LazyVim core |

Config: `lua/plugins/lsp-system.lua`

---

## Debug (when DAP is active)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dt` | Terminate |
| `<leader>du` | DAP UI |

---

## Survival commands

```
:LspInfo          which servers are attached
:LspRestart       reload LSP after config change
:Lazy             plugin manager
:LazyExtras       enable/disable LazyVim extras
:Mason            install LSP / tools
:checkhealth      diagnose Neovim
:LazyHealth       LazyVim health
```

---

## Edit this sheet

File: `~/.config/nvim-lazyvim/CHEATSHEET.md`  
Open here with `<leader>sC`, or edit permanently with:

```
nvl ~/.config/nvim-lazyvim/CHEATSHEET.md
```

Add your own rows anytime — this file is yours; `<leader>sk` stays the live keymap searcher.

# LazyVim Config

Personal [LazyVim](https://github.com/LazyVim/LazyVim) starter fork for testing beside NvChad.

Upstream template: [LazyVim/starter](https://github.com/LazyVim/starter)

## Side-by-side with NvChad

This config lives at `~/.config/nvim-lazyvim` and does **not** replace NvChad (`~/.config/nvim`).

| Config | Path | Launch |
|--------|------|--------|
| **NvChad** (default) | `~/.config/nvim` | `nvim` or `nvc` |
| **LazyVim** | `~/.config/nvim-lazyvim` | `NVIM_APPNAME=nvim-lazyvim nvim` or `nvl` |

```bash
# LazyVim
nvl
# or
NVIM_APPNAME=nvim-lazyvim nvim

# NvChad (unchanged)
nvim
```

After first launch, run `:LazyHealth` to verify plugins.

## Language LSPs

`lua/plugins/lsp-system.lua` keeps Go/C/C++/Rust/Java/Lua working when Mason is flaky:

| Lang | Server | Source |
|------|--------|--------|
| Go | `gopls` | system (`go install`) |
| C / C++ | `clangd` | system + `lang.clangd` extra |
| Rust | `rust-analyzer` | rustup + `lang.rust` |
| Java | `jdtls` | Mason + Homebrew `openjdk@21` |
| Lua | `lua_ls` | Mason |

```bash
# one-time toolchain pieces used on this machine
go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
brew install openjdk@21
```

## Cheat sheet (inside `<leader>sk`)

`<leader>sC` stays **Commands**. Your sheets live under `cheatsheets/*.md`.

| Key | Where | Action |
|-----|--------|--------|
| `<leader>sk` | normal | Keymaps picker (Snacks UI) |
| `<a-c>` | inside sk | Switch to **personal cheat sheet** |
| `<a-s>` | inside sk / sheet | Switch between cheat sheet files |
| `<a-k>` | inside sheet | Back to keymaps |
| `<a-e>` | inside sheet | Edit the markdown sheet |
| `<a-g>` / `<a-b>` | inside sk | Toggle global / buffer keymaps |

Add more sheets by creating `cheatsheets/name.md` with markdown tables.

## Customize

- Options / keymaps / autocmds → `lua/config/`
- Plugins → `lua/plugins/`
- Docs → https://lazyvim.github.io

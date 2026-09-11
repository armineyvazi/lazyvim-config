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

## Customize

- Options / keymaps / autocmds → `lua/config/`
- Plugins → `lua/plugins/`
- Docs → https://lazyvim.github.io

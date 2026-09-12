# Personal

Your curated bindings. Add rows anytime. Open via `<leader>sk` then `<a-c>`.

## LSP navigation

| Key | Action | Notes |
|-----|--------|-------|
| `gd` | Definition | Jump to symbol definition |
| `gD` | Declaration | When the server supports it |
| `gr` | References | Where is this used (all files) |
| `gI` | Implementation | Interfaces → concrete types |
| `gy` | Type definition | Jump to the type |
| `K` | Hover | Docs / signature |
| `<leader>ca` | Code action | Fix / refactor / import |
| `<leader>cr` | Rename | Rename symbol project-wide |
| `]d` | Next diagnostic | |
| `[d` | Prev diagnostic | |
| `<leader>cd` | Line diagnostics | |
| `<leader>cl` | LSP info | |

## Search and files

| Key | Action | Notes |
|-----|--------|-------|
| `<leader><space>` | Find files | Smart finder |
| `<leader>ff` | Find files | |
| `<leader>fr` | Recent files | |
| `<leader>fb` | Buffers | |
| `<leader>sg` | Live grep | Project search |
| `<leader>sw` | Grep word | Under cursor |
| `<leader>ss` | Document symbols | |
| `<leader>sS` | Workspace symbols | |
| `<leader>sk` | Keymaps picker | `<a-c>` cheat sheet · `<a-s>` sheets |
| `<leader>sC` | Commands | Built-in command picker |
| `<leader>sh` | Help tags | |

## Git

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>gg` | Lazygit | |
| `<leader>gs` | Git status | |
| `<leader>gb` | Blame line | |
| `<leader>gd` | Diff this | |
| `]h` | Next hunk | |
| `[h` | Prev hunk | |
| `<leader>ghs` | Stage hunk | |
| `<leader>ghr` | Reset hunk | |
| `<leader>ghp` | Preview hunk | |

## Buffers and windows

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>bd` | Delete buffer | |
| `<leader>bo` | Delete other buffers | |
| `<S-h>` | Prev buffer | |
| `<S-l>` | Next buffer | |
| `<C-h>` | Window left | |
| `<C-j>` | Window down | |
| `<C-k>` | Window up | |
| `<C-l>` | Window right | |
| `<leader>wd` | Delete window | |
| `<leader>qq` | Quit all | |

## Editing

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>cf` | Format | |
| `<leader>e` | Explorer | |
| `gcc` | Comment line | |
| `gc` | Comment motion | |
| `<leader>uz` | Toggle zen | |
| `<leader>uw` | Toggle wrap | |
| `<leader>ud` | Toggle diagnostics | |

## Languages (this machine)

| Key | Action | Notes |
|-----|--------|-------|
| `gopls` | Go LSP | system binary |
| `clangd` | C / C++ LSP | system + lang.clangd |
| `rust-analyzer` | Rust LSP | rustup + rustaceanvim |
| `jdtls` | Java LSP | Mason + OpenJDK 21 |
| `lua_ls` | Lua LSP | Mason |

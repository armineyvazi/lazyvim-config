# LSP

Focused LSP / language navigation sheet. Switch with `<leader>sk` → `<a-s>`.

## Core

| Key | Action | Notes |
|-----|--------|-------|
| `gd` | Definition | |
| `gr` | References | Where used |
| `gI` | Implementation | Interfaces |
| `gy` | Type definition | |
| `K` | Hover | |
| `<leader>ca` | Code action | |
| `<leader>cr` | Rename | |
| `<leader>ss` | Document symbols | |
| `<leader>sS` | Workspace symbols | |

## Go

| Key | Action | Notes |
|-----|--------|-------|
| `gI` | Implementations | Cursor on interface / method |
| `gr` | Usages | Concrete funcs and types |
| `gd` | Definition | |

## C and C++

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>ch` | Switch source/header | clangd |
| `gd` | Definition | Needs compile_commands.json |

## Rust

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>cR` | Rust code action | rustaceanvim |
| `<leader>dr` | Rust debuggables | |

## Java

| Key | Action | Notes |
|-----|--------|-------|
| `<leader>co` | Organize imports | jdtls |
| `<leader>cgs` | Goto super | |
| `<leader>cxv` | Extract variable | |
| `<leader>cxc` | Extract constant | |

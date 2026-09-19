-- Stronger suggest + syntax/lint corrections for Go, Rust, and C/C++.
-- Uses LSP diagnostics + linters; fixes via <leader>ca (code action).
return {
  -- ── Go: gopls diagnostics + golangci-lint ─────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          mason = false,
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              staticcheck = true,
              gofumpt = true,
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                shadow = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },

        -- ── C/C++: clangd + clang-tidy (syntax, suggestions, fixes) ─────────
        clangd = {
          mason = false,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "goimports",
        "gofumpt",
        "golangci-lint",
      },
    },
  },

  -- ── Rust: rust-analyzer check with Clippy ─────────────────────────────────
  {
    "mrcjkb/rustaceanvim",
    optional = true,
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            procMacro = { enable = true },
            diagnostics = {
              enable = true,
              experimental = { enable = true },
            },
            completion = {
              autoimport = { enable = true },
              postfix = { enable = true },
            },
            inlayHints = {
              bindingModeHints = { enable = false },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true },
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "skip_trivial" },
              parameterHints = { enable = true },
              typeHints = { enable = true },
            },
          },
        },
      },
    },
  },

  -- Treesitter for better syntax awareness
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "go", "gomod", "gowork", "gosum", "rust", "c", "cpp" },
    },
  },
}

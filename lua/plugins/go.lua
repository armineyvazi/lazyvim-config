-- Go auto-import:
-- 1) Completion (gopls completeUnimported) adds import when you accept a symbol
-- 2) <leader>cf / format-on-save runs goimports (add missing, drop unused)
-- 3) <leader>ci organizes imports via gopls
return {
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
                unusedparams = true,
                unusedwrite = true,
                nilness = true,
              },
            },
          },
          keys = {
            {
              "<leader>ci",
              function()
                vim.lsp.buf.code_action({
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                  apply = true,
                })
              end,
              desc = "Organize Go Imports",
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    opts = {
      ensure_installed = { "goimports", "gofumpt" },
    },
  },
}

-- Go auto-import settings (shared keys live in lang-unified-keys.lua).
-- Completion + goimports on <leader>cf; organize via shared <leader>ci.
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
        },
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

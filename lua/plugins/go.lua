-- Mason's gopls package fails to install on this machine
-- (wrong module path for gopls@v0.23.0). Use the system gopls on PATH instead.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          mason = false,
        },
      },
    },
  },
}

-- <leader>sk → Keymaps (Snacks UI) with switch to personal cheat sheets.
-- <leader>sC stays Commands (do not override).
return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>sk", desc = "Keymaps / Cheat Sheet" },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      -- Disable FzfLua's sk so our Snacks hybrid mapping wins.
      { "<leader>sk", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      -- Override snacks/LazyVim sk; keep sC as Commands.
      {
        "<leader>sk",
        function()
          require("config.cheatsheet").open_keymaps()
        end,
        desc = "Keymaps / Cheat Sheet",
      },
    },
  },
}

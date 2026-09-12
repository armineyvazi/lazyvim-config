-- Personal cheat sheet float. Does NOT touch <leader>sk (FzfLua keymaps).
return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>sC", desc = "Cheat Sheet (personal)" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sC",
        function()
          local path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
          if vim.fn.filereadable(path) == 0 then
            vim.notify("Cheat sheet missing: " .. path, vim.log.levels.ERROR)
            return
          end
          Snacks.win({
            file = path,
            title = " Cheat Sheet ",
            title_pos = "center",
            border = "rounded",
            width = 0.72,
            height = 0.86,
            backdrop = 60,
            ft = "markdown",
            wo = {
              wrap = true,
              linebreak = true,
              cursorline = true,
              number = false,
              relativenumber = false,
              signcolumn = "no",
              conceallevel = 2,
              spell = false,
            },
            bo = {
              modifiable = false,
              readonly = true,
            },
            keys = {
              q = "close",
              ["<Esc>"] = "close",
              e = {
                function(self)
                  self:close()
                  vim.cmd.edit(path)
                end,
                desc = "Edit cheat sheet",
                mode = { "n" },
              },
            },
            footer = "  q/Esc close · e edit file · <leader>sk = search all keymaps  ",
            footer_pos = "center",
          })
        end,
        desc = "Cheat Sheet (personal)",
      },
    },
  },
}

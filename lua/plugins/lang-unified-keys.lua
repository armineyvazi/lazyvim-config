-- Same keyboard bindings for Go / Rust / C / C++.
-- Language is auto-detected from filetype + attached LSP / Conform.
--
--   <leader>cf  Format              (LazyVim — Conform by ft, else LSP)
--   <leader>ca  Code action / fix   (LazyVim — any LSP)
--   <leader>ci  Organize imports    (this file — Go / Rust / clangd / …)
--   ]d [d       Next / prev issue   (LazyVim)
--   K           Hover               (LazyVim)

local function organize_imports()
  if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
    vim.notify("No LSP attached for this buffer", vim.log.levels.WARN)
    return
  end
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source.organizeImports",
        "source.organizeImports.clangd",
      },
      diagnostics = {},
    },
    apply = true,
  })
end

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        rust = { "rustfmt" },
        -- clang-format used when installed; otherwise LazyVim falls back to clangd LSP format
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        ["clang-format"] = {
          condition = function()
            return vim.fn.executable("clang-format") == 1
          end,
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lazyvim_unified_lang_keys", { clear = true }),
        callback = function(ev)
          vim.keymap.set("n", "<leader>ci", organize_imports, {
            buffer = ev.buf,
            silent = true,
            desc = "Organize Imports (auto lang)",
          })
        end,
      })
    end,
  },
}

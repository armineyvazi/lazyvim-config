-- Go auto-import with Fiber v2 awareness.
--
-- Problem: typing fiber.Config + goimports/gopls often inserts
--   import "github.com/gofiber/fiber"   (v1)
-- but Config / `return c.SendString` need
--   import "github.com/gofiber/fiber/v2"
--
-- Fix: after format/save/organize, rewrite v1 → v2 when go.mod requires v2.
-- Prefer completion: type `fiber.` → Ctrl-Space → pick the item showing `/v2`.

local function go_mod_has_fiber_v2(buf_path)
  local start = buf_path ~= "" and vim.fn.fnamemodify(buf_path, ":h") or vim.uv.cwd()
  local mod = vim.fs.find("go.mod", { upward = true, path = start })[1]
  if not mod then
    return false
  end
  local ok, lines = pcall(vim.fn.readfile, mod)
  if not ok then
    return false
  end
  for _, line in ipairs(lines) do
    if line:find("github.com/gofiber/fiber/v2", 1, true) then
      return true
    end
  end
  return false
end

local function fix_fiber_v2_import(bufnr)
  bufnr = bufnr or 0
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= "go" then
    return false
  end
  local name = vim.api.nvim_buf_get_name(bufnr)
  if not go_mod_has_fiber_v2(name) then
    return false
  end
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local changed = false
  for i, line in ipairs(lines) do
    if line:match('import%s+"github%.com/gofiber/fiber"%s*$')
      or line:match('^%s*"github%.com/gofiber/fiber"%s*$')
    then
      -- avoid double-replacing already-v2 lines
      if not line:find("fiber/v2", 1, true) then
        lines[i] = line:gsub('"github%.com/gofiber/fiber"', '"github.com/gofiber/fiber/v2"')
        changed = true
      end
    end
  end
  if changed then
    local view = vim.fn.winsaveview()
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.fn.winrestview(view)
  end
  return changed
end

local function format_go()
  local bufnr = vim.api.nvim_get_current_buf()
  LazyVim.format({ force = true, buf = bufnr })
  vim.defer_fn(function()
    if vim.api.nvim_buf_is_valid(bufnr) then
      fix_fiber_v2_import(bufnr)
    end
  end, 50)
end

local function organize_go_imports()
  local bufnr = vim.api.nvim_get_current_buf()
  if #vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" }) > 0 then
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" }, diagnostics = {} },
      apply = true,
    })
  end
  vim.defer_fn(function()
    fix_fiber_v2_import(bufnr)
  end, 80)
end

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
              deepCompletion = true,
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

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local grp = vim.api.nvim_create_augroup("go_fiber_v2_imports", { clear = true })

      -- After save (LazyVim autoformat may have run goimports → v1)
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = grp,
        pattern = "*.go",
        callback = function(ev)
          if fix_fiber_v2_import(ev.buf) then
            -- write again so disk matches buffer (avoid reverse sync)
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].modified then
                vim.api.nvim_buf_call(ev.buf, function()
                  vim.cmd("silent! noautocmd write")
                end)
              end
            end)
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = grp,
        pattern = "go",
        callback = function(ev)
          local buf = ev.buf
          vim.keymap.set("n", "<leader>cf", format_go, {
            buffer = buf,
            desc = "Format Go (+ fiber v2 import fix)",
          })
          vim.keymap.set("n", "<leader>ci", organize_go_imports, {
            buffer = buf,
            desc = "Organize Go imports (fiber v2 aware)",
          })
        end,
      })
    end,
  },
}

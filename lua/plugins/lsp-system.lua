-- Prefer system/toolchain LSPs when Mason install is broken or skipped.
-- LazyVim only auto-enables Mason-installed servers unless mason = false.
--
-- Covered:
--   Go     → system gopls          (Mason package fails on this machine)
--   C/C++  → system clangd         (Apple clangd / brew llvm; lang.clangd)
--   Rust   → rustup rust-analyzer  (rustaceanvim uses PATH)
--   Java   → Mason jdtls + JDK 21  (jdtls requires Java 21+)
--   Lua    → Mason lua_ls          (LazyVim core)

local function has(bin)
  return vim.fn.executable(bin) == 1
end

local function java21()
  local candidates = {
    "/opt/homebrew/opt/openjdk@21/bin/java",
    "/usr/local/opt/openjdk@21/bin/java",
    vim.fn.expand("~/.sdkman/candidates/java/current/bin/java"),
  }
  for _, path in ipairs(candidates) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
  return nil
end

local servers = {}

if has("gopls") then
  servers.gopls = { mason = false }
end

if has("clangd") then
  servers.clangd = { mason = false }
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = servers,
    },
  },

  -- jdtls refuses to start on Java < 21; point it at Homebrew OpenJDK 21
  -- without changing the shell JAVA_HOME used for other projects.
  {
    "mfussenegger/nvim-jdtls",
    optional = true,
    opts = function(_, opts)
      local jdk = java21()
      if not jdk then
        return
      end
      opts.cmd = vim.list_extend(vim.deepcopy(opts.cmd or { vim.fn.exepath("jdtls") }), {
        "--java-executable",
        jdk,
      })
    end,
  },
}

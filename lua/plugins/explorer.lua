-- Colored git status in Snacks explorer sidebar (modified / untracked / etc.).
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            git_status = true,
            git_untracked = true,
            -- keep status color on open directories too
            git_status_open = true,
            formatters = {
              file = {
                filename_only = true,
                git_status_hl = true, -- color the filename by git status
              },
            },
          },
        },
        icons = {
          git = {
            enabled = true,
            added = "✚",
            modified = "●",
            deleted = "✖",
            renamed = "➜",
            untracked = "✭",
            ignored = "◌",
            staged = "✓",
            unmerged = "⚠",
          },
        },
      },
    },
    init = function()
      -- Default Snacks links Untracked → NonText (almost invisible).
      local function paint_git_status()
        local hl = vim.api.nvim_set_hl
        hl(0, "SnacksPickerGitStatusAdded", { fg = "#9ece6a", bold = true }) -- green
        hl(0, "SnacksPickerGitStatusModified", { fg = "#e0af68", bold = true }) -- yellow
        hl(0, "SnacksPickerGitStatusDeleted", { fg = "#f7768e", bold = true }) -- red
        hl(0, "SnacksPickerGitStatusUntracked", { fg = "#7dcfff", bold = true }) -- cyan
        hl(0, "SnacksPickerGitStatusStaged", { fg = "#bb9af7", bold = true }) -- purple
        hl(0, "SnacksPickerGitStatusRenamed", { fg = "#7aa2f7", bold = true }) -- blue
        hl(0, "SnacksPickerGitStatusCopied", { fg = "#7aa2f7", bold = true })
        hl(0, "SnacksPickerGitStatusIgnored", { fg = "#565f89" })
        hl(0, "SnacksPickerGitStatusUnmerged", { fg = "#ff9e64", bold = true })
        hl(0, "SnacksPickerGitStatus", { fg = "#c0caf5" })
      end

      paint_git_status()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("lazyvim_explorer_git_colors", { clear = true }),
        callback = paint_git_status,
      })
    end,
  },
}

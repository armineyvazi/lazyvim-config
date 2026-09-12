-- Personal cheat-sheet picker (Snacks UI), switchable from <leader>sk.
-- Does not replace <leader>sC (Commands).

local M = {}

local sheets_dir = function()
  return vim.fn.stdpath("config") .. "/cheatsheets"
end

---@class CheatItem
---@field text string
---@field key string
---@field action string
---@field section string
---@field notes string
---@field sheet string
---@field file string
---@field preview snacks.picker.preview.Ctx|table

---Parse markdown tables: | Key | Action | Notes? |
---@param file string
---@return CheatItem[]
local function parse_sheet(file)
  local lines = vim.fn.readfile(file)
  local sheet = vim.fn.fnamemodify(file, ":t:r")
  local section = sheet
  local items = {}
  local in_table = false

  for _, line in ipairs(lines) do
    local h = line:match("^##%s+(.+)")
    if h then
      section = vim.trim(h)
      in_table = false
    elseif line:match("^|%s*[-:|%s]+|$") then
      in_table = true
    elseif in_table and line:match("^|") then
      local cols = {}
      for col in line:gmatch("|([^|]*)") do
        local c = vim.trim(col):gsub("^`+", ""):gsub("`+$", "")
        cols[#cols + 1] = c
      end
      -- skip header rows
      local key = cols[1] or ""
      local action = cols[2] or ""
      if key ~= "" and not key:lower():match("^key") and action ~= "" and not action:lower():match("^action") then
        local notes = cols[3] or ""
        local preview_lines = {
          "# " .. section,
          "",
          "- **Keys:** `" .. key .. "`",
          "- **Action:** " .. action,
        }
        if notes ~= "" then
          preview_lines[#preview_lines + 1] = "- **Notes:** " .. notes
        end
        preview_lines[#preview_lines + 1] = ""
        preview_lines[#preview_lines + 1] = "_Sheet:_ `" .. sheet .. "`"
        preview_lines[#preview_lines + 1] = ""
        preview_lines[#preview_lines + 1] = "Enter → run / copy hint · `<a-k>` keymaps · `<a-s>` sheets · `<a-e>` edit"

        items[#items + 1] = {
          text = table.concat({ key, action, section, notes, sheet }, " "),
          key = key,
          action = action,
          section = section,
          notes = notes,
          sheet = sheet,
          file = file,
          preview = {
            text = table.concat(preview_lines, "\n"),
            ft = "markdown",
          },
        }
      end
    elseif line:match("^#") or line:match("^%s*$") or line:match("^%-%-%-") then
      in_table = false
    end
  end
  return items
end

---@return string[]
function M.list_sheets()
  local dir = sheets_dir()
  if vim.fn.isdirectory(dir) == 0 then
    return {}
  end
  local files = vim.fn.glob(dir .. "/*.md", false, true)
  table.sort(files)
  return files
end

---@param file? string
---@return CheatItem[]
function M.load_items(file)
  local files = file and { file } or M.list_sheets()
  local items = {}
  for _, f in ipairs(files) do
    if vim.fn.filereadable(f) == 1 then
      vim.list_extend(items, parse_sheet(f))
    end
  end
  return items
end

local function feed_keys(keys)
  -- Only auto-feed simple leader/normal sequences; otherwise notify.
  local normalized = keys
    :gsub("<leader>", vim.g.mapleader or " ")
    :gsub("<Leader>", vim.g.mapleader or " ")
  -- Avoid feeding multi-key docs like "]d` / `[d"
  if keys:find("/") or keys:find("·") or keys:find(",") then
    vim.notify(keys .. "  →  use the binding manually", vim.log.levels.INFO, { title = "Cheat Sheet" })
    return
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(normalized, true, false, true), "t", false)
end

function M.open_cheatsheet(opts)
  opts = opts or {}
  local file = opts.file
  local items = M.load_items(file)
  if #items == 0 then
    vim.notify("No cheat sheet entries. Add markdown tables under cheatsheets/", vim.log.levels.WARN)
    return
  end

  local title = file and ("Cheat Sheet · " .. vim.fn.fnamemodify(file, ":t:r")) or "Cheat Sheet"

  Snacks.picker({
    title = title,
    items = items,
    format = function(item)
      local k = item.key or ""
      local a = item.action or ""
      local s = item.section or ""
      return {
        { string.format("%-18s", k), "SnacksPickerLabel" },
        { " " },
        { a, "SnacksPickerDir" },
        { "  " },
        { s, "Comment" },
      }
    end,
    preview = "preview",
    layout = { preset = "default", preview = true },
    confirm = function(picker, item)
      picker:close()
      if item and item.key then
        feed_keys(item.key)
      end
    end,
    actions = {
      to_keymaps = function(picker)
        picker:close()
        M.open_keymaps()
      end,
      pick_sheet = function(picker)
        picker:close()
        M.open_sheet_picker()
      end,
      edit_sheet = function(picker)
        local item = picker:current()
        local path = (item and item.file) or (M.list_sheets()[1])
        picker:close()
        if path then
          vim.cmd.edit(path)
        end
      end,
    },
    win = {
      input = {
        keys = {
          ["<a-k>"] = { "to_keymaps", mode = { "n", "i" }, desc = "Switch to Keymaps" },
          ["<a-s>"] = { "pick_sheet", mode = { "n", "i" }, desc = "Switch Cheat Sheet" },
          ["<a-e>"] = { "edit_sheet", mode = { "n", "i" }, desc = "Edit Cheat Sheet" },
        },
      },
    },
  })
end

function M.open_sheet_picker()
  local files = M.list_sheets()
  if #files == 0 then
    vim.notify("No sheets in cheatsheets/", vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ":t:r")
    items[#items + 1] = {
      text = name,
      file = f,
      preview = {
        text = table.concat(vim.fn.readfile(f), "\n"),
        ft = "markdown",
      },
    }
  end

  -- Also offer "All sheets"
  table.insert(items, 1, {
    text = "∗ all sheets",
    file = nil,
    preview = {
      text = "Show entries from every markdown file in cheatsheets/",
      ft = "markdown",
    },
  })

  Snacks.picker({
    title = "Cheat Sheets",
    items = items,
    format = "text",
    preview = "preview",
    confirm = function(picker, item)
      picker:close()
      M.open_cheatsheet({ file = item and item.file or nil })
    end,
    actions = {
      to_keymaps = function(picker)
        picker:close()
        M.open_keymaps()
      end,
    },
    win = {
      input = {
        keys = {
          ["<a-k>"] = { "to_keymaps", mode = { "n", "i" }, desc = "Switch to Keymaps" },
        },
      },
    },
  })
end

function M.open_keymaps()
  -- Prefer Snacks keymaps (same UI family as Commands). Works even if FzfLua owns defaults.
  Snacks.picker.keymaps({
    actions = {
      to_cheatsheet = function(picker)
        picker:close()
        M.open_cheatsheet()
      end,
      pick_sheet = function(picker)
        picker:close()
        M.open_sheet_picker()
      end,
    },
    win = {
      input = {
        keys = {
          ["<a-c>"] = { "to_cheatsheet", mode = { "n", "i" }, desc = "Personal Cheat Sheet" },
          ["<a-s>"] = { "pick_sheet", mode = { "n", "i" }, desc = "Switch Cheat Sheet" },
          -- keep LazyVim defaults
          ["<a-g>"] = { "toggle_global", mode = { "n", "i" }, desc = "Toggle Global Keymaps" },
          ["<a-b>"] = { "toggle_buffer", mode = { "n", "i" }, desc = "Toggle Buffer Keymaps" },
        },
      },
    },
  })
end

return M

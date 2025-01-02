local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  icons_enabled = true,
  icon = "",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

local encoding = {
  "encoding",
  icons_enabled = true,
  icon = "",
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

-- cool function for progress
local function progress()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local line_ratio = 100 * current_line / total_lines
  return "󱞇 " .. tostring(math.floor(line_ratio)) .. "%%"
end

local function spaces()
  return "󱁐 " .. vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
end

local function lsp_status()
  local lsp_ok, lsp = pcall(require, "lsp-status")
  if lsp_ok then
    return lsp.status()
  else
    return ""
  end
end

local function ledger_run(Account)
  local ledger_file = os.getenv("HOME") .. "/.org/finances/2025.ledger"
  if vim.fn.executable("ledger") == 1 and vim.fn.filereadable(ledger_file) then
    local cmd = string.format("ledger -f %s bal %s", ledger_file, Account)
    local handle = io.popen(cmd)
    if handle then
      local output = handle:read("*a")
      handle:close()
      local balance = output:match("([%d%.]+) EUR")
      if balance then
        return balance
      end
    end
  end
  return ""
end

local ledger_cache = {
  bnp = "0",
  revolut = "0",
  savings = "0",
  last_update = 0,
}

local function ledger()
  if vim.bo.filetype ~= "ledger" then
    return ""
  end
  local current_time = os.time()
  if current_time - ledger_cache.last_update >= 1 or ledger_cache.last_update == 0 then
    ledger_cache.bnp = ledger_run("Bank:Checking:BNP")
    ledger_cache.revolut = ledger_run("Bank:Checking:Revolut")
    ledger_cache.savings = ledger_run("Bank:Saving")
    ledger_cache.last_update = current_time
  end
  return string.format("%s | %s | %s", ledger_cache.revolut, ledger_cache.bnp, ledger_cache.savings)
end

local function buffer_number()
  local listed_buffers = vim.tbl_filter(function(a)
    return vim.fn.buflisted(a) == 1
  end, vim.api.nvim_list_bufs())
  local current_buffer = vim.api.nvim_get_current_buf()
  for k, v in pairs(listed_buffers) do
    if current_buffer == v then
      return tostring(k)
    end
  end
  return ""
end

local catppuccin = require "catppuccin.utils.lualine" ()
local catppuccin_colors = require("catppuccin.palettes").get_palette()
catppuccin.normal.c.bg = catppuccin_colors.base

lualine.setup({
  options = {
    icons_enabled = true,
    theme = catppuccin,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },

    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = {},
    lualine_c = { branch, diagnostics, buffer_number, "filename" },
    lualine_x = { ledger, diff, spaces, encoding, "filetype", "copilot", lsp_status, progress, },
    lualine_y = {},
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

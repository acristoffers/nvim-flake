local lualine = require("lualine")

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
  return "󱁐 " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function lsp_status()
  local lsp_ok, lsp = pcall(require, "lsp-status")
  if lsp_ok then
    return lsp.status()
  else
    return ""
  end
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diagnostics },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { diff, spaces, encoding, "filetype" },
    lualine_z = { lsp_status, progress, "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

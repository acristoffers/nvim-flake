local ok, formatter = pcall(require, "formatter")
if not ok then
  return
end

local futil = require("formatter.util")

local function stylua()
  return {
    exe = "stylua",
    args = {
      "--indent-type", "Spaces",
      "--line-endings", "Unix",
      "--indent-width", "2",
      "--search-parent-directories",
      "--sort-requires",
      "--stdin-filepath",
      futil.escape_path(futil.get_current_buffer_file_path()),
      "--",
      "-",
    },
    stdin = true,
  }
end

local function tidy()
  return {
    exe = "tidy",
    args = {
      "-quiet",
      "-xml",
      "--indent auto",
      "--indent-spaces 2",
      "--vertical-space yes",
      "--tidy-mark no",
      "--wrap 100",
    },
    stdin = true,
    try_node_exe = true,
  }
end

local function mdformat()
  return {
    exe = "mdformat",
    args = {
      "--wrap", "100",
      "--end-of-line", "lf",
      "--number",
    },
    stdin = false,
  }
end

local function black()
  return {
    exe = "black",
    args = {
      "-q",
      "-l", "100",
      "--stdin-filename", futil.escape_path(futil.get_current_buffer_file_name()),
      "-"
    },
    stdin = true,
  }
end

local function wbproto_beautifier()
  return {
    exe = "wbproto-beautifier",
    stdin = true,
  }
end

local function ledger_beautifier()
  return {
    exe = "ledger-beautifier",
    stdin = true,
  }
end

local function yamlfmt()
  local default = require("formatter.filetypes.yaml").yamlfmt()
  default.args = {
    "-in",
    "-formatter",
    "retain_line_breaks_single=true,eof_newline=true,include_document_start=true,line_ending=lf,trim_trailing_whitespace=true"
  }
  return default
end

formatter.setup({
  filetype = {
    c = require("formatter.filetypes.c").clangformat,
    cpp = require("formatter.filetypes.cpp").clangformat,
    fish = require("formatter.filetypes.fish").fishindent,
    html = tidy,
    javascript = require("formatter.filetypes.javascript").clangformat,
    json = require("formatter.filetypes.json").jq,
    ledger = ledger_beautifier,
    lua = stylua,
    markdown = mdformat,
    nix = require("formatter.filetypes.nix").nixpkgs_fmt,
    python = black,
    sh = require("formatter.filetypes.sh").shfmt,
    toml = require("formatter.filetypes.toml").taplo,
    wbproto = wbproto_beautifier,
    xhtml = tidy,
    xml = tidy,
    yaml = yamlfmt,
  },
})

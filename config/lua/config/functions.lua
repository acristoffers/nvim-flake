-- This file contains all global functions

function SetTab(n)
  vim.opt.shiftwidth = n
  vim.opt.tabstop = n
  vim.opt.softtabstop = n
end

--------------------------------------------------------------------------------
--                                                                            --
--                                Paste Motion                                --
--                                                                            --
--------------------------------------------------------------------------------

vim.cmd([[
function PasteMotion()
  set opfunc=v:lua.PasteMotion
  return 'g@'
endfunction
]])

---@diagnostic disable-next-line: unused-local
function _G.PasteMotion(type)
  vim.cmd([[normal gpP]])
end

--------------------------------------------------------------------------------
--                                                                            --
--                              Center Selection                              --
--                                                                            --
--------------------------------------------------------------------------------

function CenterSelection()
  local startPos = vim.fn.getpos("'<")
  local endPos = vim.fn.getpos("'>")
  local startLine = startPos[2]
  local endLine = endPos[2]
  local middleLine = math.floor((startLine + endLine) / 2)
  vim.api.nvim_win_set_cursor(0, { middleLine, 0 })
  vim.cmd("normal! zz")
  vim.fn.setpos("'<", startPos)
  vim.fn.setpos("'>", endPos)
  vim.cmd("normal! gv")
end

--------------------------------------------------------------------------------
--                                                                            --
--                         Move to Center of Selection                        --
--                                                                            --
--------------------------------------------------------------------------------

function MoveToCenterOfSelection()
  local startPos = vim.fn.getpos("'<")
  local endPos = vim.fn.getpos("'>")
  local startLine = startPos[2]
  local endLine = endPos[2]
  local middleLine = math.floor((startLine + endLine) / 2)
  vim.api.nvim_win_set_cursor(0, { middleLine, 0 })
end

--------------------------------------------------------------------------------
--                                                                            --
--                                Eval Lua Code                               --
--                                                                            --
--------------------------------------------------------------------------------

function EvalLuaExpression()
  local startPos = vim.fn.getpos("'<")
  local endPos = vim.fn.getpos("'>")
  local selection = vim.api.nvim_buf_get_text(0, startPos[2] - 1, startPos[3] - 1, endPos[2] - 1, endPos[3], {})
  local output = {}
  local orig_print = print
  print = function(...)
    local args = { ... }
    local message = table.concat(vim.tbl_map(tostring, args), "\t")
    table.insert(output, message)
  end
  local chunk = loadstring("print(" .. selection[1] .. ")")
  local ok, _ = pcall(function()
    if chunk then
      chunk()
    end
  end)
  print = orig_print
  if ok then
    vim.api.nvim_buf_set_text(0, startPos[2] - 1, startPos[3] - 1, endPos[2] - 1, endPos[3], output)
  else
    local notfiy_ok, notify = pcall(require, "notify")
    if notfiy_ok then
      notify.notify("Could not run code", vim.log.levels.ERROR, {})
    else
      print("Could not run code")
    end
  end
end

function EvalLua()
  local startPos = vim.fn.getpos("'<")
  local endPos = vim.fn.getpos("'>")
  local selection = vim.api.nvim_buf_get_text(0, startPos[2] - 1, startPos[3] - 1, endPos[2] - 1, endPos[3], {})
  local chunk = loadstring(selection[1])
  local ok, _ = pcall(function()
    if not chunk then
      return ""
    else
      return chunk()
    end
  end)
  if not ok then
    local notfiy_ok, notify = pcall(require, "notify")
    if notfiy_ok then
      notify.notify("Could not run code", vim.log.levels.ERROR, {})
    else
      print("Could not run code")
    end
  end
end

--------------------------------------------------------------------------------
--                                                                            --
--                              Select Identifier                             --
--                                                                            --
--------------------------------------------------------------------------------

function SelectIdentifier()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local len = string.len(vim.api.nvim_get_current_line())
  local s = vim.api.nvim_win_get_cursor(0)[2]
  local e = vim.api.nvim_win_get_cursor(0)[2] + 1
  local regex = vim.regex("^[a-zA-Z0-9_-]\\+$")

  while regex:match_line(0, line, s, e) do
    s = s - 1
    if s < 0 then
      break
    end
  end
  s = s + 1

  while regex:match_line(0, line, s, e) do
    e = e + 1
    if e > len then
      break
    end
  end
  e = e - 2

  vim.api.nvim_buf_set_mark(0, "<", line + 1, s, {})
  vim.api.nvim_buf_set_mark(0, ">", line + 1, e, {})
  vim.cmd([[normal! gv]])
end

--------------------------------------------------------------------------------
--                                                                            --
--                           Select Tree-Sitter Node                          --
--                                                                            --
--------------------------------------------------------------------------------

function NamedNodeAroundCursor(node_names)
  local parser = vim.treesitter.get_parser()
  local tree = parser:trees()[1]
  local root = tree:root()

  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_row = cursor[1] - 1
  local cursor_col = cursor[2]

  local closest_node = root:named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

  while closest_node and closest_node:id() ~= root:id() do
    if vim.tbl_contains(node_names, closest_node:type()) then
      return closest_node
    end
    closest_node = closest_node:parent()
  end

  return nil
end

function NamedNodeAfterCursor(node_names)
  local parser = vim.treesitter.get_parser()
  local tree = parser:trees()[1]
  local root = tree:root()

  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_row = cursor[1] - 1
  local cursor_col = cursor[2]

  local function walk_children(node)
    if node then
      local sr, sc, _, _ = node:range()
      local is_after = (sr > cursor_row) or (sr == cursor_row and sc > cursor_col)

      if is_after and vim.tbl_contains(node_names, node:type()) then
        return node
      end

      for _, child in pairs(node:named_children()) do
        local n = walk_children(child)
        if n then
          return n
        end
      end
    end

    return nil
  end

  return walk_children(root)
end

function NamedNodeSnipe(node_names)
  local node = NamedNodeAroundCursor(node_names)
  if node == nil then
    node = NamedNodeAfterCursor(node_names)
  end
  if node then
    local ls, cs, le, ce = node:range()
    -- gv is going to use the last visual mode, which may be a visual-line mode, especially after
    -- InsertLedgerEntry. This creates a "normal" visual mode to ensure that gv becomes a normal
    -- visual mode too.
    vim.cmd([[normal! v0]])
    vim.api.nvim_buf_set_mark(0, "<", ls + 1, cs, {})
    vim.api.nvim_buf_set_mark(0, ">", le + 1, ce - 1, {})
    vim.cmd([[normal! gv]])
  end
end

--------------------------------------------------------------------------------
--                                                                            --
--                              Ledger Utilities                              --
--                                                                            --
--------------------------------------------------------------------------------

local function get_date()
  -- Get the current date
  local year, month = os.date("%Y"), os.date("%m")
  -- Ask the user for input
  local input = vim.fn.input("Date (YYYY/MM/DD): ")
  -- If the input is empty, return today's date
  if input == nil or input == "" then
    return os.date("%Y/%m/%d")
    -- If input is a number, return that day of the current month
  elseif tonumber(input) ~= nil then
    return string.format("%04d/%02d/%02d", year, month, tonumber(input))
    -- If the input is a date in ISO format, return that date
  else
    return input
  end
end

function InsertLedgerEntry()
  local date = get_date()
  local label = vim.fn.input("Label: ")
  local last_match = vim.fn.search(label, "bcnW")
  if last_match == 0 then
    local default_entry = {
      "",
      date .. " * " .. label,
      "    Expenses:Other                                 0 EUR",
      "    Bank:Checking:Revolut",
    }
    vim.api.nvim_buf_set_lines(0, -1, -1, false, default_entry)
  else
    vim.api.nvim_win_set_cursor(0, { last_match, 0 })
    vim.fn.setreg("a", date)
    vim.cmd([[normal! yipGpOj_viW"ap]])
  end
  vim.cmd([[normal! Gvipozz0]])
end

--------------------------------------------------------------------------------
--                                                                            --
--                            Unicode Normalization                           --
--                                                                            --
--------------------------------------------------------------------------------

function NormalizeBuferUTF8Canonical()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local tmpfile = vim.fn.tempname()
  vim.fn.writefile(lines, tmpfile)

  local cmd = "uconv -t utf-8 --canon " .. tmpfile
  local handle = io.popen(cmd)
  if handle == nil then
    return
  end
  local result = handle:read("*a")
  handle:close()

  local normalized_lines = vim.split(result, "\n")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, normalized_lines)

  vim.fn.delete(tmpfile)
end

function SaveNormalizedUTF8()
  vim.opt["fileencoding"] = "utf-8"
  NormalizeBuferUTF8Canonical()
  vim.cmd([[silent write]])
end

vim.api.nvim_create_user_command("NormalizeBufferNFC", NormalizeBuferUTF8Canonical, {})

--------------------------------------------------------------------------------
--                                                                            --
--                                XML Functions                               --
--                                                                            --
--------------------------------------------------------------------------------

local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
if ok then
  local function pack(...)
    return { n = select("#", ...), ... }
  end

  local function find_parent_node_by_type(type)
    local node = ts_utils.get_node_at_cursor()
    if not node then
      return
    end

    while node do
      local node_type = node:type()
      print(node_type)
      if node_type == type then
        return node
      end
      node = node:parent()
    end
  end

  local function select_node(node, inner)
    local start_row, start_col, end_row, end_col = ts_utils.get_vim_range(pack(node:range()))
    local p = inner and 1 or 0

    vim.api.nvim_buf_set_mark(0, "<", start_row, start_col - 1, {})
    vim.api.nvim_buf_set_mark(0, ">", end_row, end_col - 1 - p, {})
    vim.cmd([[normal! gv]])
  end

  function SelectXmlAttribute(inner)
    local node = find_parent_node_by_type("Attribute")
    if node then
      select_node(node, inner)
    end
  end

  function SelectXmlAttributeName()
    local node = find_parent_node_by_type("Attribute")
    if not node then
      return
    end

    local name = nil
    for child in node:iter_children() do
      if child:type() == "Name" then
        name = child
        break
      end
    end

    select_node(name, true)
  end
end

--------------------------------------------------------------------------------
--                                                                            --
--                      Better LSP Code Actions/Quickfix                      --
--                                                                            --
--------------------------------------------------------------------------------

local ok_telescope, _ = pcall(require, "telescope")
if ok_telescope then
  local action_state = require("telescope.actions.state")
  local actions = require("telescope.actions")
  local conf = require("telescope.config").values
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")

  local function transform_diagnostics(nvim_diagnostics)
    local lsp_diagnostics = {}
    for _, d in ipairs(nvim_diagnostics) do
      table.insert(lsp_diagnostics, {
        range = {
          start = { line = d.lnum, character = d.col },
          ["end"] = { line = d.end_lnum, character = d.end_col },
        },
        message = d.message,
        severity = d.severity,
        code = d.code,
        source = d.source,
      })
    end
    return lsp_diagnostics
  end

  local function apply_action_in_document(selected_action)
    local diagnostics = transform_diagnostics(vim.diagnostic.get(0))
    local params = {
      textDocument = vim.lsp.util.make_text_document_params(),
      context = { diagnostics = diagnostics },
    }

    for _, diagnostic in ipairs(diagnostics) do
      params.range = diagnostic.range
      local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
      if results == nil then
        goto continue
      end
      for client_id, result in pairs(results) do
        if result.result then
          for _, action in ipairs(result.result) do
            if action.title == selected_action.title then
              if action.edit or type(action.command) == "table" then
                if action.edit then
                  local offset_encoding = vim.lsp.get_client_by_id(client_id).offset_encoding
                  vim.lsp.util.apply_workspace_edit(action.edit, offset_encoding)
                  return apply_action_in_document(selected_action)
                end
                if action.command then
                  vim.lsp.buf.execute_command(action.command)
                  return apply_action_in_document(selected_action)
                end
              end
            end
          end
        end
      end
      ::continue::
    end
  end

  function GetCodeActionsAndApplyGlobally()
    local diagnostics = transform_diagnostics(vim.diagnostic.get(0))
    local params = {
      textDocument = vim.lsp.util.make_text_document_params(),
      range = vim.lsp.util.make_range_params().range,
      context = { diagnostics = diagnostics },
    }

    vim.lsp.buf_request_all(0, "textDocument/codeAction", params, function(results)
      local flat_results = {}
      for _, result in pairs(results) do
        if result.result then
          for _, action in ipairs(result.result) do
            table.insert(flat_results, action)
          end
        end
      end

      if #flat_results > 0 then
        pickers
          .new({}, {
            prompt_title = "Code Actions",
            finder = finders.new_table({
              results = flat_results,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.title or "Unnamed action",
                  ordinal = entry.title or "",
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, _)
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                apply_action_in_document(selection.value)
              end)
              return true
            end,
          })
          :find()
      else
        print("No code actions available")
      end
    end)
  end
end

--------------------------------------------------------------------------------
--                                                                            --
--                             Non-wrapping bnext                             --
--                                                                            --
--------------------------------------------------------------------------------

function NonWrappingGoToBuffer(n)
  local listed_buffers = vim.tbl_filter(function(a)
    return vim.fn.buflisted(a) == 1
  end, vim.api.nvim_list_bufs())
  local index = math.min(n, #listed_buffers)
  vim.api.nvim_set_current_buf(listed_buffers[index])
end

--------------------------------------------------------------------------------
--                                                                            --
--                                Snack picker                                --
--                                                                            --
--------------------------------------------------------------------------------

function PickProject()
  local items = require("project_nvim").get_recent_projects()
  local opts = {
    prompt = "Switch Project",
    format_item = function(item)
      return vim.fn.fnamemodify(item, ":t") .. " (" .. item .. ")"
    end,
  }
  local on_choice = function(selected_item)
    local result = require("project_nvim.project").set_pwd(selected_item, "Snack")
    if result then
      require("snacks.picker").files()
    else
      vim.notify("Failed to changed PWD to " .. selected_item)
    end
  end
  require("snacks.picker").select(items, opts, on_choice):show()
end

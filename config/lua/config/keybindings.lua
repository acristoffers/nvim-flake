local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --

keymap("n", "gp", "`<v`>", opts)

keymap("n", "<A-p>", function()
  vim.fn.setreg("+", vim.api.nvim_buf_get_name(0))
end, opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<cr>", opts)
keymap("n", "<C-Down>", ":resize -2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- "Tabs" navigation
keymap("n", "gt", ":bn<cr>", opts)
keymap("n", "gT", ":bp<cr>", opts)

-- Snipe last
keymap("n", "<A-g>", "$,", opts)

-- Snipe first
keymap("n", "<A-f>", "0;", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<cr>==", opts)
keymap("v", "<A-k>", ":m .-2<cr>==", opts)
keymap("n", "<A-j>", ":m .+1<cr>==", opts)
keymap("n", "<A-k>", ":m .-2<cr>==", opts)

-- Navigate tags
keymap("n", "g[", ":pop<cr>", opts)
keymap("n", "g]", ":tag<cr>", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<cr>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<cr>gv-gv", opts)

-- Moving around buffers --
keymap("n", "<A-1>", ":BufferLineGoToBuffer 1<cr>", opts)
keymap("n", "<A-2>", ":BufferLineGoToBuffer 2<cr>", opts)
keymap("n", "<A-3>", ":BufferLineGoToBuffer 3<cr>", opts)
keymap("n", "<A-4>", ":BufferLineGoToBuffer 4<cr>", opts)
keymap("n", "<A-5>", ":BufferLineGoToBuffer 5<cr>", opts)
keymap("n", "<A-6>", ":BufferLineGoToBuffer 6<cr>", opts)
keymap("n", "<A-7>", ":BufferLineGoToBuffer 7<cr>", opts)
keymap("n", "<A-8>", ":BufferLineGoToBuffer 8<cr>", opts)
keymap("n", "<A-9>", ":BufferLineGoToBuffer 9<cr>", opts)

-- Paste with motion --
keymap("n", "gP", "PasteMotion()", { silent = true, expr = true })
keymap("x", "gP", "PasteMotion()", { silent = true, expr = true })

-- Centered screen movements --
keymap("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
keymap("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
keymap("n", "n", "nzz", { silent = true, noremap = true })

-- Horizontal center --
keymap("n", "z|", "zszH", { silent = true, noremap = true })

-- Remove surrounding function call --
keymap("n", "<space>dSF", "yiabgPaF", { silent = true, noremap = false })

-- Text Object for the entire buffer --
keymap("v", "aG", ":<C-U>normal! ggVG$<cr>", { silent = true, noremap = true })
keymap("v", "iG", ":<C-U>normal! ggVG$<cr>", { silent = true, noremap = true })
keymap("v", "ag", ":<C-U>normal! ggVG$<cr>", { silent = true, noremap = true })
keymap("v", "ig", ":<C-U>normal! ggVG$<cr>", { silent = true, noremap = true })
keymap("o", "aG", ":normal VaG$<cr>", { silent = true, noremap = false })
keymap("o", "iG", ":normal ViG$<cr>", { silent = true, noremap = false })
keymap("o", "ag", ":normal VaG$<cr>", { silent = true, noremap = false })
keymap("o", "ig", ":normal ViG$<cr>", { silent = true, noremap = false })

-- Text Object for Identifier (o in Doom Emacs) --
keymap("v", "ao", ":lua SelectIdentifier()<cr>", { silent = true, noremap = true })
keymap("v", "io", ":lua SelectIdentifier()<cr>", { silent = true, noremap = true })
keymap("o", "ao", ":lua SelectIdentifier()<cr>", { silent = true, noremap = true })
keymap("o", "io", ":lua SelectIdentifier()<cr>", { silent = true, noremap = true })

-- LSP is having trouble defining those --
local telescope = ':lua require"telescope.builtin"'
keymap("n", "gd", telescope .. ".lsp_definitions()<cr>", opts)
keymap("n", "gi", telescope .. ".lsp_implementations()<cr>", opts)
keymap("n", "gr", telescope .. ".lsp_references()<cr>", opts)
keymap("n", "gD", ":lua vim.lsp.buf.declaration()<cr>", opts)
keymap("n", "K", ":lua vim.lsp.buf.hover()<cr>", opts)
keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<cr>", opts)
keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<cr>", opts)
keymap("n", "]d", ":lua vim.diagnostic.goto_next()<cr>", opts)

-- Center selection
keymap("v", "zZ", ":lua CenterSelection()<cr>", opts)

--- Eval math (actually lua)
keymap("v", "<leader>r", ":lua EvalLua()<cr>", opts)

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

function EvalLua()
  local startPos = vim.fn.getpos("'<")
  local endPos = vim.fn.getpos("'>")
  local selection = vim.api.nvim_buf_get_text(0, startPos[2] - 1, startPos[3] - 1, endPos[2] - 1, endPos[3], {})
  local result = string.format("%s", vim.fn.eval(selection[1]))
  vim.api.nvim_buf_set_text(0, startPos[2] - 1, startPos[3] - 1, endPos[2] - 1, endPos[3], { result })
end

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
  e = e - 3

  vim.api.nvim_buf_set_mark(0, "<", line + 1, s, {})
  vim.api.nvim_buf_set_mark(0, ">", line + 1, e, {})
  vim.cmd([[ normal! gv ]])
end

vim.cmd([[
function PasteMotion()
  set opfunc=v:lua.PasteMotion
  return 'g@'
endfunction
]])

---@diagnostic disable-next-line: unused-local
function _G.PasteMotion(type)
  vim.cmd([[ normal gpP ]])
end

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
    vim.api.nvim_buf_set_mark(0, "<", ls + 1, cs, {})
    vim.api.nvim_buf_set_mark(0, ">", le + 1, ce - 2, {})
    vim.cmd([[ normal! gv ]])
  end
end

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
    vim.cmd([[ normal! yipGpOj_viW"ap ]])
  end
  vim.cmd([[ normal! Gvipozz0 ]])
end

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
vim.api.nvim_create_user_command("NormalizeBufferNFC", NormalizeBuferUTF8Canonical, {})

function SaveNormalizedUTF8()
  vim.opt["fileencoding"] = "utf-8"
  NormalizeBuferUTF8Canonical()
  vim.cmd([[ silent write ]])
end

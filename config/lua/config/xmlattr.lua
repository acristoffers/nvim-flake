local ts_utils = require 'nvim-treesitter.ts_utils'

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

  vim.api.nvim_buf_set_mark(0, '<', start_row, start_col - 1, {})
  vim.api.nvim_buf_set_mark(0, '>', end_row, end_col - 1 - p, {})
  vim.cmd [[ normal! gv ]]
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

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("v", "ix", ":lua SelectXmlAttribute(true)<CR>", opts)
vim.api.nvim_set_keymap("o", "ix", ":<C-u>lua SelectXmlAttribute(true)<CR>", opts)
vim.api.nvim_set_keymap("v", "ax", ":lua SelectXmlAttribute(false)<CR>", opts)
vim.api.nvim_set_keymap("o", "ax", ":<C-u>lua SelectXmlAttribute(false)<CR>", opts)

vim.api.nvim_set_keymap("v", "iX", ":lua SelectXmlAttributeName()<CR>", opts)
vim.api.nvim_set_keymap("o", "iX", ":<C-u>lua SelectXmlAttributeName()<CR>", opts)
vim.api.nvim_set_keymap("v", "aX", ":lua SelectXmlAttributeName()<CR>", opts)
vim.api.nvim_set_keymap("o", "aX", ":<C-u>lua SelectXmlAttributeName()<CR>", opts)

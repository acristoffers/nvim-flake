local opts = { noremap = true, silent = true }

local function map(mode, lhs, rhs, desc, base_opts)
  local options = vim.tbl_extend("force", base_opts or opts, { desc = desc })
  vim.keymap.set(mode, lhs, rhs, options)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", "Disable space", opts)
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

map("n", "gp", "`[v`]", "Select last change", opts)

map("n", "<A-p>", function()
  vim.fn.setreg("+", vim.api.nvim_buf_get_name(0))
  print(vim.api.nvim_buf_get_name(0))
end, "Copy file path", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<cr>", "Resize window taller", opts)
map("n", "<C-Down>", ":resize -2<cr>", "Resize window shorter", opts)
map("n", "<C-Left>", ":vertical resize -2<cr>", "Resize window narrower", opts)
map("n", "<C-Right>", ":vertical resize +2<cr>", "Resize window wider", opts)

-- "Tabs" navigation
map("n", "gt", ":bn<cr>", "Next buffer", opts)
map("n", "gT", ":bp<cr>", "Previous buffer", opts)

-- Snipe first
map("n", "<A-f>", "0;", "Snipe first char", opts)

-- Snipe last
map("n", "<A-g>", "$,", "Snipe last char", opts)

-- Insert --
-- Press jk fast to exit insert mode
map("i", "jk", "<ESC>", "Exit insert mode", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", "Indent left (keep selection)", opts)
map("v", ">", ">gv", "Indent right (keep selection)", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<cr>==", "Move selection down", opts)
map("v", "<A-k>", ":m .-2<cr>==", "Move selection up", opts)
map("n", "<A-j>", ":m .+1<cr>==", "Move line down", opts)
map("n", "<A-k>", ":m .-2<cr>==", "Move line up", opts)

-- Navigate tags
map("n", "g[", ":pop<cr>", "Pop tag stack", opts)
map("n", "g]", ":tag<cr>", "Jump to tag", opts)

-- Do not yank on paste
map("v", "p", '"_dP', "Paste without yanking", opts)

-- Visual Block --
-- Move text up and down
map("x", "<A-j>", ":move '>+1<cr>gv-gv", "Move block down", opts)
map("x", "<A-k>", ":move '<-2<cr>gv-gv", "Move block up", opts)

-- Moving around buffers --
map("n", "<A-1>", ":bf|lua NonWrappingGoToBuffer(1)<cr>", "Go to buffer 1", opts)
map("n", "<A-2>", ":bf|lua NonWrappingGoToBuffer(2)<cr>", "Go to buffer 2", opts)
map("n", "<A-3>", ":bf|lua NonWrappingGoToBuffer(3)<cr>", "Go to buffer 3", opts)
map("n", "<A-4>", ":bf|lua NonWrappingGoToBuffer(4)<cr>", "Go to buffer 4", opts)
map("n", "<A-5>", ":bf|lua NonWrappingGoToBuffer(5)<cr>", "Go to buffer 5", opts)
map("n", "<A-6>", ":bf|lua NonWrappingGoToBuffer(6)<cr>", "Go to buffer 6", opts)
map("n", "<A-7>", ":bf|lua NonWrappingGoToBuffer(7)<cr>", "Go to buffer 7", opts)
map("n", "<A-8>", ":bf|lua NonWrappingGoToBuffer(8)<cr>", "Go to buffer 8", opts)
map("n", "<A-9>", ":bf|lua NonWrappingGoToBuffer(9)<cr>", "Go to buffer 9", opts)

-- Paste with motion --
map("n", "gP", "PasteMotion()", "Paste with motion", { silent = true, expr = true })
map("x", "gP", "PasteMotion()", "Paste with motion", { silent = true, expr = true })

-- Centered screen movements --
map("n", "<C-u>", "<C-u>zz", "Half-page up (center)", { silent = true, noremap = true })
map("n", "<C-d>", "<C-d>zz", "Half-page down (center)", { silent = true, noremap = true })
map("n", "n", "nzz", "Next search (center)", { silent = true, noremap = true })

-- Horizontal center --
map("n", "z|", "zszH", "Center horizontally", { silent = true, noremap = true })

-- Text Object for the entire buffer --
map("v", "aG", ":<C-U>normal! ggVG$<cr>", "Select entire buffer", { silent = true, noremap = true })
map("v", "iG", ":<C-U>normal! ggVG$<cr>", "Select entire buffer", { silent = true, noremap = true })
map("v", "ag", ":<C-U>normal! ggVG$<cr>", "Select entire buffer", { silent = true, noremap = true })
map("v", "ig", ":<C-U>normal! ggVG$<cr>", "Select entire buffer", { silent = true, noremap = true })
map("o", "aG", ":normal VaG$<cr>", "Select entire buffer", { silent = true, noremap = false })
map("o", "iG", ":normal ViG$<cr>", "Select entire buffer", { silent = true, noremap = false })
map("o", "ag", ":normal VaG$<cr>", "Select entire buffer", { silent = true, noremap = false })
map("o", "ig", ":normal ViG$<cr>", "Select entire buffer", { silent = true, noremap = false })

-- Text Object for Identifier (o in Doom Emacs) --
map("v", "ao", ":lua SelectIdentifier()<cr>", "Select identifier", { silent = true, noremap = true })
map("v", "io", ":lua SelectIdentifier()<cr>", "Select identifier", { silent = true, noremap = true })
map("o", "ao", ":lua SelectIdentifier()<cr>", "Select identifier", { silent = true, noremap = true })
map("o", "io", ":lua SelectIdentifier()<cr>", "Select identifier", { silent = true, noremap = true })

-- Center selection
map("v", "zZ", ":lua CenterSelection()<cr>", "Center selection", opts)
map("v", "zn", ":lua MoveToCenterOfSelection()<cr>", "Center selection line", opts)

--- Eval math (actually lua)
map("v", "<leader>r", ":lua EvalLuaExpression()<cr>", "Eval Lua expression", opts)
map("v", "<leader>R", ":lua EvalLua()<cr>", "Eval Lua", opts)

--- XML text-objects
if SelectXmlAttribute ~= nil then
  vim.api.nvim_set_keymap("v", "ix", ":lua SelectXmlAttribute(true)<CR>", opts)
  vim.api.nvim_set_keymap("o", "ix", ":<C-u>lua SelectXmlAttribute(true)<CR>", opts)
  vim.api.nvim_set_keymap("v", "ax", ":lua SelectXmlAttribute(false)<CR>", opts)
  vim.api.nvim_set_keymap("o", "ax", ":<C-u>lua SelectXmlAttribute(false)<CR>", opts)

  vim.api.nvim_set_keymap("v", "iX", ":lua SelectXmlAttributeName()<CR>", opts)
  vim.api.nvim_set_keymap("o", "iX", ":<C-u>lua SelectXmlAttributeName()<CR>", opts)
  vim.api.nvim_set_keymap("v", "aX", ":lua SelectXmlAttributeName()<CR>", opts)
  vim.api.nvim_set_keymap("o", "aX", ":<C-u>lua SelectXmlAttributeName()<CR>", opts)
end

--- Gitsigns Select Hunk
map({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>", "Select hunk", {})

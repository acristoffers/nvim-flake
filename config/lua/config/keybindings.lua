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
  print(vim.api.nvim_buf_get_name(0))
end, opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<cr>", opts)
keymap("n", "<C-Down>", ":resize -2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- "Tabs" navigation
keymap("n", "gt", ":bn<cr>", opts)
keymap("n", "gT", ":bp<cr>", opts)

-- Snipe first
keymap("n", "<A-f>", "0;", opts)

-- Snipe last
keymap("n", "<A-g>", "$,", opts)

-- Insert --
-- Press jk fast to exit insert mode
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

-- Do not yank on paste
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<cr>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<cr>gv-gv", opts)

-- Moving around buffers --
keymap("n", "<A-1>", ":bf|lua NonWrappingGoToBuffer(1)<cr>", opts)
keymap("n", "<A-2>", ":bf|lua NonWrappingGoToBuffer(2)<cr>", opts)
keymap("n", "<A-3>", ":bf|lua NonWrappingGoToBuffer(3)<cr>", opts)
keymap("n", "<A-4>", ":bf|lua NonWrappingGoToBuffer(4)<cr>", opts)
keymap("n", "<A-5>", ":bf|lua NonWrappingGoToBuffer(5)<cr>", opts)
keymap("n", "<A-6>", ":bf|lua NonWrappingGoToBuffer(6)<cr>", opts)
keymap("n", "<A-7>", ":bf|lua NonWrappingGoToBuffer(7)<cr>", opts)
keymap("n", "<A-8>", ":bf|lua NonWrappingGoToBuffer(8)<cr>", opts)
keymap("n", "<A-9>", ":bf|lua NonWrappingGoToBuffer(9)<cr>", opts)

-- Paste with motion --
keymap("n", "gP", "PasteMotion()", { silent = true, expr = true })
keymap("x", "gP", "PasteMotion()", { silent = true, expr = true })

-- Centered screen movements --
keymap("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
keymap("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
keymap("n", "n", "nzz", { silent = true, noremap = true })

-- Horizontal center --
keymap("n", "z|", "zszH", { silent = true, noremap = true })

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
local ok, _ = pcall(require, "telescope.builtin")
if ok then
  local telescope_require = ':lua require"telescope.builtin"'
  keymap("n", "gd", telescope_require .. ".lsp_definitions()<cr>", opts)
  keymap("n", "gi", telescope_require .. ".lsp_implementations()<cr>", opts)
  keymap("n", "gr", telescope_require .. ".lsp_references()<cr>", opts)
  keymap("n", "gD", ":lua vim.lsp.buf.declaration()<cr>", opts)
  keymap("n", "K", ":lua vim.lsp.buf.hover()<cr>", opts)
  keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<cr>", opts)
  keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<cr>", opts)
  keymap("n", "]d", ":lua vim.diagnostic.goto_next()<cr>", opts)
end

-- Center selection
keymap("v", "zZ", ":lua CenterSelection()<cr>", opts)

--- Eval math (actually lua)
keymap("v", "<leader>r", ":lua EvalLuaExpression()<cr>", opts)
keymap("v", "<leader>R", ":lua EvalLua()<cr>", opts)

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

{ pkgs, git-plugins }:

with pkgs.vimPlugins;
with git-plugins;
[
  ChatGPT-nvim
  alpha-nvim
  bufdelete-nvim
  bufferline-nvim
  catppuccin-nvim
  cmp-buffer
  cmp-cmdline
  cmp-nvim-lsp
  cmp-nvim-lsp-signature-help
  cmp-nvim-lua
  cmp-path
  cmp_luasnip
  comment-nvim
  copilot-cmp
  copilot-lua
  copilot-lualine
  dressing-nvim
  firenvim
  flutter-tools-nvim
  formatter-nvim
  friendly-snippets
  git-blame-nvim
  git-conflict-nvim
  git-worktree
  gitsigns-nvim
  hop-nvim
  indent-blankline-nvim
  julia-vim
  lsp-colors-nvim
  lsp-setup
  lsp-status-nvim
  lualine-lsp-progress
  lualine-nvim
  luasnip
  markdown-nvim
  marks-nvim
  mini-nvim
  neoconf-nvim
  neogit
  nui-nvim
  nvim-autopairs
  nvim-cmp
  nvim-colorizer-lua
  nvim-fzf
  nvim-lspconfig
  nvim-notify
  nvim-surround
  nvim-tree-lua
  nvim-treesitter-context
  nvim-treesitter-textobjects
  nvim-treesitter.withAllGrammars
  nvim-ts-context-commentstring
  nvim-web-devicons
  orgmode
  ouroboros
  plenary-nvim
  project-nvim
  rainbow-delimiters-nvim
  rust-tools-nvim
  targets-vim # packed with useful text-objects
  telescope-git-file-history
  telescope-media-files-nvim
  telescope-nvim
  telescope-ui-select-nvim
  text-case-nvim
  trim-nvim
  trouble-nvim
  undotree
  vim-fish
  vim-fugitive
  vim-illuminate
  vim-indent-object
  vim-lion
  vim-repeat
  vim-sneak
  vim-tridactyl
  virtual-types-nvim
  which-key-nvim
]
{pkgs, inputs}:

with pkgs; [
  bat
  black
  cmake-language-server
  delta
  dune_3
  elmPackages.elm-language-server
  emmet-ls
  erlang-ls
  fd
  flutter
  fzf
  git
  gopls
  html-tidy
  icu.dev
  inputs.ledger-formatter.packages.${system}.default
  inputs.matlab-lsp.packages.${system}.default
  inputs.wbproto-beautifier.packages.${system}.default
  # inputs.zls.inputs.zig-overlay.packages.${system}.master
  # inputs.zls.packages.${system}.default
  kotlin-language-server
  llvmPackages_19.clang-tools
  lua-language-server
  luajitPackages.luarocks
  marksman
  mdformat
  nil
  nodePackages_latest.bash-language-server
  nodePackages_latest.eslint
  nodePackages_latest.typescript-language-server
  nodePackages_latest.vim-language-server
  nushell
  ocamlPackages.ocaml-lsp
  ocamlPackages.ocamlformat
  pyright
  ripgrep
  rubyPackages.solargraph
  rust-analyzer
  silver-searcher
  stdenv.cc
  stylua
  taplo
  texlab
  tree-sitter
  typescript
  vscode-langservers-extracted
  yaml-language-server
]

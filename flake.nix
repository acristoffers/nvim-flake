{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;

    zls.url = github:acristoffers/zls;
    zls.inputs.nixpkgs.follows = "nixpkgs";
    zls.inputs.flake-utils.follows = "flake-utils";

    matlab-lsp.url = github:acristoffers/matlab-lsp;
    matlab-lsp.inputs.nixpkgs.follows = "nixpkgs";
    matlab-lsp.inputs.flake-utils.follows = "flake-utils";

    lsp-setup-git.url = github:junnplus/lsp-setup.nvim;
    lsp-setup-git.flake = false;
  };

  outputs = { self, flake-utils, nixpkgs, lsp-setup-git, zls, matlab-lsp }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        my-config = pkgs.vimUtils.buildVimPlugin {
          name = "my-config";
          src = ./config;
        };
        lsp-setup = pkgs.vimUtils.buildVimPlugin {
          name = "lsp-setup";
          src = lsp-setup-git;
        };
        neovim = pkgs.neovim.override
          {
            viAlias = true;
            vimAlias = true;
            withNodeJs = true;
            withPython3 = true;
            withRuby = true;
            extraMakeWrapperArgs = "--prefix PATH : ${pkgs.lib.makeBinPath runtimeDependencies}";
            configure = {
              customRC = ''
                lua require("init")
              '';
              packages.all = with pkgs.vimPlugins; {
                start = [
                  FixCursorHold-nvim
                  alpha-nvim
                  bufdelete-nvim
                  bufferline-nvim
                  cmp-buffer
                  cmp-cmdline
                  cmp-nvim-lsp
                  cmp-nvim-lsp-signature-help
                  cmp-nvim-lua
                  cmp-path
                  cmp_luasnip
                  dracula-nvim
                  dressing-nvim
                  flutter-tools-nvim
                  formatter-nvim
                  friendly-snippets
                  gitsigns-nvim
                  harpoon
                  hop-nvim
                  indent-blankline-nvim
                  julia-vim
                  lsp-colors-nvim
                  lsp-setup
                  lsp-status-nvim
                  lualine-lsp-progress
                  lualine-nvim
                  luasnip
                  marks-nvim
                  mini-nvim
                  my-config
                  neoconf-nvim
                  neodev-nvim
                  nvim-autopairs
                  nvim-cmp
                  nvim-fzf
                  nvim-lspconfig
                  nvim-notify
                  nvim-surround
                  nvim-treesitter-context
                  nvim-treesitter-textobjects
                  nvim-treesitter.withAllGrammars
                  nvim-ts-context-commentstring
                  nvim-ts-rainbow2
                  nvim-web-devicons
                  orgmode
                  plenary-nvim
                  popup-nvim
                  rust-tools-nvim
                  telescope-media-files-nvim
                  telescope-nvim
                  telescope-ui-select-nvim
                  undotree
                  vim-better-whitespace
                  vim-fish
                  vim-illuminate
                  vim-indent-object
                  vim-lion
                  vim-matchup
                  vim-repeat
                  vim-sneak
                  vim-textobj-user
                  vim-tridactyl
                  vimtex
                  virtual-types-nvim
                  which-key-nvim
                ];
                opt = [ ];
              };
            };
          };
        runtimeDependencies = with pkgs; [
          clang-tools
          cmake-language-server
          elmPackages.elm-language-server
          emmet-ls
          erlang-ls
          fd
          fzf
          gopls
          kotlin-language-server
          lua-language-server
          marksman
          matlab-lsp
          nodePackages_latest.bash-language-server
          nodePackages_latest.pyright
          nodePackages_latest.typescript-language-server
          nodePackages_latest.vim-language-server
          nodePackages_latest.vls
          ocamlPackages.ocaml-lsp
          ripgrep
          rnix-lsp
          rubyPackages.solargraph
          rust-analyzer
          texlab
          vscode-langservers-extracted
          zls
        ];
      in
      rec {
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
        packages.default = neovim;
        apps.default = {
          type = "app";
          program = "${packages.default}/bin/nvim";
        };
      }
    );
}

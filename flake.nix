{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    zls.url = "github:acristoffers/zls";
    zls.inputs.nixpkgs.follows = "nixpkgs";
    zls.inputs.flake-utils.follows = "flake-utils";

    matlab-lsp.url = "github:acristoffers/matlab-lsp";
    matlab-lsp.inputs.nixpkgs.follows = "nixpkgs";
    matlab-lsp.inputs.flake-utils.follows = "flake-utils";

    wbproto-beautifier.url = "github:acristoffers/wbproto-beautifier";
    wbproto-beautifier.inputs.nixpkgs.follows = "nixpkgs";
    wbproto-beautifier.inputs.flake-utils.follows = "flake-utils";

    lsp-setup-git.url = "github:junnplus/lsp-setup.nvim";
    lsp-setup-git.flake = false;

    ouroboros-git.url = "github:jakemason/ouroboros.nvim";
    ouroboros-git.flake = false;
  };

  outputs = { self, flake-utils, nixpkgs, lsp-setup-git, zls, matlab-lsp, wbproto-beautifier, ouroboros-git }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        personal-config = pkgs.vimUtils.buildVimPlugin {
          name = "personal-config";
          src = ./config;
        };
        lsp-setup = pkgs.vimUtils.buildVimPlugin {
          name = "lsp-setup";
          src = lsp-setup-git;
        };
        ouroboros = pkgs.vimUtils.buildVimPlugin {
          name = "ouroboros";
          src = ouroboros-git;
        };
        neovim = pkgs.neovim.override {
          viAlias = true;
          vimAlias = true;
          withNodeJs = true;
          withPython3 = true;
          withRuby = true;
          extraMakeWrapperArgs = "--prefix PATH : ${pkgs.lib.makeBinPath runtimeDependencies}";
          configure = {
            customRC = ''lua require("init")'';
            packages.all = with pkgs.vimPlugins; {
              start = [
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
                comment-nvim
                dracula-nvim
                dressing-nvim
                flutter-tools-nvim
                formatter-nvim
                friendly-snippets
                git-blame-nvim
                git-conflict-nvim
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
                marks-nvim
                mini-nvim
                neoconf-nvim
                nvim-autopairs
                nvim-cmp
                nvim-fzf
                nvim-lspconfig
                nvim-notify
                nvim-surround
                nvim-tree-lua
                nvim-treesitter-context
                nvim-treesitter-textobjects
                nvim-treesitter.withAllGrammars
                nvim-ts-context-commentstring
                orgmode
                ouroboros
                personal-config
                plenary-nvim
                project-nvim
                rainbow-delimiters-nvim
                rust-tools-nvim
                telescope-media-files-nvim
                telescope-nvim
                telescope-ui-select-nvim
                text-case-nvim
                undotree
                vim-fish
                vim-illuminate
                vim-indent-object
                vim-lion
                vim-matchup
                vim-repeat
                vim-sneak
                vim-tridactyl
                vimtex
                virtual-types-nvim
                which-key-nvim
              ];
            };
          };
        };
        runtimeDependencies = with pkgs; [
          bat
          black
          clang-tools
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
          kotlin-language-server
          lua-language-server
          marksman
          matlab-lsp.packages.${system}.default
          mdformat
          nil
          nodePackages_latest.bash-language-server
          nodePackages_latest.eslint
          nodePackages_latest.typescript-language-server
          nodePackages_latest.vim-language-server
          nodePackages_latest.vls
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
          vscode-langservers-extracted
          wbproto-beautifier.packages.${system}.default
          yaml-language-server
          zls.packages.${system}.default
        ];
      in
      rec {
        formatter = pkgs.nixpkgs-fmt;
        packages.default = neovim;
        apps.default = {
          type = "app";
          program = "${packages.default}/bin/nvim";
        };
        devShell = pkgs.mkShell {
          packages = [ neovim ] ++ runtimeDependencies;
        };
      }
    );
}

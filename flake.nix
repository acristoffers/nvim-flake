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

    copilot-lualine-git.url = "github:AndreM222/copilot-lualine";
    copilot-lualine-git.flake = false;

    git-worktree-git.url = "github:awerebea/git-worktree.nvim/handle_changes_in_telescope_api";
    git-worktree-git.flake = false;

    telescope-git-file-history-git.url = "github:isak102/telescope-git-file-history.nvim";
    telescope-git-file-history-git.flake = false;
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        personal-config = pkgs.vimUtils.buildVimPlugin {
          name = "personal-config";
          src = ./config;
        };
        lsp-setup = pkgs.vimUtils.buildVimPlugin {
          name = "lsp-setup";
          src = inputs.lsp-setup-git;
        };
        ouroboros = pkgs.vimUtils.buildVimPlugin {
          name = "ouroboros";
          src = inputs.ouroboros-git;
        };
        git-worktree = pkgs.vimUtils.buildVimPlugin {
          name = "git-worktree.nvim";
          src = inputs.git-worktree-git;
        };
        copilot-lualine = pkgs.vimUtils.buildVimPlugin {
          name = "copilot-lualine.nvim";
          src = inputs.copilot-lualine-git;
        };
        telescope-git-file-history = pkgs.vimUtils.buildVimPlugin {
          name = "telescope-git-file-history.nvim";
          src = inputs.telescope-git-file-history-git;
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
                ChatGPT-nvim
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
                copilot-cmp
                copilot-lua
                copilot-lualine
                dracula-nvim
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
                marks-nvim
                mini-nvim
                neoconf-nvim
                neogit
                nui-nvim
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
                vim-illuminate
                vim-indent-object
                vim-lion
                vim-repeat
                vim-sneak
                vim-tridactyl
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
          inputs.matlab-lsp.packages.${system}.default
          inputs.wbproto-beautifier.packages.${system}.default
          inputs.zls.packages.${system}.default
          kotlin-language-server
          lua-language-server
          marksman
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
          typescript
          vscode-langservers-extracted
          yaml-language-server
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

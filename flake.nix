{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";

    zls.url = "github:acristoffers/zls";
    zls.inputs.nixpkgs.follows = "nixpkgs";

    matlab-lsp.url = "github:acristoffers/matlab-lsp";
    matlab-lsp.inputs.nixpkgs.follows = "nixpkgs";
    matlab-lsp.inputs.flake-utils.follows = "flake-utils";

    wbproto-beautifier.url = "github:acristoffers/wbproto-beautifier";
    wbproto-beautifier.inputs.nixpkgs.follows = "nixpkgs";
    wbproto-beautifier.inputs.flake-utils.follows = "flake-utils";

    ledger-formatter.url = "github:acristoffers/ledger-formatter";
    ledger-formatter.inputs.nixpkgs.follows = "nixpkgs";
    ledger-formatter.inputs.flake-utils.follows = "flake-utils";

    ledger-nvim.url = "github:acristoffers/ledger.nvim";

    wbproto.url = "github:acristoffers/tree-sitter-wbproto";
    wbproto.flake = false;

    git-worktree-git.url = "github:awerebea/git-worktree.nvim/handle_changes_in_telescope_api";
    git-worktree-git.flake = false;

    gitlab-nvim.url = "github:acristoffers/gitlab.nvim?ref=feature/nix-and-configurable-server-path";

    snacks-git.url = "github:folke/snacks.nvim";
    snacks-git.flake = false;
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        ledger-nvim = inputs.ledger-nvim.packages.${system}.default;
        gitlab-nvim = inputs.gitlab-nvim.packages.${system}.default;
        gitlab-nvim-server = inputs.gitlab-nvim.packages.${system}.gitlab-nvim-server;
        git-plugins = with pkgs.vimUtils; with inputs; {
          git-worktree = buildVimPlugin { name = "git-worktree.nvim"; src = git-worktree-git; doCheck = false; };
          snacks = buildVimPlugin { name = "snacks.nvim"; src = snacks-git; doCheck = false; };
        };
        personal-config = pkgs.vimUtils.buildVimPlugin {
          name = "personal-config";
          src = ./config;
          doCheck = false;
        };
        neovim = pkgs.neovim.override {
          viAlias = true;
          vimAlias = true;
          withNodeJs = true;
          withPython3 = true;
          withRuby = true;
          extraMakeWrapperArgs = "--prefix PATH : ${pkgs.lib.makeBinPath runtimeDependencies}";
          configure = {
            customRC = ''
              lua <<EOF
                vim.g.gitlab_server_bin = "${gitlab-nvim-server}/bin/gitlab.nvim"
                dofile("${import ./nix/treesitter.nix { inherit pkgs; inherit inputs; }}")
                require("alan")
              EOF
            '';
            packages.all = {
              start = [
                git-plugins.git-worktree
                git-plugins.snacks
                gitlab-nvim
                ledger-nvim
                personal-config
                pkgs.vimPlugins.advanced-git-search-nvim
                pkgs.vimPlugins.blink-cmp
                pkgs.vimPlugins.catppuccin-nvim
                pkgs.vimPlugins.codecompanion-nvim
                pkgs.vimPlugins.diffview-nvim
                pkgs.vimPlugins.dressing-nvim
                pkgs.vimPlugins.firenvim
                pkgs.vimPlugins.formatter-nvim
                pkgs.vimPlugins.git-conflict-nvim
                pkgs.vimPlugins.gitsigns-nvim
                pkgs.vimPlugins.hop-nvim
                pkgs.vimPlugins.lualine-lsp-progress
                pkgs.vimPlugins.lualine-nvim
                pkgs.vimPlugins.markdown-nvim
                pkgs.vimPlugins.marks-nvim
                pkgs.vimPlugins.markview-nvim
                pkgs.vimPlugins.mini-nvim
                pkgs.vimPlugins.neogit
                pkgs.vimPlugins.nui-nvim
                pkgs.vimPlugins.nvim-colorizer-lua
                pkgs.vimPlugins.nvim-dap
                pkgs.vimPlugins.nvim-dap-ui
                pkgs.vimPlugins.nvim-dap-virtual-text
                pkgs.vimPlugins.nvim-fzf
                pkgs.vimPlugins.nvim-lspconfig
                pkgs.vimPlugins.nvim-nio
                pkgs.vimPlugins.nvim-treesitter-context
                pkgs.vimPlugins.nvim-treesitter-textobjects
                pkgs.vimPlugins.nvim-ts-context-commentstring
                pkgs.vimPlugins.nvim-web-devicons
                pkgs.vimPlugins.orgmode
                pkgs.vimPlugins.plenary-nvim
                # pkgs.vimPlugins.project-nvim
                pkgs.vimPlugins.rainbow-delimiters-nvim
                pkgs.vimPlugins.rustaceanvim
                pkgs.vimPlugins.targets-vim
                pkgs.vimPlugins.text-case-nvim
                pkgs.vimPlugins.trim-nvim
                pkgs.vimPlugins.trouble-nvim
                pkgs.vimPlugins.undotree
                pkgs.vimPlugins.vim-fugitive
                pkgs.vimPlugins.vim-illuminate
                pkgs.vimPlugins.vim-sneak
                pkgs.vimPlugins.vim-tridactyl
                pkgs.vimPlugins.vim-windowswap
                pkgs.vimPlugins.virtual-types-nvim
                pkgs.vimPlugins.which-key-nvim
              ];
            };
          };
        };
        runtimeDependencies = import ./nix/runtime.nix { inherit pkgs; inherit inputs; };
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

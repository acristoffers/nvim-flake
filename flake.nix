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

    ledger-formatter.url = "github:acristoffers/ledger-formatter";
    ledger-formatter.inputs.nixpkgs.follows = "nixpkgs";
    ledger-formatter.inputs.flake-utils.follows = "flake-utils";

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
          doCheck = false;
        };
        git-plugins = with pkgs.vimUtils; with inputs; {
          lsp-setup = buildVimPlugin { name = "lsp-setup"; src = lsp-setup-git; doCheck = false; };
          ouroboros = buildVimPlugin { name = "ouroboros"; src = ouroboros-git; doCheck = false; };
          git-worktree = buildVimPlugin { name = "git-worktree.nvim"; src = git-worktree-git; doCheck = false; };
          copilot-lualine = buildVimPlugin { name = "copilot-lualine.nvim"; src = copilot-lualine-git; doCheck = false; };
          telescope-git-file-history = buildVimPlugin { name = "telescope-git-file-history.nvim"; src = telescope-git-file-history-git; doCheck = false; };
        };
        vim-plugins = import ./nix/start.nix { inherit pkgs; inherit git-plugins; };
        neovim = pkgs.neovim.override {
          viAlias = true;
          vimAlias = true;
          withNodeJs = true;
          withPython3 = true;
          withRuby = true;
          extraMakeWrapperArgs = "--prefix PATH : ${pkgs.lib.makeBinPath runtimeDependencies}";
          configure = {
            customRC = ''lua require("init")'';
            packages.all = {
              start = [ personal-config ] ++ vim-plugins;
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

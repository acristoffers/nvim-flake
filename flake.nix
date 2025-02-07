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
            customRC = ''
            lua <<EOF
            require("init")
            require("lazy").setup({
              spec = {
                {
                  -- lazy changes the rtp, so we have to add it again
                  {
                    "init",
                    dir = "${personal-config}",
                    lazy = false,
                    priority = 1000,
                    config = function()
                      require("config.functions")
                      require("config.options")
                      require("config.autocommands")
                      require("config.keybindings")
                    end,
                  },

                  -- Not lazy
                  {
                    "catppuccin",
                    dir = "${pkgs.vimPlugins.catppuccin-nvim}",
                    lazy = false, -- make sure we load this during startup if it is your main colorscheme
                    priority = 1000, -- make sure to load this before all the other start plugins
                    config = function()
                      vim.cmd([[
                        call setenv("FULL_NIX_SHELL", 1)
                        se nu rnu tabstop=2 shiftwidth=2 smarttab expandtab
                        colorscheme catppuccin
                        highlight CursorLine guibg=#21222C
                      ]])
                    end,
                  },
                  {
                    "alpha-nvim",
                    dir = "${pkgs.vimPlugins.alpha-nvim}",
                    lazy = false, -- make sure we load this during startup if it is your main colorscheme
                    config = function()
                      require("plugins.alpha")
                    end,
                  },

                  -- Lazy after all
                  { "bufdelete"            , event = "VeryLazy", dir = "${pkgs.vimPlugins.bufdelete-nvim}" }       ,
                  { "indent-blankline-nvim", event = "VeryLazy", dir = "${pkgs.vimPlugins.indent-blankline-nvim}" },
                  { "lsp-colors-nvim"      , event = "VeryLazy", dir = "${pkgs.vimPlugins.lsp-colors-nvim}" }      ,
                  { "marks-nvim"           , event = "VeryLazy", dir = "${pkgs.vimPlugins.marks-nvim}" }           ,
                  { "mini-nvim"            , event = "VeryLazy", dir = "${pkgs.vimPlugins.mini-nvim}" }            ,
                  { "neoconf-nvim"         , event = "VeryLazy", dir = "${pkgs.vimPlugins.neoconf-nvim}" }         ,
                  { "neogit"               , event = "VeryLazy", dir = "${pkgs.vimPlugins.neogit}" }               ,
                  { "nui-nvim"             , event = "VeryLazy", dir = "${pkgs.vimPlugins.nui-nvim}" }             ,
                  { "nvim-colorizer-lua"   , event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-colorizer-lua}" }   ,
                  { "nvim-fzf"             , event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-fzf}" }             ,
                  { "nvim-surround"        , event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-surround}" }        ,
                  { "nvim-web-devicons"    , event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-web-devicons}" }    ,
                  { "nvim-tree-lua"        , event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-tree-lua}" }        ,
                  { "ouroboros"            , event = "VeryLazy", dir = "${git-plugins.ouroboros}" }                ,
                  { "targets-vim"          , event = "VeryLazy", dir = "${pkgs.vimPlugins.targets-vim}" }          ,
                  { "text-case-nvim"       , event = "VeryLazy", dir = "${pkgs.vimPlugins.text-case-nvim}" }       ,
                  { "trouble-nvim"         , event = "VeryLazy", dir = "${pkgs.vimPlugins.trouble-nvim}" }         ,
                  { "undotree"             , event = "VeryLazy", dir = "${pkgs.vimPlugins.undotree}" }             ,
                  { "vim-fugitive"         , event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-fugitive}" }         ,
                  { "vim-illuminate"       , event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-illuminate}" }       ,
                  { "vim-indent-object"    , event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-indent-object}" }    ,
                  { "vim-lion"             , event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-lion}" }             ,
                  { "vim-repeat"           , event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-repeat}" }           ,
                  { "vim-sneak"            , event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-sneak}" }            ,
                  { "vim-tridactyl"        , event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-tridactyl}" }        ,
                  { "virtual-types-nvim"   , event = "VeryLazy", dir = "${pkgs.vimPlugins.virtual-types-nvim}" }   ,

                  -- Lazy on require
                  { "plenary", dir = "${pkgs.vimPlugins.plenary-nvim}" },

                  -- Lazy with setup or conditions
                  -- { "julia-vim"      , ft = {"julia"}, dir = "${pkgs.vimPlugins.julia-vim}" }      ,
                  { "rust-tools-nvim", ft = {"rust"} , dir = "${pkgs.vimPlugins.rust-tools-nvim}" },
                  { "vim-fish"       , ft = {"fish"} , dir = "${pkgs.vimPlugins.vim-fish}" }       ,
                  {
                    "lualine",
                    dir = "${pkgs.vimPlugins.lualine-nvim}",
                    event = "VeryLazy",
                    config = function()
                      require("plugins.lualine")
                    end,
                    dependencies = {
                      { "lsp-status", dir = "${pkgs.vimPlugins.lsp-status-nvim}" },
                      { "copilot-lualine", dir = "${git-plugins.copilot-lualine}" },
                      { "lualine-lsp-progress", dir = "${pkgs.vimPlugins.lualine-lsp-progress}" },
                    },
                  },
                  {
                    "nvim-treesitter",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}",
                    config = function()
                      require("plugins.treesitter")
                    end,
                    dependencies = {
                      { "nvim-treesitter-context", dir = "${pkgs.vimPlugins.nvim-treesitter-context}" },
                      { "nvim-treesitter-textobjects", dir = "${pkgs.vimPlugins.nvim-treesitter-textobjects}" },
                      { "nvim-ts-context-commentstring", dir = "${pkgs.vimPlugins.nvim-ts-context-commentstring}" },
                    }
                  },
                  {
                    "luasnip",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.luasnip}",
                    config = function()
                      require("plugins.luasnip")
                    end,
                    dependencies = {
                      { "friendly-snippets", dir = "${pkgs.vimPlugins.friendly-snippets}" },
                    }
                  },
                  {
                    "cmp",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-cmp}",
                    config = function()
                      require("plugins.cmp")
                    end,
                    dependencies = {
                      { "cmp-buffer", dir = "${pkgs.vimPlugins.cmp-buffer}" },
                      { "cmp-cmdline", dir = "${pkgs.vimPlugins.cmp-cmdline}" },
                      { "cmp-nvim-lsp-signature-help", dir = "${pkgs.vimPlugins.cmp-nvim-lsp-signature-help}" },
                      { "cmp-nvim-lua", dir = "${pkgs.vimPlugins.cmp-nvim-lua}" },
                      { "cmp-path", dir = "${pkgs.vimPlugins.cmp-path}" },
                      { "cmp_luasnip", dir = "${pkgs.vimPlugins.cmp_luasnip}" },
                      { "cmp_nvim_lsp", dir = "${pkgs.vimPlugins.cmp-nvim-lsp}" },
                    },
                  },
                  {
                    "lspconfig",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-lspconfig}",
                    config = function()
                      require("plugins.lsp")
                    end,
                    dependencies = {
                      { "copilot-lua", dir = "${pkgs.vimPlugins.copilot-lua}" },
                    }
                  },
                  {
                    "Comment",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.comment-nvim}",
                    config = function()
                      require("plugins.comments")
                    end
                  },
                  {
                    "chatgpt",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.ChatGPT-nvim}",
                    config = function()
                      require("plugins.chatgpt")
                    end
                  },
                  {
                    "dressing-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.dressing-nvim}",
                    config = function()
                      require("plugins.dressing")
                    end
                  },
                  {
                    "firenvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.firenvim}",
                    config = function()
                      require("plugins.firenvim")
                    end
                  },
                  {
                    "flutter-tools-nvim",
                    ft = { "flutter", "dart" },
                    dir = "${pkgs.vimPlugins.flutter-tools-nvim}",
                  },
                  {
                    "formatter-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.formatter-nvim}",
                    config = function()
                      require("plugins.format")
                    end
                  },
                  {
                    "git-conflict-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.git-conflict-nvim}",
                    config = function()
                      require("plugins.git-conflict")
                    end
                  },
                  {
                    "git-worktree",
                    even = "VeryLazy",
                    dir = "${git-plugins.git-worktree}",
                    config = function()
                      require("plugins.other")
                    end
                  },
                  {
                    "gitsigns-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.gitsigns-nvim}",
                    config = function()
                      require("plugins.gitsigns")
                    end
                  },
                  {
                    "which-key-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.which-key-nvim}",
                    config = function()
                      require("plugins.whichkey")
                    end,
                    dependencies = {
                      { "hop-nvim", dir = "${pkgs.vimPlugins.hop-nvim}" },
                    },
                  },
                  {
                    "telescope",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.telescope-nvim}",
                    config = function()
                      require("plugins.telescope")
                    end,
                    dependencies = {
                      { "telescope-frecency-nvim", dir = "${pkgs.vimPlugins.telescope-frecency-nvim}" },
                      { "telescope-fzf-native-nvim", dir = "${pkgs.vimPlugins.telescope-fzf-native-nvim}" },
                      { "telescope-git-file-history", dir = "${git-plugins.telescope-git-file-history}" },
                      { "telescope-media-files-nvim", dir = "${pkgs.vimPlugins.telescope-media-files-nvim}" },
                      { "telescope-ui-select-nvim", dir = "${pkgs.vimPlugins.telescope-ui-select-nvim}" },
                    }
                  },
                  {
                    "rainbow-delimiters-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.rainbow-delimiters-nvim}",
                    config = function()
                      require("plugins.rainbow")
                    end
                  },
                  {
                    "nvim-autopairs",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-autopairs}",
                    config = function()
                      require("plugins.autopairs")
                    end
                  },
                  {
                    "project-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.project-nvim}",
                    config = function()
                     require("plugins.project")
                    end
                  },
                  {
                    "nvim-notify",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-notify}",
                    config = function()
                      require("plugins.notify")
                    end
                  },
                  {
                    "orgmode",
                    ft = "org",
                    dir = "${pkgs.vimPlugins.orgmode}",
                    config = function()
                      require("plugins.orgmode")
                    end
                  },
                  {
                    "trim-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.trim-nvim}",
                    config = function()
                      require("plugins.trim")
                    end
                  },
                  {
                    "markdown-nvim",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.markdown-nvim}",
                    config = function()
                      require("plugins.markdown")
                    end
                  },
                  {
                    "lsp-setup",
                    event = "VeryLazy",
                    dir = "${git-plugins.lsp-setup}",
                    config = function()
                      require("plugins.lsp")
                    end
                  },
                },
              },
              defaults = { lazy = true },
              checker = { enabled = false },
            })
            EOF
            '';
            packages.all = {
              start = [ personal-config pkgs.vimPlugins.lazy-nvim ];
              opt = vim-plugins;
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

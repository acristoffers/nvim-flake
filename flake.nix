{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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

    project-nvim.url = "github:acristoffers/project.nvim";
    project-nvim.flake = false;

    tree-sitter-matlab.url = "github:acristoffers/tree-sitter-matlab";
    tree-sitter-matlab.flake = false;

    lsp-setup-git.url = "github:junnplus/lsp-setup.nvim";
    lsp-setup-git.flake = false;

    codex-nvim.url = "github:johnseth97/codex.nvim";
    codex-nvim.flake = false;

    copilot-lualine-git.url = "github:AndreM222/copilot-lualine";
    copilot-lualine-git.flake = false;

    git-worktree-git.url = "github:awerebea/git-worktree.nvim/handle_changes_in_telescope_api";
    git-worktree-git.flake = false;

    snacks-git.url = "github:folke/snacks.nvim";
    snacks-git.flake = false;
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        ledger-nvim = inputs.ledger-nvim.packages.${system}.default;
        personal-config = pkgs.vimUtils.buildVimPlugin {
          name = "personal-config";
          src = ./config;
          doCheck = false;
        };
        git-plugins = with pkgs.vimUtils; with inputs; {
          lsp-setup = buildVimPlugin { name = "lsp-setup"; src = lsp-setup-git; doCheck = false; };
          git-worktree = buildVimPlugin { name = "git-worktree.nvim"; src = git-worktree-git; doCheck = false; };
          copilot-lualine = buildVimPlugin { name = "copilot-lualine.nvim"; src = copilot-lualine-git; doCheck = false; };
          snacks = buildVimPlugin { name = "snacks.nvim"; src = snacks-git; doCheck = false; };
          project-nvim = buildVimPlugin { name = "project.nvim"; src = project-nvim; doCheck = false; };
          codex-nvim = buildVimPlugin { name = "codex.nvim"; src = codex-nvim; doCheck = false; };
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
              vim.g.tsmatlabrev = '${inputs.tree-sitter-matlab.rev}'
              require("init")
              require("lazy").setup({
                spec = {
                  -- lazy changes the rtp, so we have to add it again
                  {
                    "init",
                    dir = "${personal-config}",
                    lazy = false,
                    priority = 1000,
                    config = function()
                      require("config.autocommands")
                      require("config.functions")
                      require("config.keybindings")
                      require("config.options")
                    end,
                  },
                  {
                    "copilot",
                    dir = "${pkgs.vimPlugins.copilot-lua}",
                    opts = {
                      lsp_binary = "${pkgs.copilot-language-server}/bin/copilot-language-server",
                    },
                    lazy = false,
                    priority = 1000,
                  },

                  -- Not lazy
                  {
                    "catppuccin",
                    dir = "${pkgs.vimPlugins.catppuccin-nvim}",
                    lazy = false, -- make sure we load this during startup if it is your main colorscheme
                    priority = 1000, -- make sure to load this before all the other start plugins
                    config = function()
                      require("plugins.catppuccin")
                      vim.cmd([[
                        call setenv("FULL_NIX_SHELL", 1)
                        se nu rnu tabstop=2 shiftwidth=2 smarttab expandtab
                        colorscheme catppuccin
                        highlight CursorLine guibg=#21222C
                      ]])
                    end,
                  },
                  {
                    "nvim-treesitter",
                    lazy = false,
                    dir = "${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}",
                    config = function() require("plugins.treesitter") end,
                    dependencies = {
                      { "nvim-treesitter-context", dir = "${pkgs.vimPlugins.nvim-treesitter-context}" },
                      { "nvim-treesitter-textobjects", dir = "${pkgs.vimPlugins.nvim-treesitter-textobjects}" },
                      { "nvim-ts-context-commentstring", dir = "${pkgs.vimPlugins.nvim-ts-context-commentstring}" },
                    }
                  },
                  {
                    "rainbow-delimiters-nvim",
                    lazy = false,
                    dir = "${pkgs.vimPlugins.rainbow-delimiters-nvim}",
                    config = function()
                      require("plugins.rainbow")
                    end,
                    dependencies = { "nvim-treesitter" }
                  },
                  {
                    "firenvim",
                    lazy = false,
                    dir = "${pkgs.vimPlugins.firenvim}",
                    config = function()
                      require("plugins.firenvim")
                    end
                  },
                  { "text-case.nvim", lazy=false, dir = "${pkgs.vimPlugins.text-case-nvim}" },
                  { "vim-windowswap", lazy=false, dir = "${pkgs.vimPlugins.vim-windowswap}" },

                  -- Lazy on require
                  { "plenary", dir = "${pkgs.vimPlugins.plenary-nvim}" },
                  { "marks", dir = "${pkgs.vimPlugins.marks-nvim}"},
                  { "colorizer", dir = "${pkgs.vimPlugins.nvim-colorizer-lua}" },
                  { "neogit", dir = "${pkgs.vimPlugins.neogit}" },

                  -- Lazy on condition
                  {
                    "codex-nvim",
                    cmd = { 'Codex', 'CodexToggle' },
                    dir = "${git-plugins.codex-nvim}",
                    keys = {},
                    opts = {
                      keymaps     = {
                        toggle = nil, -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
                        quit = '<C-c>', -- Keybind to close the Codex window (default: Ctrl + q)
                      },         -- Disable internal default keymap (<leader>cc -> :CodexToggle)
                      border      = 'rounded',  -- Options: 'single', 'double', or 'rounded'
                      width       = 0.8,        -- Width of the floating window (0.0 to 1.0)
                      height      = 0.8,        -- Height of the floating window (0.0 to 1.0)
                      model       = nil,        -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
                      autoinstall = true,       -- Automatically install the Codex CLI if not found
                      panel       = true,       -- Open Codex in a side-panel (vertical split) instead of floating window
                      use_buffer  = false,      -- Capture Codex stdout into a normal buffer instead of a terminal buffer
                    },
                  },
                  { "nvim-fzf", event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-fzf}" },
                  { "targets-vim", event = "VeryLazy", dir = "${pkgs.vimPlugins.targets-vim}" },
                  { "trouble-nvim", event = "VeryLazy", dir = "${pkgs.vimPlugins.trouble-nvim}" },
                  { "undotree", event = "VeryLazy", dir = "${pkgs.vimPlugins.undotree}" },
                  { "rustaceanvim", ft = {"rust"} , dir = "${pkgs.vimPlugins.rustaceanvim}" },
                  { "vim-fish", ft = {"fish"}, dir = "${pkgs.vimPlugins.vim-fish}" },
                  { "vim-illuminate", event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-illuminate}" },
                  { "vim-sneak", event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-sneak}" },
                  { "vim-tridactyl", event = "VeryLazy", dir = "${pkgs.vimPlugins.vim-tridactyl}" },
                  { "virtual-types-nvim", event = "VeryLazy", dir = "${pkgs.vimPlugins.virtual-types-nvim}" },
                  { "nvim-web-devicons", event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-web-devicons}" },
                  { "nvim-nio", event = "VeryLazy", dir = "${pkgs.vimPlugins.nvim-nio}" },
                  {
                    "nvim-dap",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-dap}",
                    config = function()
                      local dap = require("dap")
                      dap.adapters.gdb = { type = "executable", command = "gdb", args = { "--quiet", "--interpreter=dap" } }
                      dap.configurations.c = {
                        {
                          name = "Attach to process",
                          type = "gdb",
                          request = "attach",
                          pid = require("dap.utils").pick_process,
                        },
                        {
                          name = 'Run executable (GDB)',
                          type = 'gdb',
                          request = 'launch',
                          program = function()
                              local path = vim.fn.input({
                                prompt = 'Path to executable: ',
                                default = vim.fn.getcwd() .. '/',
                                completion = 'file',
                              })
                              return (path and path ~= "") and path or dap.ABORT
                          end,
                        },
                        {
                          name = 'Run executable with arguments (GDB)',
                          type = 'gdb',
                          request = 'launch',
                          program = function()
                            local path = vim.fn.input({
                              prompt = 'Path to executable: ',
                              default = vim.fn.getcwd() .. '/',
                              completion = 'file',
                            })
                            return (path and path ~= "") and path or dap.ABORT
                          end,
                          args = function()
                            local args_str = vim.fn.input({ prompt = 'Arguments: ' })
                            return vim.split(args_str, ' +')
                          end,
                        },
                      }
                      dap.configurations.cpp = dap.configurations.c
                    end
                  },
                  {
                    "nvim-nvim-dap-virtual-text",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-dap-virtual-text}",
                    dependencies = { "nvim-dap" },
                    config = function()
                      require"nvim-dap-virtual-text".setup()
                    end
                  },
                  {
                    "nvim-dap-ui",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-dap-ui}",
                    dependencies = {"nvim-dap", "nvim-nio"},
                    config = function()
                      local dap, dapui = require("dap"), require("dapui")
                      dapui.setup()
                      dap.listeners.before.attach.dapui_config = dapui.open
                      dap.listeners.before.launch.dapui_config = dapui.open
                      dap.listeners.before.event_terminated.dapui_config = dapui.close
                      dap.listeners.before.event_exited.dapui_config = dapui.close
                    end
                    },
                  {
                    "ledger-nvim",
                    ft = { "ledger" },
                    dir = "${ledger-nvim}",
                    config = function()
                      require("ledger").setup({
                        bank_accounts = {"Bank:Checking:BNP", "Bank:Checking:Revolut", "Bank:Checking:NuBank", "Bank:Checking:Wise"},
                      })
                    end
                  },
                  {
                    "snacks.nvim",
                    priority = 999,
                    lazy = false,
                    dir = "${git-plugins.snacks}",
                    opts = {
                      bigfile      = { enabled = true },
                      bufdelete    = { enabled = true },
                      dashboard    = { enabled = true, example = "doom" },
                      explorer     = { enabled = true, replace_netrw = true },
                      git          = { enabled = true },
                      indent       = { enabled = true },
                      input        = { enabled = true },
                      notifier     = { enabled = true },
                      notify       = { enabled = true },
                      picker       = { enabled = true, layout = { preset = "telescope" } },
                      quickfile    = { enabled = true },
                      scope        = { enabled = true },
                      scroll       = { enabled = false },
                      statuscolumn = { enabled = true },
                      toggle       = { enabled = true },
                      words        = { enabled = true },
                    },
                  },
                  {
                    "mini.nvim",
                    priority = 1000,
                    lazy = false,
                    dir = "${pkgs.vimPlugins.mini-nvim}",
                    config = function()
                      require("mini.ai").setup({ n_lines = 500 })
                      require("mini.align").setup()
                      require("mini.comment").setup()
                      require("mini.icons").setup()
                      require("mini.move").setup()
                      require("mini.pairs").setup()
                      require("mini.snippets").setup()
                      require("mini.splitjoin").setup()
                      require("mini.surround").setup({
                        respect_selection_type = true,
                        custom_surroundings = {
                          ['c'] = {
                            input = { '`().-()`' },
                            output = { left = '`', right = '`' }
                          },
                          ['C'] = {
                            input = { '```().-()```' },
                            output = { left = '```', right = '```' }
                          },
                          ['m'] = {
                            input = { '\\%(().-()\\%)' },
                            output = { left = '\\( ', right = ' \\)' }
                          },
                        }
                      })
                    end
                  },
                  {
                    "blink.cmp",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.blink-cmp}",
                    config = function()
                      require("plugins.blink")
                    end
                  },
                  {
                    "advanced-git-search-nvim",
                    cmd = { "AdvancedGitSearch" },
                    dir = "${pkgs.vimPlugins.advanced-git-search-nvim}",
                    config = function()
                      require("advanced_git_search.snacks").setup()
                    end,
                    dependencies = { "vim-fugitive" },
                  },
                  {
                    "vim-fugitive",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.vim-fugitive}",
                  },
                  {
                    "lspconfig",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.nvim-lspconfig}",
                    config = function()
                      require("plugins.lsp")
                    end,
                  },
                  {
                    "lualine",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.lualine-nvim}",
                    config = function()
                      require("plugins.lualine")
                    end,
                    dependencies = {
                      { "copilot-lualine", dir = "${git-plugins.copilot-lualine}" },
                      { "lualine-lsp-progress", dir = "${pkgs.vimPlugins.lualine-lsp-progress}" },
                    },
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
                    event = "VeryLazy",
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
                    "project-nvim",
                    event = "VeryLazy",
                    dir = "${git-plugins.project-nvim}",
                    -- dir = "${pkgs.vimPlugins.project-nvim}",
                    config = function()
                     require("plugins.project")
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
                    ft = { "markdown" },
                    dir = "${pkgs.vimPlugins.markdown-nvim}",
                    config = function()
                      require("plugins.markdown")
                    end
                  },
                  {
                    "which-key",
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
                    "codecompanion",
                    event = "VeryLazy",
                    dir = "${pkgs.vimPlugins.codecompanion-nvim}",
                    opts = {
                      strategies = {
                        chat = {
                          name = "openai",
                          model = "gpt-5",
                        },
                        inline = {
                          name = "copilot",
                          model = "gpt-5",
                        },
                      },
                    },
                    dependencies = {
                      "plenary",
                      "nvim-treesitter",
                    }
                  },
                  {
                    "markview-nvim",
                    lazy = false,
                    priority = 49,
                    dir = "${pkgs.vimPlugins.markview-nvim}",
                    config = function ()
                      require'markview'.setup {
                        preview = {
                          filetypes = { "markdown", "codecompanion" },
                          ignore_buftypes = {},
                          icon_provider = "mini",
                        }
                      }
                    end
                  }
                },
                defaults = { lazy = true },
                checker = { enabled = false },
              })
              EOF
            '';
            packages.all = with pkgs.vimPlugins; {
              start = [
                personal-config
                lazy-nvim
                copilot-lua
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

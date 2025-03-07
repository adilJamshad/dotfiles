return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
      require("scrollbar.handlers.gitsigns").setup()
    end
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "python",
        "go",
        "typescript",
        "scss",
        "tsx"
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require "configs.dap"
    end,
  },
  { "akinsho/git-conflict.nvim",
    event="VeryLazy",
    version = "*",
    config = true,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
    },
    config = function()
      require("auto-session").setup {
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        session_lens = {
          load_on_setup = true, -- Initialize on startup (requires Telescope)
          theme_conf = { -- Pass through for Telescope theme options
            -- layout_config = { -- As one example, can change width/height of picker
            --   width = 0.8,    -- percent of window
            --   height = 0.5,
            -- },
          },
          previewer = true, -- File preview for session picker

          mappings = {
            -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
            delete_session = { "i", "<C-D>" },
            alternate_session = { "i", "<C-S>" },
            copy_session = { "i", "<C-Y>" },
          },

        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    opts = require "configs.noice",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-dap-virtual-text",
    opts = require "configs.virtual-text"
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event="VeryLazy",
    priority = 1000, -- needs to be loaded in first
    config = function()
        require('tiny-inline-diagnostic').setup()
    end
  },
  -- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openai"
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    'nvzone/typr',
    cmd="TyprStats",
    dependencies = "nvzone/volt",
    opts = {},
  },
  {
    "OXY2DEV/markview.nvim",
    event = "VeryLazy",
  },
  {
    "atiladefreitas/dooing",
    event="VeryLazy",
    config = function()
      require("dooing").setup({
            -- your custom config here (optional)
        keymaps = {
          toggle_window = "<leader>td",
          new_todo = "i",
          toggle_todo = "x",
          delete_todo = "d",
          delete_completed = "D",
          close_window = "q",
          undo_delete = "u",
          add_due_date = "H",
          remove_due_date = "r",
          toggle_help = "?",
          toggle_tags = "t",
          toggle_priority = "<Space>",
          clear_filter = "c",
          edit_todo = "e",
          edit_tag = "e",
          edit_priorities = "p",
          delete_tag = "d",
          search_todos = "/",
          add_time_estimation = "T",
          remove_time_estimation = "R",
          import_todos = "I",
          export_todos = "E",
          remove_duplicates = "<leader>D",
          open_todo_scratchpad = "<leader>p",
        }
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "M", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },
  { "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be toggled with `:TSContextToggle`)
        max_lines = 1, -- How many lines the context window should span
        trim_scope = "inner", -- Which scope should be used to trim the context
        mode = "cursor", -- Use "topline" for context from the first line visible in the window
        separator = "─", -- Separator between context and code
        multiWindow = true,
        line_numbers = true,
      })
    end,
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event="VeryLazy",
    config = function()
      require('scrollbar.handlers.search').setup()
      require('scrollbar').setup({
        show = true,
        set_highlights = true,
        folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
        max_lines = false, -- disables if no. of lines in buffer exceeds this
        handle = {
          text = " ",
          blend = 10, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
          color = '#cadbce',
          highlight = "CursorColumn",
          hide_if_all_visible = true, -- Hides handle if all lines are visible     
      },
      marks = {
          Search = {
            text = { '-', '=' },
            priority = 0,
            color = '#ff9e64',
            cterm = nil,
            highlight = 'Search',
          },
          Error = {
            text = { '-', '=' },
            priority = 1,
            color = '#f7768e',
            cterm = nil,
            highlight = 'DiagnosticVirtualTextError',
          },
          Warn = {
            text = { '-', '=' },
            priority = 2,
            color = '#e0af68',
            cterm = nil,
            highlight = 'DiagnosticVirtualTextWarn',
          },
          Info = {
            text = { '-', '=' },
            priority = 3,
            color = '#0db9d7',
            cterm = nil,
            highlight = 'DiagnosticVirtualTextInfo',
          },
          Hint = {
            text = { '-', '=' },
            priority = 4,
            color = '#1abc9c',
            cterm = nil,
            highlight = 'DiagnosticVirtualTextHint',
          },
          Misc = {
            text = { '-', '=' },
            priority = 5,
            color = '#9d7cd8',
            cterm = nil,
            highlight = 'Normal',
          },
        },
        excluded_buftypes = {
            'terminal',
        },
        excluded_filetypes = {
          'prompt',
          'TelescopePrompt',
          'NvimTree',
        },
        autocmd = {
          render = {
            'BufWinEnter',
            'TabEnter',
            'TermEnter',
            'WinEnter',
            'CmdwinLeave',
            'TextChanged',
            'VimResized',
              'WinScrolled',
          },
        },
        handlers = {
          diagnostic = true,
          search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
        },
      })
    end,
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-hlslens"
    }
  },
  {
    "kylechui/nvim-surround",
    event="VeryLazy",
    config = function ()
      require("numb").setup()
    end,
  },
  -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = false}
}

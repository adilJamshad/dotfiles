return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
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
      require("telescope").load_extension "dap"
      local dap = require "dap"
      local dapui = require "dapui"
      require("dap.ext.vscode").load_launchjs(".vscode/launch.json", {
        python = {
          "python",
        },
      })
      -- Python Adapter Configuration
      local python_path = os.getenv "VIRTUAL_ENV"
      if python_path then
        require("dap-python").setup(python_path .. "/bin/python", { include_configs = false, pythonPath = python_path })
      end

      -- dap.configurations.python = dap.configurations.python
      dap.set_log_level "TRACE"
      dapui.setup()
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = ".5", linehl = ".75", numhl = "" })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}

-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local function get_relative_path(file_path)
  -- Get the current working directory
  local cwd = vim.fn.getcwd()

  -- Check if the file path starts with the CWD
  if file_path:sub(1, #cwd) == cwd then
    -- Return the relative path by removing the CWD part
    return file_path:sub(#cwd + 2) -- +2 to remove the '/' as well
  else
    -- If the file is not in the CWD, return the full path
    return file_path
  end
end

local function get_file()
  local icon = "󰈚"
  local path = vim.api.nvim_buf_get_name(stbufnr())
  local name = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]*$"

  if name ~= "Empty " then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(name)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
  end
  local relative_path = get_relative_path(path)

  return { icon, relative_path }
end

M.base46 = {
  theme = "gruvbox",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  statusline = {
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      file = function()
        local x = get_file()
        local name = " " .. x[2] .. " "
        return "%#StText# " .. x[1] .. name
      end,
      -- cursor = function()
      --   return "%#BruhHl#" .. " bruh "
      -- end,
    },
  },
}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- Setup Telescope with a custom mapping for git restore in git_status picker
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-r>"] = function(prompt_bufnr)
          -- Get the selected file from Telescope
          local selection = action_state.get_selected_entry()
          local filename = selection.value

          -- Close the Telescope window
          actions.close(prompt_bufnr)

          -- Run the git restore command on the selected file
          vim.fn.system { "git", "restore", filename }

          -- Reload the file in Neovim if it's open
          vim.cmd("checktime " .. filename)

          -- Notify the user that the file has been restored
          print("Restored " .. filename)
        end,
      },
      n = {
        ["<C-r>"] = function(prompt_bufnr)
          -- Same function for normal mode
          local selection = action_state.get_selected_entry()
          local filename = selection.value
          actions.close(prompt_bufnr)
          vim.fn.system { "git", "restore", filename }
          vim.cmd("checktime " .. filename)
          print("Restored " .. filename)
        end,
      },
    },
  },
  pickers = {
    git_status = {
      mappings = {
        -- Apply the same mapping in the git_status picker
        i = {
          ["<C-r>"] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local filename = selection.value
            actions.close(prompt_bufnr)
            vim.fn.system { "git", "restore", filename }
            vim.cmd("checktime " .. filename)
            print("Restored " .. filename)
          end,
        },
        n = {
          ["<C-r>"] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local filename = selection.value
            actions.close(prompt_bufnr)
            vim.fn.system { "git", "restore", filename }
            vim.cmd("checktime " .. filename)
            print("Restored " .. filename)
          end,
        },
      },
    },
  },
}

return M

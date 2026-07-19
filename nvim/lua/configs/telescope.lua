local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

return function(_, opts)
  -- extend NvChad's telescope config
  opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
    mappings = {
      i = {
        ["<CR>"] = function(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          local multi = picker:get_multi_selection()

          actions.close(prompt_bufnr)

          if #multi > 0 then
            for _, entry in ipairs(multi) do
              vim.cmd("vsplit " .. vim.fn.fnameescape(entry.path)) -- change to split/tabedit/badd
            end
          else
            actions.select_default(prompt_bufnr)
          end
        end,
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
  })

  opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
    git_status = {
      mappings = {
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
  })

  return opts
end


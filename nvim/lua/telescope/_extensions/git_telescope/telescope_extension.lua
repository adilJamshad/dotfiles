local M = {}

local handlers = require("telescope._extensions.git_telescope.handlers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values

-- Picker for git changes
function M.git_changes()
  local files = handlers.get_git_status()

  pickers.new({}, {
    prompt_title = "Git Changes",
    finder = finders.new_table({
      results = files,
      entry_maker = function(entry)
        local status, file = entry:match("(%S+)%s+(.+)")
        return {
          value = file,
          display = string.format("%s %s", status, file),
          ordinal = file,
          status = status,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return { "git", "diff", entry.value }
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        handlers.stage_hunk(selection.value)
      end)
      map("i", "u", function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        handlers.unstage_file(selection.value)
      end)
      return true
    end,
  }):find()
end

-- Picker for staged files
function M.git_staged()
  local files = handlers.get_staged_files()

  require("telescope.pickers").new({}, {
    prompt_title = "Git Staged Files",
    finder = require("telescope.finders").new_table({
      results = files,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    previewer = require("telescope.previewers").new_termopen_previewer({
      get_command = function(entry)
        return { "git", "diff", "--cached", entry.value }
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      -- Add a keybinding for committing staged files
      map("i", "<C-c>", function()
        actions.close(prompt_bufnr)
        vim.ui.input({ prompt = "Commit message: " }, function(commit_message)
          if commit_message and commit_message ~= "" then
            handlers.commit_staged_files(commit_message)
          else
            vim.notify("Commit aborted: No message provided.", vim.log.levels.WARN)
          end
        end)
      end)

      -- Allow unstaging files
      map("i", "u", function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        handlers.unstage_file(selection.value)
      end)

      return true
    end,
  }):find()
end

-- Picker for stashes
function M.git_stashes()
  local stashes = handlers.get_stashes()

  pickers.new({}, {
    prompt_title = "Git Stashes",
    finder = finders.new_table({
      results = stashes,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return { "git", "stash", "show", "-p", entry.value }
      end,
    }),
  }):find()
end

-- Commit staged files with a provided message
function M.commit_staged_files(message)
  require("plenary.job"):new({
    command = "git",
    args = { "commit", "-m", message },
    on_exit = function(j, return_val)
      if return_val == 0 then
        vim.notify("Commit successful: " .. message)
      else
        vim.notify("Commit failed: " .. table.concat(j:result(), "\n"), vim.log.levels.ERROR)
      end
    end,
  }):start()
end

return M


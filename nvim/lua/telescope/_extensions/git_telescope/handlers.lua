local M = {}
local Job = require("plenary.job")

-- Get git status (changes)
function M.get_git_status()
  local result = {}
  Job:new({
    command = "git",
    args = { "status", "--short" },
    on_stdout = function(_, line)
      table.insert(result, line)
    end,
  }):sync()
  return result
end

-- Get staged files
function M.get_staged_files()
  local result = {}
  Job:new({
    command = "git",
    args = { "diff", "--name-only", "--cached" },
    on_stdout = function(_, line)
      table.insert(result, line)
    end,
  }):sync()
  return result
end

-- Get stashes
function M.get_stashes()
  local result = {}
  Job:new({
    command = "git",
    args = { "stash", "list" },
    on_stdout = function(_, line)
      table.insert(result, line)
    end,
  }):sync()
  return result
end

-- Stage a hunk
function M.stage_hunk(file)
  Job:new({
    command = "git",
    args = { "add", file },
  }):sync()
  vim.notify("Staged: " .. file)
end

-- Unstage a file
function M.unstage_file(file)
  Job:new({
    command = "git",
    args = { "restore", "--staged", file },
  }):sync()
  vim.notify("Unstaged: " .. file)
end

return M


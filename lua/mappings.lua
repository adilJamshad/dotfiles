require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local dap = require "dap"
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "continue" })
map("n", "<F5>", function()
  require("dap").continue()
end)
map("n", "<F10>", function()
  require("dap").step_over()
end)
map("n", "<F11>", function()
  require("dap").step_into()
end)
map("n", "<F12>", function()
  require("dap").step_out()
end)
map("n", "<leader>tf", function()
  require("nvim-tree.api").tree.toggle_hidden_filter()
end, { desc = "toggle dotfiles" })
map("n", "<leader>tt", function()
  require("nvim-tree.api").tree.toggle_gitignore_filter()
end, {
  desc = "Toggle git ignored files",
})
function CustomFindFiles()
  local opts = {}
  opts.cwd = vim.fn.input("Directory: ", "", "dir")
  opts.find_command = { "rg", "--files", "--glob", vim.fn.input "Include files: " }
  require("telescope.builtin").find_files(opts)
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>fc",
  ":lua CustomFindFiles()<CR>",
  { noremap = true, silent = true, desc = "Find in a Directory" }
)
map("n", "[h", function()
  package.loaded.gitsigns.prev_hunk()
end, { desc = "Go to Previous Hunk" })
map("n", "]h", function()
  package.loaded.gitsigns.next_hunk()
end, { desc = "Go to Next Hunk" })
map("n", "<leader>gd", function()
  package.loaded.gitsigns.diffthis()
end, { desc = "show git changes" })
map("n", "<leader>gD", function()
  package.loaded.gitsigns.diffthis "~"
end, { desc = "Show diff of whole file" })
map("n", "<leader>gs", function()
  package.loaded.gitsigns.stage_hunk()
end, { desc = "Stage the hunk" })
map("n", "<leader>gu", function()
  package.loaded.gitsigns.reset_hunk()
end, { desc = "Unstage hunk" })
map("n", "<leader>ld", function()
  vim.diagnostic.enable(false)
end, { desc = "Disable Linting" })
map("n", "<leader>le", function()
  vim.diagnostic.enable(true)
end, { desc = "Enable Linting" })
map("n", "<leader>fp", function()
  vim.cmd "!yarn prettier --write %"
end, { desc = "Run formatter" })

map("n", "<leader>gS", function()
  package.loaded.gitsigns.stage_buffer()
end, { desc = "Stage buffer" })
map("n", "<leader>gu", function()
  package.loaded.gitsigns.undo_stage_hunk()
end, { desc = "undo stage hunk" })
map("n", "<leader>gR", function()
  package.loaded.gitsigns.reset_buffer()
end, { desc = "Reset buffer" })
map("n", "<leader>td", function()
  package.loaded.gitsigns.toggle_deleted()
end, { desc = "Toggle deleted" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

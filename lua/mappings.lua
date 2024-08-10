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
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

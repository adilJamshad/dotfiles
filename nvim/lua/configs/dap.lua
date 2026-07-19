require("telescope").load_extension "dap"
local dap = require "dap"
local dapui = require "dapui"
-- require("dap.ext.vscode").load_launchjs(".vscode/launch.json", {
--   python = { "python" },
--   go = { "go" }
-- })
-- Python Adapter Configuration
local python_path = os.getenv "VIRTUAL_ENV"
if python_path then
  require("dap-python").setup(python_path .. "/bin/python", { include_configs = false, pythonPath = python_path })
end

-- dap.configurations.python = dap.configurations.python
dapui.setup()
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DiagnosticError", linehl = "DiagnosticUnderlineError", numhl = "" })

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


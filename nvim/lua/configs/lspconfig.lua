
-- lua/custom/configs/lspconfig.lua

local lspconfig = vim.lsp.config
local defaults = require("nvchad.configs.lspconfig")

-- Use blink.cmp capabilities if you are using blink as your completion
local capabilities
pcall(function()
  capabilities = require("blink.cmp").get_lsp_capabilities()
end)

-- Shared on_attach from NVChad defaults
local on_attach = defaults.on_attach
local on_init  = defaults.on_init

-- List the LSP servers you want to enable
local servers = {
  "lua_ls",    -- Lua
  "gopls",     -- Go
  "pyright",   -- Python
  "ts_ls",  -- JavaScript/TypeScript
  "html",      -- HTML
  "cssls",     -- CSS
  -- Add any others here
}

for _, lsp in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    on_init  = on_init,
    capabilities = capabilities or defaults.capabilities,
  }

  -- You can put server-specific overrides here if needed
  -- For example:
  -- if lsp == "lua_ls" then
  --   config.settings = { Lua = { diagnostics = { globals = {"vim"} } } }
  -- end

  lspconfig(lsp, config)
  vim.lsp.enable(lsp)
end


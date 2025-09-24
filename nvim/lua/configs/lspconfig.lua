-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()


-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "gopls",
  "pyright",
  "lua_ls",
  "ts_ls"
}

vim.lsp.enable(servers)


-- local nvlsp = require "nvchad.configs.lspconfig"
--
-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = nvlsp.on_attach,
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--   }
-- end

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

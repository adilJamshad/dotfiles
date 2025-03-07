local options = {
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = { "prettier" },
    javascript = { "prettier" },
    typescriptreact = { "prettier" },
    javascriptreact = { "prettier" },
    python = { "black" },
  },
  format_on_save = {
    -- timeout_ms = 500,
    lsp_fallback = false,
  },
  formatters = {
    prettier = {
      command = "yarn prettier --write %",
    },
  },
}

return options

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/?.lua"

vim.api.nvim_set_hl(0, "BlinkPairsOrange", {
  fg = "#fab387",
  bg = "#32281f",
})

vim.api.nvim_set_hl(0, "BlinkPairsPurple", {
  fg = "#cba6f7",
  bg = "#2d2638",
})

vim.api.nvim_set_hl(0, "BlinkPairsBlue", {
  fg = "#89b4fa",
  bg = "#1f2c3c",
})

vim.api.nvim_set_hl(0, "BlinkPairsMatchParen", {
  fg = "#ffffff",
  bg = "#5b4a84",
  bold = true,
})-- Indent guides (very subtle)
vim.api.nvim_set_hl(0, "BlinkIndent", {
  fg = "#313244",
})

-- Current scope
vim.api.nvim_set_hl(0, "BlinkIndentScope", {
  fg = "#cba6f7",
  bold = true,
})

-- Scope start/end (if supported)
vim.api.nvim_set_hl(0, "BlinkIndentScopeStart", {
  fg = "#cba6f7",
})

vim.api.nvim_set_hl(0, "BlinkIndentScopeEnd", {
  fg = "#cba6f7",
})

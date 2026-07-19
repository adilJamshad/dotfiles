local M = {
  mappings = {
    -- you can call require("blink.pairs.mappings").enable()
    -- and require("blink.pairs.mappings").disable()
    -- to enable/disable mappings at runtime
    enabled = true,
    cmdline = true,
    -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
    -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
    disabled_filetypes = {},
    -- see the defaults:
    -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L14
    wrap = {
      -- move closing pair via motion
      ['<C-b>'] = 'motion',
      -- move opening pair via motion
      ['<C-S-b>'] = 'motion_reverse',
      -- set to 'treesitter' or 'treesitter_reverse' to use treesitter instead of motions
      -- set to nil, '' or false to disable the mapping
      -- normal_mode = {} <- for normal mode mappings, only supports 'motion' and 'motion_reverse'
    },
    pairs = {
      ['('] = ')',
      ['['] = ']',
      ['{'] = '}',
      
      -- Strings with variants
      ['"'] = {
        { 'r#"', '"#', languages = { 'rust' }, priority = 100 },
        { '"""', when = function(ctx) return ctx:text_before_cursor(2) == '""' end, languages = { 'python' } },
        { '"', enter = false, space = false },
      },
      
      -- Quotes conditional
      ["'"] = {
        { "'''", when = function(ctx) return ctx:text_before_cursor(2) == "''" end, languages = { 'python' } },
        { "'", when = function(ctx) return not ctx.char_under_cursor:match('%w') end },
      },
      
      -- Markdown
      ['`'] = {
        { '```', when = function(ctx) return ctx:text_before_cursor(2) == '``' end, languages = { 'markdown' } },
        { '`', enter = false, space = false },
      },
    }
  },
  highlights = {
    enabled = true,
    -- requires require('vim._extui').enable({}), otherwise has no effect
    cmdline = true,
    groups = {
      'BlinkPairsOrange',
      'BlinkPairsPurple',
      'BlinkPairsBlue',
    },
    unmatched_group = 'BlinkPairsUnmatched',

    -- highlights matching pairs under the cursor
    matchparen = {
      enabled = true,
      -- known issue where typing won't update matchparen highlight, disabled by default
      cmdline = false,
      -- also include pairs not on top of the cursor, but surrounding the cursor
      include_surrounding = true,
      group = 'BlinkPairsMatchParen',
      priority = 250,
    },
  },
  debug = false,
}
return M


local M = {
  keymap = { preset = "default",
    ["<CR>"] = {"accept", "fallback" },
    ["<S-K>"] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  completion = {
    keyword = { range = 'full' },
    accept = { auto_brackets = { enabled = true }, },
    list = { selection = { preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end } },

    menu = {
      -- Don't automatically show the completion menu
      auto_show = true,

      -- nvim-cmp style menu
      draw = {
        columns = {
          { "label", "label_description", gap = 2 },
          { "kind_icon", "kind" }
        },
      }
    },
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
  },
  signature = { enabled = true }
}
return M

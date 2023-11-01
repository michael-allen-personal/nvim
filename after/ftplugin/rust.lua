local bufnr = vim.api.nvim_get_current_buf()

-- My mappings
local ft_helpers = require('mallen.ft_helpers')
-- This adds a function the create keymaps for commenting and uncommenting out selected text
ft_helpers.add_comment_keymaps('\\/\\/', bufnr)
ft_helpers.format_on_save_for({ '*.rs' }, bufnr, {})

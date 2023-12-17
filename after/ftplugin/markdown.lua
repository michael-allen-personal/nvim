-- Settings to make writing not code easier
vim.opt_local.wrap = true
vim.opt_local.spell = true

-- Abbreviations for markdown files only
-- Capitalization fixes
vim.cmd('iab <buffer> dont don\'t')
vim.cmd('iab haskell Haskell')
vim.cmd('iab oauth OAuth')
vim.cmd('iab oidc OIDC')
-- Technical shorthand abbreviations
vim.cmd('iab FP functional programming')

-- Command shortcut for obsidian [[]] surround
-- These two commands rely on the surround plugin
vim.keymap.set("v", "<leader>os", "\"odi[[]]<Esc>hh\"op", { desc = '[o]bsidian [s]urround with obsidian reference' })
vim.keymap.set("n", "<leader>os", "\"odiwi[[]]<Esc>hh\"op", { desc = '[o]bsidian [s]urround with obsidian reference' })

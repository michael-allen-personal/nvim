---
-- Suggested keymaps from the quick setup section:
-- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
---

vim.cmd('PackerLoad haskell-tools.nvim')
local ht = require('haskell-tools')
ht.lsp.start()
local bufnr = vim.api.nvim_get_current_buf()
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
--
--vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.run, { noremap = true, silent = true, buffer = bufnr })
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature,
    { desc = '[h]oogle [s]ignature', noremap = true, silent = true, buffer = bufnr })
-- Evaluate all code snippets
vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all,
    { desc = '[e]valuate [a]ll code snippets in current buffer', noremap = true, silent = true, buffer = bufnr })
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle,
    { desc = 'GHCi repl toggle for package', noremap = true, silent = true, buffer = bufnr })
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, { desc = 'toggle GHCi repl for current buffer', noremap = true, silent = true, buffer = bufnr })
vim.keymap.set('n', '<leader>rq', ht.repl.quit,
    { desc = 'GHCi [r]epl [q]uit', noremap = true, silent = true, buffer = bufnr })

-- My mappings
local ft_helpers = require('mallen.ft_helpers')
-- This adds a function the create keymaps for commenting and uncommenting out selected text
ft_helpers.add_comment_keymaps('--', bufnr)

-- Change the tab width to 2, which is what the formatters do for indented code
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Cabal shortcuts
-- functions to determine if its a cabal project
local root_dir = ht.project.root_dir()
local function find_cabal_file(dir)
    local cmd = 'ls ' .. dir .. '/*.cabal 2>/dev/null'
    local file = io.popen(cmd)
    local filename = file:read("*l")
    file:close()
    return filename
end

local function get_executable_name_from_cabal(cabal_file_path)
    local executable_name
    for line in io.lines(cabal_file_path) do
        -- Match "executable <name>" pattern in .cabal file
        -- Pretty sure this only gets the first match
        local match = line:match("^executable%s+(%S+)")
        if match then
            executable_name = match
            break
        end
    end
    return executable_name
end

local cabal_file = find_cabal_file(root_dir)

-- Add cabal commands if cabal project
if cabal_file then
    local exe_name = get_executable_name_from_cabal(cabal_file)
    vim.keymap.set('n', '<leader>cb', ':! cabal build<CR>',
        { desc = '[c]abal [b]uild', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>cr', string.format(':! cabal run %s<CR>', exe_name),
        { desc = '[c]abal [r]un current project exe', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>cp',
        string.format(':! cabal build --enable-profiling && cabal run %s -- +RTS -p<CR>', exe_name),
        { desc = '[c]abal [p]rofile current project exe', noremap = true, silent = true, buffer = bufnr })
end

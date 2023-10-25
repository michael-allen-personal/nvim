---
-- Suggested keymaps from the quick setup section:
-- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
---

vim.cmd('PackerLoad haskell-tools.nvim')
local ht = require('haskell-tools')
ht.lsp.start()
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
--vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.run, opts)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
-- Evaluate all code snippets
vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all, opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

-- My mappings
-- These mappings comment and uncomment out the selected text
vim.keymap.set('v', '\'', ':<C-U>\'<,\'>s/.*/--&/g<CR>', { desc = 'comment out selected text', noremap = true, silent = true })
vim.keymap.set('v', '"', ':<C-U>\'<,\'>s/--//<CR>', { desc = 'uncomment out selected text', noremap = true, silent = true })

-- Cabal shortcuts
vim.keymap.set('n', '<leader>cb', ':! cabal build<CR>', { desc = '[c]abal [b]uild', noremap = true, silent = true })
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
        local match = line:match("^executable%s+(%S+)")
        if match then
            executable_name = match
            break
        end
    end
    return executable_name
end
local cabal_file = find_cabal_file(root_dir)
if cabal_file then
    local exe_name = get_executable_name_from_cabal(cabal_file)
    vim.keymap.set('n', '<leader>cr', string.format(':! cabal run %s<CR>', exe_name), { desc = '[c]abal [r]un current project exe', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>br', string.format(':! cabal build && cabal run %s<CR>', exe_name), { desc = '[c]abal [r]un current project exe', noremap = true, silent = true })
end


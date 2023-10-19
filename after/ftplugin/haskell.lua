local lsp_zero = require("lsp-zero")
---
-- Setup haskell LSP
---

vim.g.haskell_tools = {
    hls = {
        capabilities = lsp_zero.get_capabilities()
    }
}

-- Autocmd that will actually be in charging of starting hls
local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', {clear = true})
vim.api.nvim_create_autocmd('FileType', {
    group = hls_augroup,
    pattern = {'haskell'},
    callback = function()
        ---
        -- Suggested keymaps from the quick setup section:
        -- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
        ---

        local ht = require('haskell-tools')
        local bufnr = vim.api.nvim_get_current_buf()
        local def_opts = { noremap = true, silent = true, buffer = bufnr, }
        -- haskell-language-server relies heavily on codeLenses,
        -- so auto-refresh (see advanced configuration) is enabled by default
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.run, opts)
        -- Hoogle search for the type signature of the definition under the cursor
        vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
        -- Evaluate all code snippets
        vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all, opts)
        -- Toggle a GHCi repl for the current package
        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
        -- Toggle a GHCi repl for the current buffer
        vim.keymap.set('n', '<leader>rf', function()
            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
        end, def_opts)
        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

        -- My mappings
        -- These mappings comment and uncomment out the selected text
        vim.api.nvim_set_keymap('v', '\'', ':<C-U>\'<,\'>s/.*/--&/g<CR>', { desc = 'comment out selected text', noremap = true, silent = true })
        vim.api.nvim_set_keymap('v', '"', ':<C-U>\'<,\'>s/--//g<CR>', { desc = 'uncomment out selected text', noremap = true, silent = true })
    end
})

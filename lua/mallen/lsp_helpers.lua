local M = {}

M.set_default_lsp_keymaps = function(_, bufnr)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
        { desc = 'Hover Documentation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
        { desc = '[G]oto [D]efinition', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,
        { desc = '[G]oto [R]eferences', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation,
        { desc = '[G]oto [I]mplementation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help,
        { desc = '[G]oto [S]ignature Documentation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition,
        { desc = '[Go]to Type [D]efinition', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol,
        { desc = '[D]ocument [S]ymbols', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        { desc = '[c]ode [a]ctions', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
        { desc = '[R]e[n]ame', noremap = true, silent = true, buffer = bufnr })

    -- Diagnostic keymaps
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float,
        { desc = 'Show Diagnostic in floating window', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
        { desc = 'Goto previous diagnostic', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev,
        { desc = 'Goto next diagnostic', noremap = true, silent = true, buffer = bufnr })

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

return M

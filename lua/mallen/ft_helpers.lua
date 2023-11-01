local M = {}

-- Function to add comment/uncomment keybinds for a given comment char
M.add_comment_keymaps = function(commentStr, bufnr)
    vim.keymap.set('v', '\'', string.format(':<C-U>\'<,\'>s/.*/%s&/g<CR>', commentStr),
        { desc = 'comment out selected lines', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('v', '"', string.format(':<C-U>\'<,\'>s/%s//<CR>', commentStr),
        { desc = 'uncomment out selected lines', noremap = true, silent = true, buffer = bufnr })
end

-- Formatting Options can be found here: https://microsoft.github.io/language-server-protocol/specification/#formattingOptions
M.format_on_save_for = function(filetypes, bufnr, fmtopts)
    local format_on_save = function(bufnr_, fmtopts_)
        -- Check if the LSP is attached and supports formatting
        vim.lsp.buf.format({
            buffer = bufnr_,
            formatting_options = fmtopts_,
        })
    end

    -- Convert table of filetypes to comma-separated string
    local pattern = table.concat(filetypes, ',')

    -- Setup the BufWritePre auto command
    vim.api.nvim_command('augroup FormatOnSave')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = pattern,
        callback = function() format_on_save(bufnr, fmtopts) end,
    })
    vim.api.nvim_command('augroup END')
end

return M

local M = {}

-- Function to add comment/uncomment keybinds for a given comment char
M.add_comment_keymaps = function(commentStr, bufnr)
    vim.keymap.set('v', '\'', string.format(':<C-U>\'<,\'>s/.*/%s&/g<CR>', commentStr),
        { desc = 'comment out selected lines', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('v', '"', string.format(':<C-U>\'<,\'>s/%s//<CR>', commentStr),
        { desc = 'uncomment out selected lines', noremap = true, silent = true, buffer = bufnr })
end

return M

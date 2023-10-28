local builtin = require('telescope.builtin')
-- ff = find files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- gf = git files
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
-- ps = project search
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

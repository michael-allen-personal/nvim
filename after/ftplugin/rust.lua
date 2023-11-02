local bufnr = vim.api.nvim_get_current_buf()
local rt = require("rust-tools")
local ft_helpers = require('mallen.ft_helpers')

rt.setup({
    server = {
        on_attach = function(_, buffer)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = buffer, desc = 'Hover Actions' })
            -- Code action groups
            vim.keymap.set("n", "<Leader>ag", rt.code_action_group.code_action_group,
                { buffer = buffer, desc = 'Code [a]ction [g]roups' })
            ft_helpers.format_on_save_for({ '*.rs' }, buffer, {})
        end,
    },
})

-- My mappings
-- This adds a function the create keymaps for commenting and uncommenting out selected text
ft_helpers.add_comment_keymaps('\\/\\/', bufnr)
--local root_dir =
--local crate_file = ft_helpers.find_project_file(root_dir, '.toml')
--if crate_file then
--    local exe_name = get_executable_name_from_cabal(crate_file)
--    vim.keymap.set('n', '<leader>cb', ':! cargo build<CR>',
--        { desc = '[c]argo [b]uild', noremap = true, silent = true, buffer = bufnr })
--    vim.keymap.set('n', '<leader>cc', ':! cargo check<CR>',
--        { desc = '[c]argo [c]heck', noremap = true, silent = true, buffer = bufnr })
--    vim.keymap.set('n', '<leader>cr', string.format(':! cargo run %s<CR>', exe_name),
--        { desc = '[c]argo [r]un current project exe', noremap = true, silent = true, buffer = bufnr })
--end

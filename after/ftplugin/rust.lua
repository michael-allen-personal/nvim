local bufnr = vim.api.nvim_get_current_buf()
local rt = require("rust-tools")
local ft_helpers = require('mallen.ft_helpers')
require('mallen.lsp_helpers').set_default_lsp_keymaps({}, bufnr)

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
-- Below assumes the working directory is the project root
-- Which should normally be true based on my usage patterns
local current_dir = vim.fn.getcwd()
-- Need to handle the case where there are multiple results
local cargo_file = ft_helpers.find_files_by_extension(current_dir, 'toml')[1]

if cargo_file then
    --    local exe_name = get_executable_name_from_cargo(cargo_file)
    vim.keymap.set('n', '<leader>cb', ':! cargo build<CR>',
        { desc = '[c]argo [b]uild', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>cc', ':! cargo check<CR>',
        { desc = '[c]argo [c]heck', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>cr', ':! cargo run<CR>',
        { desc = '[c]argo [r]un current project exe', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>cd', ':! cargo doc --open<CR>',
        { desc = '[c]argo generate local [d]ocs and open in browser', noremap = true, silent = true, buffer = bufnr })
end

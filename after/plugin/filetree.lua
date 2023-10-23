-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

vim.keymap.set({ 'n', 'c' }, '<leader>ft', ':NvimTreeToggle<CR>', { desc = 'Toggle [f]ile [t]ree', noremap = true, silent = true  })

--local function my_on_attach(bufnr)
--    local api = require "nvim-tree.api"
--
--    local function opts(desc)
--        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--    end
--
--    -- default mappings
--    api.config.mappings.default_on_attach(bufnr)
--
--    -- custom mappings
--end
--
---- pass to setup along with your other options
--require("nvim-tree").setup {
--    ---
--    on_attach = my_on_attach,
--    ---
--}

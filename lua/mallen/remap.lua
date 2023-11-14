vim.g.mapleader = ' '

-- my mappings

-- open filesystem
--vim.keymap.set( 'n', '<leader>fs', vim.cmd.Ex, { desc = 'open [f]ile [s]ystem explorer' })

-- command to write and source the current file
vim.keymap.set('n', '<leader>ws', ':w<CR>:so<CR>',
    { desc = '[w]rite and [s]ource the current file', noremap = true, silent = true })
vim.keymap.set('c', 'ws', ':w<CR>:so<CR>',
    { desc = '[w]rite and [s]ource the current file', noremap = true, silent = true })

-- this command removes all the ^M chars that come with pasting something from windows
vim.keymap.set("n", "<leader>fw", ":%s/\\r//g<CR><C-o>",
    { desc = '[f]ix [w]indows paste', noremap = true, silent = true })

-- these two add commands for inserting a line above or below
-- but not entering insert mode
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = 'inser line below without entering insert' })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = 'inser line above without entering insert' })

-- entire buffer commands
vim.keymap.set('n', '<leader>ya', ':%y+<CR>', { desc = '[y]ank [a]ll, or copy the entire buffer into the clipboard' })
vim.keymap.set("n", "<C-a>", "gg0vGG$", { desc = 'Select all text in the buffer' })

vim.keymap.set('i', '<C-h>', '<C-o>h', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', '<C-o>j', { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<C-o>k', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<C-o>a', { noremap = true, silent = true })

-- primaegen mappings

-- creates mapping so ' fs' opens the filesystem explorer
-- the 'n' mode means you dont type : before the commend
-- for commands that require : we use 'c' mode

-- these will move the highlighed text when in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'move highlighted text up' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'move highlighted text down' })

-- these two change the page up and page down commands to move
-- the page, but keep your cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- these two do the same for searches
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- when in visual mode, if you are pasting some text
-- over some other text, keep the pasted text in the clipboard
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = 'paste highlighted word but dont override clipboard' })
-- this does the same for delete in visual and normal
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>d", "\"_d")

-- these have something to do with quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


-- this one will populate a search and replace command for the current word
vim.keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = 'init [s]earch and [r]eplace for the current word' })

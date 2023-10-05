vim.g.mapleader = ' '

-- my mappings

-- this one will go to the end of the line and delete the last 
-- char. Is used to fix paste issues when copying from windows
-- the second command is so it can be repeated n times in one
-- command
vim.keymap.set("n", "<leader>fw", "$xj", { desc = '[f]ix [w]indows paste' })
vim.keymap.set("c", "fw", ":normal $xj", { desc = '[f]ix [w]indows paste' })

-- these two add commands for inserting a line above or below
-- but not entering insert mode
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = 'inser line below without entering insert' })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = 'inser line above without entering insert' })

-- primaegen mappings

-- creates mapping so ' fs' opens the filesystem explorer
-- the 'n' mode means you dont type : before the commend
-- for commands that require : we use 'c' mode
vim.keymap.set({'n', 'c'}, '<leader>fs', vim.cmd.Ex, { desc = 'open [f]ile [s]ystem explorer' })

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
vim.keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = 'init [s]earch and [r]eplace for the current word' })

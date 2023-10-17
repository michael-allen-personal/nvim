vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true

vim.opt.relativenumber = true
vim.opt.number = true

-- This sets the default clipboard to be the system clipboard
-- This allows for copying and pasting between vim and other programs
vim.opt.clipboard = "unnamedplus"

-- Not actually sure if neovim uses this option but its not breaking
-- anything as far as I can tell (ttyfast)
vim.opt.ttyfast = true

-- This specifies the completion mode for the command line (using Tab)
-- Complete longest common string, then list alternatives.
vim.opt.wildmode = {'longest', 'list'}

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- hlsearch disables the highlighting of search results
-- This disables the annoying thing where the searches stay highlighted until
-- cleared
vim.opt.hlsearch = false
-- incsearch makes the search results appear as you type
vim.opt.incsearch = true

-- min chars from the bottom that your cursor can go
vim.opt.scrolloff = 8
-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

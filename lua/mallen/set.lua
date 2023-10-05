vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.clipboard = "unnamedplus"

vim.opt.ttyfast = true
vim.opt.wildmode = {'longest', 'list'}

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- min chars from the bottom that your cursor can go
vim.opt.scrolloff = 8

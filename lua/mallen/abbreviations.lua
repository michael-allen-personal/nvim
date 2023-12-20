-- Common misspelling fix abbreviations
vim.cmd('iab teh the')
vim.cmd('iab adn and')
vim.cmd('iab tihs this')

-- Contraction fixes
vim.cmd("iab cant can't")
vim.cmd("iab Cant Can't")
vim.cmd("iab dont don't")
vim.cmd("iab Dont Don't")
vim.cmd("iab didnt didn't")
vim.cmd("iab Didnt Didn't")
vim.cmd("iab doesnt doesn't")
vim.cmd("iab Doesnt Doesn't")
vim.cmd("iab wont won't")
vim.cmd("iab Wont Won't")
vim.cmd("iab yall y'all")
vim.cmd("iab Yall Y'all")
vim.cmd("iab ive I've")
vim.cmd("iab Ive I've")
vim.cmd("iab shouldnt shouldn't")
vim.cmd("iab Shouldnt Shouldn't")

-- Capitalization fixes
-- For the most part these are in the markdown ftplugin, as words like Haskell or OAuth do not need to be fixed in code, only in documentation

-- Regular shorthand abbreviations
-- something like b/c -> because would go here but vim doesnt support / in
-- abbreviations because it is a protected charecter

-- Technical shorthand abbreviations

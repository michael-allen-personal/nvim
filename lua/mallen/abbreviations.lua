-- Common misspelling fix abbreviations
vim.cmd('iab teh the')
vim.cmd('iab adn and')
vim.cmd('iab tihs this')

-- Contraction fixes
vim.cmd("iab cant can't")
vim.cmd("iab dont don't")
vim.cmd("iab wont won't")
vim.cmd("iab yall y'all")

-- Capitalization fixes
vim.cmd('iab haskell Haskell')
vim.cmd('iab oauth OAuth')
vim.cmd('iab oidc OIDC')

-- Regular shorthand abbreviations
-- something like b/c -> because would go here but vim doesnt support / in
-- abbreviations because it is a protected charecter

-- Technical shorthand abbreviations
vim.cmd('iab FP functional programming')

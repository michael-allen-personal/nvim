local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- my plugins here

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- LSP Plugins
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- These let us manage lsp servers from inside neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',                tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            { 'folke/neodev.nvim' },
        }
    }

    -- Haskell utilities
    use {
        'mrcjkb/haskell-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        version = '^2', -- Recommended
        ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    }

    -- Markdown utilities
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        ft = { "markdown" },
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    })

    use({
        'epwalsh/obsidian.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    })

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            -- Snippet Engine & its associated nvim-cmp source
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },

            -- Adds LSP completion capabilities
            { 'hrsh7th/cmp-nvim-lsp' },

            -- Adds a number of user-friendly snippets
            { 'rafamadriz/friendly-snippets' },

            -- copilot
            { 'github/copilot.vim' },
        }
    }

    -- file explorer plugins
    use { 'nvim-tree/nvim-tree.lua' }
    -- need to install some font thing and configure this one
    -- its currently not working
    --    use{ 'nvim-tree/nvim-web-devicons' }

    -- Other plugins
    use { 'nvim-treesitter/playground' }
    use { 'theprimeagen/harpoon' }
    use { 'mbbill/undotree' }
    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-surround' }
    use { 'windwp/nvim-autopairs' }

    -- Colors
    use({ 'bluz71/vim-nightfly-colors', as = 'nightfly' })

    -- automatically set up your configuration after cloning packer.nvim
    -- put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

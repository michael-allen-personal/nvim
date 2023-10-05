local ensure_packer = function()
<<<<<<< HEAD
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
=======
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
>>>>>>> 7a27300 (first commit)
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- my plugins here

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	})

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- Uncomment these if you want to manage LSP servers from neovim
<<<<<<< HEAD
			-- {'williamboman/mason.nvim'},
			-- {'williamboman/mason-lspconfig.nvim'},
=======
			{'williamboman/mason.nvim', config = true},
			{'williamboman/mason-lspconfig.nvim'},
>>>>>>> 7a27300 (first commit)

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}

	use {
		'mrcjkb/haskell-tools.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		version = '^2', -- Recommended
		ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
	}

<<<<<<< HEAD
=======
	-- Additional lua configuration, makes nvim stuff amazing!
	use	{'folke/neodev.nvim'}
-- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	use	{'j-hui/fidget.nvim'}
>>>>>>> 7a27300 (first commit)
	use { 'nvim-treesitter/playground' }
	use { 'theprimeagen/harpoon' }
	use { 'mbbill/undotree' }
	use { 'tpope/vim-fugitive' }

	-- automatically set up your configuration after cloning packer.nvim
	-- put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)

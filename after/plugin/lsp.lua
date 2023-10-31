-- Most of this configuration is based off kickstart.nvim LSP config section

-- [[ Default LSP Keybinds Setup ]]

-- first argument is client, but its currently not being used
local on_attach = function(_, bufnr)
    -- mostly some default lsp-zero keybinds, with some additions for claritys sake
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
        { desc = 'Hover Documentation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
        { desc = '[G]oto [D]efinition', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,
        { desc = '[G]oto [R]eferences', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation,
        { desc = '[G]oto [I]mplementation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help,
        { desc = '[G]oto [S]ignature Documentation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition,
        { desc = '[Go]to Type [D]efinition', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol,
        { desc = '[D]ocument [S]ymbols', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        { desc = '[c]ode [a]ctions', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
        { desc = '[R]e[n]ame', noremap = true, silent = true, buffer = bufnr })

    -- Diagnostic keymaps
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float,
        { desc = 'Show Diagnostic in floating window', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
        { desc = 'Goto previous diagnostic', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev,
        { desc = 'Goto next diagnostic', noremap = true, silent = true, buffer = bufnr })

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- [[ Mason Setup ]]

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
--  Enable the following language servers
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.

    -- NOTE: Haskell LSP is configured by haskell-tools
    rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
            runtime = { version = 'LuaJIT' },
            -- telemetry = { enable = false },
        },
    },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}

-- [[ Configure nvim-cmp ]]
-- enables completion capabilities
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

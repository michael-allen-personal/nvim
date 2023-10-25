-- see mason.lua for the additional config
local lsp_zero = require("lsp-zero")

-- first argument is client, but its currently not being used
lsp_zero.on_attach(function(_, bufnr)
    -- mostly some default lsp-zero keybinds, with some additions for claritys sake
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]oto [R]eferences', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = '[G]oto [S]ignature Documentation', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, { desc = '[Go]to Type [D]efinition', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { desc = '[D]ocument [S]ymbols', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ctions', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame', noremap = true, silent = true, buffer = bufnr })

    -- Diagnostic keymaps
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show Diagnostic in floating window', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous diagnostic', noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { desc = 'Goto next diagnostic', noremap = true, silent = true, buffer = bufnr })

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end)

require('mason').setup()

--  Enable the following language servers
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    -- NOTE: Haskell LSP is configured by haskell-tools
    -- rust_analyzer = {},
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

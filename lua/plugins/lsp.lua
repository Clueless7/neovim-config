return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup({})
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "clangd",
                    "cssls",
                    "emmet_language_server",
                    "gopls",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "rust_analyzer",
                    "svelte",
                    "tsserver",
                },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,

                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = {
                                            'vim'
                                        }
                                    }
                                }
                            }
                        })
                    end
                },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.opt.signcolumn = 'yes'

            local lspconfig = require('lspconfig')

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig.util.default_config.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- Executes the callback function every time a
            -- language server is attached to a buffer.
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
                end,
            })
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            ---
            -- Autocompletion setup
            ---
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                snippet = {
                    expand = function(args)
                        -- You need Neovim v0.10 to use vim.snippet
                        vim.snippet.expand(args.body)
                    end,
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert,preview'
                },
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),

                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
            })
        end
    },
}

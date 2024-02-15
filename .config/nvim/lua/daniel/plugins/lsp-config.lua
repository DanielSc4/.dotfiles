return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "bashls",
                    "jsonls",
                    "ltex",
                    "marksman",
                    "pyright",
                    "ruff-lsp",
                    "jedi-language-server",
                    "rust_analyzer",
                    "lemminx",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })

            -- Python.
            --
            -- NOTE: We're using a different language servers here.
            --
            -- Jedi has great LS capabilities, but only checks for syntax errors, so it
            -- doesn't help with linting and type-checking.
            --
            -- On the other hand, Pyright is great for linting and type-checking, but its
            -- other LS capabilities are not great, so we disable Pyright as a completion
            -- provider to avoid duplicate suggestions from nvim-cmp.
            --
            -- NOTE: To see which capabilities a LS has, run
            -- :lua =vim.lsp.get_active_clients()[1].server_capabilities
            -- (change the index from '1' to whatever if you have multiple)
            require("lspconfig")["jedi_language_server"].setup {
                on_attach = function(client, _)
                    client.server_capabilities.renameProvider = true
                    -- Jedi works best as the hover provider.
                    client.server_capabilities.hoverProvider = true
                end,
            }
            if os.getenv "NVIM_PYRIGHT" ~= "0" then
                require("lspconfig")["pyright"].setup {
                    on_attach = function(client, _)
                        -- Renaming doesn't work properly unless we only have a single
                        -- rename provider, so we disable it for pyright.
                        -- See https://github.com/neovim/neovim/issues/15899
                        client.server_capabilities.renameProvider = false
                        client.server_capabilities.completionProvider = false
                        -- Jedi works best as the hover provider.
                        client.server_capabilities.hoverProvider = false
                        client.server_capabilities.signatureHelpProvider = false
                    end,
                }
            end
            require("lspconfig")["ruff_lsp"].setup {
                on_attach = function(client, _)
                    client.server_capabilities.renameProvider = false
                    -- Jedi works best as the hover provider.
                    client.server_capabilities.hoverProvider = false
                end,
            }

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
            end, {})
        end
    },
}

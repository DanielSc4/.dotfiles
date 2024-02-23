return {
    {
        "github/copilot.vim",
    },
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
                    -- "jedi-language-server",
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
            lspconfig.lua_ls.setup({ capabilities = capabilities})
            lspconfig.pyright.setup({capabilities = capabilities})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
            end, {})
        end
    },
}


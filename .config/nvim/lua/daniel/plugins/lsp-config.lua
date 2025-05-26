return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "bashls",
                "jsonls",
                "ltex",
                "marksman",

                "pyright",
                "mypy",
                "isort",
                "black",

                "rust_analyzer",
                "lemminx",
            },
        },
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
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
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostic = { globals = { "vim" } }
                    }
                }
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })


            local wk = require("which-key")
            wk.add({
                { "K", vim.lsp.buf.hover, desc = "Hover" },
                { "<C-K>", vim.lsp.buf.signature_help, desc = "Signature help" },
                { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
                { "gr", vim.lsp.buf.references, desc = "References" },
                { "<leader>f", function() vim.lsp.buf.format { async = true } end, desc = "Format current buffer" },
                { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
            })
        end
    },
    {
        "github/copilot.vim",
        config = function()
            vim.keymap.set(
                'i', '<C-Space>', 'copilot#Accept("<CR>")',
                { silent = true, expr = true, replace_keycodes = false }
            )
            vim.g.copilot_no_tab_map = false
        end
    },
}

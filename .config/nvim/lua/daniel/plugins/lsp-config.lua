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
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })


            local wk = require("which-key")
            wk.register({
                ["K"] = { vim.lsp.buf.hover, "hover" },
                ["<C-K>"] = { vim.lsp.buf.signature_help, "signature help" },
                ["gd"] = { vim.lsp.buf.definition, "go to definition" },
                ["<leader>f"] = {
                    function()
                        vim.lsp.buf.format { async = true }
                    end,
                    "go to definition",
                },
            })
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    },
    {

        "github/copilot.vim",
        config = function()
            vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
            vim.g.copilot_no_tab_map = false 
        end
    },
}

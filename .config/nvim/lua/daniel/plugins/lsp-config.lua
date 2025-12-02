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
                ensure_installed = {}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            -- Enhanced diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                    spacing = 4,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "E",  -- left side letter
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",    -- number highlight color
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
             }) 
            -- Enhanced hover and signature help with borders
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = "rounded",
                }
            )
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, {
                    border = "rounded",
                }
            )
            
            -- Configure lua_ls
            vim.lsp.config('lua_ls', {
                cmd = { 'lua-language-server' },
                root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { "vim" }
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        },
                        telemetry = { enable = false },
                    }
                }
            })
            
            -- Configure pyright
            vim.lsp.config('pyright', {
                cmd = { 'pyright-langserver', '--stdio' },
                root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = 'workspace',
                        }
                    }
                }
            })
            
            -- Auto-enable LSP servers with on_attach callback
            local function on_attach(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                
                -- Highlight symbol under cursor
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end
            
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'lua',
                callback = function()
                    vim.lsp.enable('lua_ls')
                end,
            })
            
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'python',
                callback = function()
                    vim.lsp.enable('pyright')
                end,
            })
            
            -- Attach callback for LSP
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = on_attach,
            })
            
            -- Enhanced keybindings
            local wk = require("which-key")
            wk.add({
                { "K", vim.lsp.buf.hover, desc = "Hover" },
                { "<C-K>", vim.lsp.buf.signature_help, desc = "Signature help" },
                { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
                { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
                { "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
                { "gt", vim.lsp.buf.type_definition, desc = "Go to Type Definition" },
                { "gr", vim.lsp.buf.references, desc = "References" },
                { "<leader>f", function() vim.lsp.buf.format { async = true } end, desc = "Format current buffer" },
                { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
                { "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol" },
                { "<leader>d", vim.diagnostic.open_float, desc = "Show line diagnostics" },
                { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
                { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
                { "<leader>q", vim.diagnostic.setloclist, desc = "Diagnostics to location list" },
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

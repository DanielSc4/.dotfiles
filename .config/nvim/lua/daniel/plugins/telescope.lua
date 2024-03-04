return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'andrew-george/telescope-themes',
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require('telescope/builtin')

            telescope.load_extension("file_browser")



            local wk = require("which-key")
            wk.register({
                ["<leader>"] = {
                    name = "Find",
                    ff = { builtin.find_files, "Find files" },
                    fg = { builtin.live_grep, "Live grep" },
                    fb = { builtin.buffers, "Find buffers" },
                    fh = { builtin.help_tags, "Find help tags" },
                    fd = { ":Telescope file_browser<cr><esc>", "Find directories" },
                    fc = { builtin.commands, "Find commands" },
                    ft = { ":Telescope themes<CR>", "Theme Switcher", noremap = true, silent = true },
                }
            }, {})
            -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            -- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            -- vim.keymap.set('n', '<leader>fd', ":Telescope file_browser<cr><esc>", {})
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}

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
                ["<leader>f"] = {
                    name = "Find",
                    f = { builtin.find_files, "Find files" },
                    g = { builtin.live_grep, "Live grep" },
                    b = { builtin.buffers, "Find buffers" },
                    h = { builtin.help_tags, "Find help tags" },
                    d = { ":Telescope file_browser<cr><esc>", "Find directories" },
                    c = { builtin.commands, "Find commands" },
                    t = { ":Telescope themes<CR>", "Theme Switcher", noremap = true, silent = true },
                }
            }, {})
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

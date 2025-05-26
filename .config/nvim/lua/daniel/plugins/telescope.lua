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
            wk.add({
                { "<leader>f", group = "Find" },
                { "<leader>ff", builtin.find_files, desc = "Find files" },
                { "<leader>fb", builtin.buffers, desc = "Find buffers" },
                { "<leader>fc", builtin.commands, desc = "Find commands" },
                { "<leader>fd", ":Telescope file_browser<cr><esc>", desc = "Find directories" },
                { "<leader>fg", builtin.live_grep, desc = "Live grep" },
                { "<leader>fh", builtin.help_tags, desc = "Find help tags" },
                { "<leader>ft", ":Telescope themes<CR>", desc = "Theme Switcher", remap = false },
            }, {})
            -- wk.register({
            --     ["<leader>f"] = {
            --         name = "Find",
            --         g = { , "Live grep" },
            --         b = { , "Find buffers" },
            --         h = { , "Find help tags" },
            --         d = { ":Telescope file_browser<cr><esc>", "Find directories" },
            --         c = { , "Find commands" },
            --         t = { ":Telescope themes<CR>", "Theme Switcher", noremap = true, silent = true },
            --     }
            -- }, {})
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

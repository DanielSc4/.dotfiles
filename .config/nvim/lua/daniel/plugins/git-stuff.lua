return {
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()

            local wk = require("which-key")
            wk.add({
                { "<leader>g",  group = "Git" },
                { "<leader>gp", ":Gitsigns preview_hunk<CR>",    desc = "Preview hunk" },
                { "<leader>gs", ":G<CR>",                        desc = "Status" },
                { "<leader>gl", ":Gitsigns blame_line<CR>",      desc = "Blame line" },
                { "<leader>gd", ":Gitsigns diffthis<CR>",        desc = "Diff this" },
                { "<leader>gD", ":Gitsigns diffthis HEAD<CR>",   desc = "Diff with HEAD" },
                { "<leader>gS", ":Gitsigns stage_hunk<CR>",      desc = "Stage hunk" },
                { "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" },
                { "<leader>gr", ":Gitsigns reset_hunk<CR>",      desc = "Reset hunk" },
            }, {})
        end
    },
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        keys = {
            { "<leader>go", ":DiffviewOpen<cr>", desc = "Diffview Project Open" },
        },
    }
}

return {
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()

            local wk = require("which-key")
            wk.register({
                ["<leader>g"] = {
                    name = "Git",
                    s = { ":G<CR>", "Status" },
                    p = { ":Gitsigns preview_hunk<CR>", "Preview hunk" },   -- show diff for line

                }
            }, {})
        end
    }
}

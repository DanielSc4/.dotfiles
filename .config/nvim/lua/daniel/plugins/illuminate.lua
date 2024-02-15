return {
    "RRethy/vim-illuminate",
    lazy = true,
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = { "CursorMoved", "InsertLeave" },
    config = function()
        require("illuminate").configure {
            delay = 250,
            filetypes_denylist = {
                "NvimTree",
                "Telescope",
                "telescope",
            },
        }
    end,
}

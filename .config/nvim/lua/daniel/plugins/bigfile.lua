return {
    "LunarVim/bigfile.nvim",
    -- enabled = false,
    event = "BufReadPre",
    opts = {
        features = { -- features to disable
            "illuminate",
            "indent_blankline",
            "lsp",
            -- "matchparen",
            "syntax",
            "treesitter",
        },
    },
}

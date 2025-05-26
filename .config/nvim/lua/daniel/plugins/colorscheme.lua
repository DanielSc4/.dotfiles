return {
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     lazy = false,
    --     config = function()
    --         -- vim.cmd.colorscheme "catppuccin-latte"
    --         -- vim.cmd.colorscheme "catppuccin-frappe"
    --     end,
    -- },
    {
        "sainnhe/gruvbox-material",
        name = "gruvbox-material",
        priority = 1000,
        lazy = false,
        config = function()
            vim.g.gruvbox_material_foreground = "material"  -- "material", "mix", "original"
            vim.g.gruvbox_material_background = "medium"  -- "soft", "medium", "hard"
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_enable_bold = 1
            vim.cmd.colorscheme "gruvbox-material"
        end,
    },
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     priority = 1000 ,
    --     config = function ()
    --         vim.cmd.colorscheme "gruvbox"
    --     end,
    -- },
}

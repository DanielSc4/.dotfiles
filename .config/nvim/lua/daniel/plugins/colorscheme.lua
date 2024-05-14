return {
    -- {
    --     'maxmx03/solarized.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.o.background = 'light' -- or 'dark'
    --         vim.cmd.colorscheme 'solarized'
    --     end,
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            -- vim.cmd.colorscheme "catppuccin-latte"
            vim.cmd.colorscheme "catppuccin-frappe"
        end,
    }
}

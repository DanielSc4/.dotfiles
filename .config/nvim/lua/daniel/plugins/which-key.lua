return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- init = function()
    --     vim.o.timeout = true
    --     vim.o.timeoutlen = 300
    -- end,
    
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "echasnovski/mini.icons",
    },
    opts = {},
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}

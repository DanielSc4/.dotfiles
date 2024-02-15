return {
    "goolord/alpha-nvim",
    lazy = true,
    dependencies = {
        "telescope.nvim",
        "nvim-web-devicons",
    },
    event = { "VimEnter" },
    opts = function()
        local dashboard = require "alpha.themes.dashboard"

        dashboard.section.buttons.val = {
            dashboard.button(
                "SPC f f",
                "  Find file",
                "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob,!.git<CR>"
            ),
            dashboard.button("SPC f h", "󰤘 Recently opened files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("SPC f g", "󱈄 Find word", "<cmd>Telescope live_grep<cr>"),
        }

        return dashboard.config
    end,
}

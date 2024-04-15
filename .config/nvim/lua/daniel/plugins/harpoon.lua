return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon.setup()

        local wk = require("which-key")
        wk.register({
            ["<leader>a"] = {
                name = "Harpoon",
                a = { function()
                    harpoon.list().add()
                end, "Harpoon list" },
            }
        }, {})
    end
}

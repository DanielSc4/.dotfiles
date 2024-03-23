return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},

    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>x"] = {
                 name = "Trouble",
                 x = { function() require("trouble").toggle() end , "Trouble" },
                 w = { function() require("trouble").toggle("workspace_diagnostics") end , "Trouble on Workspace" },
                 d = { function() require("trouble").toggle("document_diagnostics") end , "Trouble on Document" },
                 q = { function() require("trouble").toggle("quickfix") end , "Trouble Quickfix" },
                 l = { function() require("trouble").toggle("loclist") end , "Trouble Location list" },
            }
        }, {})

        vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
    end
}

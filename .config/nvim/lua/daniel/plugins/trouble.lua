return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},

    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>x",  group = "Trouble" },
            { "<leader>xx", function() require("trouble").toggle() end, desc = "Trouble" },
            { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Trouble on Workspace" },
            { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, desc = "Trouble on Document" },
            { "<leader>xq", function() require("trouble").toggle("quickfix") end, desc = "Trouble Quickfix" },
            { "<leader>xl", function() require("trouble").toggle("loclist") end, desc = "Trouble Location list" },
        }, {})

        vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
    end
}

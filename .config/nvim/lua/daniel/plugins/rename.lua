--  LSP renaming with immediate visual feedback thanks to Neovim's command preview feature

return {
    "smjonas/inc-rename.nvim",
    config = function()
        require("inc_rename").setup()
        local wk = require("which-key")
        wk.add({
            {
                "<leader>rn",
                function()
                    local word = vim.fn.expand("<cword>")
                    return ":IncRename " .. word
                end,
                desc = "Rename symbol",
                expr = true,
            },
        })
    end,
}

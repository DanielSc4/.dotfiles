return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { 'lua', 'python', 'rust',  'vimdoc', 'vim', 'bash' },
            auto_install = true,
            sync_install = false,
            highlight = {enable = true},
            indent = {enable = true},
        })
    end
}

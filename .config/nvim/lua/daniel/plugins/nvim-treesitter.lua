return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter.config").setup({
            ensure_installed = { 'lua', 'python', 'rust', 'vimdoc', 'vim', 'bash' },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}

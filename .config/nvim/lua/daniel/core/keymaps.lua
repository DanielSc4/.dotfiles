
-- make space the leader key
vim.g.mapleader = " "

-- half jump to stay in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--  search term to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "nzzzv")

-- paste without rewrite the P register (i.e. without copying)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Esc to clear highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Trying jj to escape
vim.keymap.set("i", "jj", "<Esc>")

-- Duplicate a line and comment out the first line
vim.keymap.set("n", "yc", "yygccp")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})




-- make space the leader key
vim.g.mapleader = " "

-- half jump to stay in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--  search term to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without rewrite the P register (i.e. without copying)
-- vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("x", "p", '"_dP')
-- vim.keymap.set("n", "d", '"_d')
-- vim.keymap.set("n", "D", '"_D')
-- vim.keymap.set("v", "d", '"_d')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "cc", '"_cc')
vim.keymap.set("n", "ce", '"_ce')
vim.keymap.set("n", "ci", '"_ci')


-- Esc to clear highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- jj to escape
vim.keymap.set("i", "jj", "<Esc>")

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



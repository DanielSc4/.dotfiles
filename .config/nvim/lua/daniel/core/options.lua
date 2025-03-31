local opt = vim.opt


-- Enable mouse mode
opt.mouse = 'a'
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- To use NVIM clipboard via ssh
-- vim.g.clipboard = {
--     name = 'OSC 52',
--     copy = {
--         ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--         ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--     },
--     paste = {
--         ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--         ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--     },
-- }
--



vim.opt.clipboard = nil

function unnamed_paste(reg)
    return function(lines)
        local content = vim.fn.getreg('"')
        return vim.split(content, "\n")
    end
end


vim.g.clipboard = {
    name = "dummy clipboard",
    copy = {
        ["+"] = function(lines) end,
        ["*"] = function(lines) end,
    },
    paste = {
        ["+"] = unnamed_paste("+"),
        ["*"] = unnamed_paste("*"),
    },
}

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
        copy_to_unnamedplus(vim.v.event.regcontents)
        local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
        copy_to_unnamed(vim.v.event.regcontents)
    end,
})











-- Enable break indent
opt.breakindent = true
-- Save undo history
opt.undofile = true
-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'



-- line numbers
opt.relativenumber= true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true
opt.scrolloff = 8

-- appearance
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")


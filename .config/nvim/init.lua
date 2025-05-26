require("daniel.core.options")
require("daniel.core.keymaps")

require("daniel.lazy")


-- Autocommands
local aucmd = vim.api.nvim_create_autocmd

local function augroup(name)
    return vim.api.nvim_create_augroup("idr4n/" .. name, { clear = true })
end

-- Autospelling and zen mode for tex and md files
aucmd("BufRead", {
    pattern = { "*.tex", "*.md", "*.typ", "*.qmd" },
    callback = function()
        vim.cmd("setlocal spell spelllang=en_us")
        -- vim.cmd("ZenMode")
    end,
    group = augroup("tex-md_group"),
})

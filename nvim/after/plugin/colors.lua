-- Define your color function
function ColorMeow(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    -- Uncomment these if you want transparent backgrounds
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMeow()

vim.api.nvim_set_hl(0, "NERDTreeCWD", { fg = "#98c379", bold = true })
vim.api.nvim_set_hl(0, "NERDTreeDir", { fg = "#7B4D66" })
vim.api.nvim_set_hl(0, "NERDTreeDirSlash", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "NERDTreeFile", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NERDTreeExecFile", { fg = "#ebbcba" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7b4d66", bg = "none" })

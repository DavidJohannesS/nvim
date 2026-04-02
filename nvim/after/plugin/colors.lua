-- Define your color function
function ColorMeow(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    -- Uncomment these if you want transparent backgrounds
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMeow()

vim.api.nvim_set_hl(0, "NERDTreeCWD", { fg = "#98c379", bold = true })
vim.api.nvim_set_hl(0, "NERDTreeDir", { fg = "#7B4D66" })
vim.api.nvim_set_hl(0, "NERDTreeDirSlash", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "NERDTreeFile", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NERDTreeExecFile", { fg = "#ebbcba" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7b4d66", bg = "none" })
-- Subtle green line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#6a9955" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#98c379", bold = true })

-- Green cursorline background (very soft)
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f2d24" })

-- Visual selection with a green tint
vim.api.nvim_set_hl(0, "Visual", { bg = "#2e3f2e" })
-- Make diff windows stand out more
vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#1f3d2e", fg = "none" })  -- soft green
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2f2a3d", fg = "none" })  -- muted purple
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3d1f1f", fg = "none" })  -- soft red
vim.api.nvim_set_hl(0, "DiffText",   { bg = "#355d44", fg = "#ffffff", bold = true }) -- highlighted changed text
vim.api.nvim_set_hl(0, "DiffBg", { bg = "#101a10" }) -- subtle green tint
vim.o.tabline = "%!v:lua.MyTabline()"

function MyTabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local name = vim.fn.bufname(bufnr)

    -- Extract filename only
    local filename = vim.fn.fnamemodify(name, ":t")

    -- Highlight active tab
    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#" .. " " .. filename .. " "
    else
      s = s .. "%#TabLine#" .. " " .. filename .. " "
    end
  end
  return s .. "%#TabLineFill#"
end
vim.api.nvim_set_hl(0, "IblIndent", { fg = "#4a3340" })   -- your purple accent
vim.api.nvim_set_hl(0, "IblScope",  { fg = "#98c379", bold = true }) -- your bright green
require("ibl").setup {
  scope = { enabled = true },
}

local builtin = require("telescope.builtin")

if vim.g.vscode then
  -- VSCode version: use QuickOpen
  vim.keymap.set("n", "<leader>q", function()
    vim.fn.VSCodeNotify("workbench.action.quickOpen")
  end, { desc = "VSCode: Find files" })
else
  -- Real Neovim version: use Telescope
  vim.keymap.set("n", "<leader>q", builtin.find_files, { desc = "Telescope: Find files" })
end
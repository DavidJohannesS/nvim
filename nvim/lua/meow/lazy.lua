-- init.lua

local home = vim.fn.expand("$HOME")
local obsidian_home = home .. "/gitrepos/home/GENERAL/notes.git/ws/main"
-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set log level to debug
vim.lsp.set_log_level("debug")

-- Configure Lazy.nvim with your plugins
require("lazy").setup({

    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = function() local ok, configs = pcall(require, 'nvim-treesitter.configs') if not ok then return end configs.setup({ ensure_installed = { "lua", "dockerfile", "python", "markdown", "helm", "yaml", "go", "java", "bash" }, highlight = { enable = true, additional_vim_regex_highlighting = true, }, indent = { enable = true, }, }) end },

{
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = obsidian_home,
      },
    },
    legacy_commands = false,
    ui = {
      enable = false,
    },
  },
}
})

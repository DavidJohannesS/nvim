-- init.lua

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
    {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },

    {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },

    'preservim/nerdtree',

    {
        'towolf/vim-helm',
        ft = { "helm", "yaml" },
    },

    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    "tpope/vim-fugitive",
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = function() local ok, configs = pcall(require, 'nvim-treesitter.configs') if not ok then return end configs.setup({ ensure_installed = { "lua", "dockerfile", "markdown", "helm", "yaml", "java", "bash" }, highlight = { enable = true, additional_vim_regex_highlighting = true, }, indent = { enable = true, }, }) end },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup {}
        end
    },

    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            "ansible-lint",
          },
        })
      end,
    },

    {
      'mfussenegger/nvim-jdtls',
    },
})

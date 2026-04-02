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

{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      enable_git_status = true,
      enable_diagnostics = true,
    })
  end
},

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

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = function() local ok, configs = pcall(require, 'nvim-treesitter.configs') if not ok then return end configs.setup({ ensure_installed = { "lua", "dockerfile", "python", "markdown", "helm", "yaml", "go", "java", "bash" }, highlight = { enable = true, additional_vim_regex_highlighting = true, }, indent = { enable = true, }, }) end },

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
            "yamllint",
            "gopls",
          },
        })
      end,
    },

    {
      'mfussenegger/nvim-jdtls',
    },

{
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
  end
},
{
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
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
},
{
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
},
{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {}
},
{
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- Keymaps
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon add file" })

    vim.keymap.set("n", "<leader>m", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon menu" })

    -- Direct file jumps
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(4) end)
  end
}
})

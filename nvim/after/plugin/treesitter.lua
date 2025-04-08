
require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "dockerfile", "helm", "yaml", "java", "bash" }, -- Specify the parsers
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true, -- Also enable Vim's regex-based highlighting
    },
    indent = {
        enable = true,
    },
})

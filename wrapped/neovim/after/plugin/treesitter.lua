-- after/plugin/treesitter.lua — syntax highlighting via treesitter
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
})
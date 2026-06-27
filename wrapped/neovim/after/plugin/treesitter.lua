-- after/plugin/treesitter.lua — syntax highlighting via treesitter
-- ponytail: nvim-treesitter.configs removed upstream; vim.treesitter.start() is the builtin replacement
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
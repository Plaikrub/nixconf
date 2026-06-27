-- init.lua — neovim entry point
-- Loaded by the wrapper's specs.init via require('init')

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers: absolute + relative
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab / indentation: 4-space tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Show invisible characters (tab guides, trailing spaces)
vim.opt.list = true
vim.opt.listchars = {
    tab = "│ ",
    trail = "·",
    nbsp = "␣",
}

-- Vertical guide line at 80 columns
vim.opt.colorcolumn = "80"

-- Better search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Mouse + clipboard
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Don't wrap long lines
vim.opt.wrap = false

-- Faster updatetime
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Persistent undo
vim.opt.undofile = true

-- Termguicolors for syntax highlighting
vim.opt.termguicolors = true
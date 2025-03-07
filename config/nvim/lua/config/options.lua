-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = false -- Use actual tab characters (not spaces)
vim.opt.tabstop = 4 -- Set tab width to 8 spaces (Linux Kernel standard)
vim.opt.shiftwidth = 4 -- Indentation width is 8 spaces
vim.opt.softtabstop = 4 -- Make backspace work properly with tabs
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = { tab = "→·", trail = "·", extends = ">", precedes = "<" } -- Show tabs as →·
vim.opt.colorcolumn = "81" -- Show a vertical line at column 81

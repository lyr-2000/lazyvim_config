-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

opt.relativenumber = true
opt.termguicolors = true
opt.showcmd = true
opt.wildmenu = true
opt.backspace = "indent,eol,start"

vim.cmd([[
set clipboard=unnamedplus
]])

vim.cmd([[
set laststatus=2

]])

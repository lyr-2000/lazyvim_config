-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- This file is automatically loaded by lazyvim.config.init
-- local Util = require("lazyvim.util")
--
-- -- DO NOT USE THIS IN YOU OWN CONFIG!!
-- -- use `vim.keymap.set` instead
-- local map = Util.safe_keymap_set
--
vim.cmd("set clipboard=unnamedplus")

local map = vim.keymap.set

vim.keymap.set("n", "<S-h>", "^")
vim.keymap.set("n", "<S-l>", "$")
--  buffer切换
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-l>", "<C-w>l")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-S-j>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<A-S-k>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<A-S-h>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<A-S-l>", "<cmd>vertical resize +2<cr>")
vim.keymap.set("n", "<A-i>", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<A-i>", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<A-;>", "<C-w>|")
vim.keymap.set("n", "<A-q>", "<cmd>bd<cr>")

-- buffers
map("n", "<A-n>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<A-m>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- map("c", "w!!", "w !sudo tee > /dev/null %", { desc = "must write" })
map("c", "<C-a>", "SudaWrite", { desc = "must write" })

local builtin = require("telescope.builtin")
-- grep search https://github.com/BurntSushi/ripgrep#installation
map("n", "gf", builtin.live_grep)

map("i", "<S-Insert>", "<ESC>pi")

-- debug 快捷键配置
--

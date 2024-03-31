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
local del = vim.keymap.del
del("n", "<c-/>", {})
del("n", "<c-_>", {})
del("t", "<c-/>", {})
del("t", "<c-_>", {})

-- map("n", "<c-/>", "gcc")
-- map("n", "<c-_>", "gcc")

vim.cmd("nmap <C-_> gcc")
vim.cmd("nmap <C-/> gcc")

map("n", "<S-h>", "^")
map("n", "<S-l>", "$")
--  buffer切换
map("n", "<A-h>", "<C-w>h")
map("n", "<A-l>", "<C-w>l")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-S-j>", "<cmd>resize -2<cr>")
map("n", "<A-S-k>", "<cmd>resize +2<cr>")
map("n", "<A-S-h>", "<cmd>vertical resize -2<cr>")
map("n", "<A-S-l>", "<cmd>vertical resize +2<cr>")
map("n", "<A-i>", "<cmd>Telescope oldfiles<cr>")
map("n", "<A-i>", "<cmd>Telescope oldfiles<cr>")
map("n", "<A-;>", "<C-w>|")
map("n", "<A-q>", "<cmd>bd<cr>")

-- buffers
map("n", "<A-n>", "<cmd>bprevious<cr>", {
  desc = "Prev buffer",
})
map("n", "<A-m>", "<cmd>bnext<cr>", {
  desc = "Next buffer",
})

-- map("c", "w!!", "w !sudo tee > /dev/null %", { desc = "must write" })
map("c", "<C-a>", "SudaWrite", {
  desc = "must write",
})

local builtin = require("telescope.builtin")
-- grep search https://github.com/BurntSushi/ripgrep#installation
map("n", "gf", builtin.live_grep)

map("i", "<S-Insert>", "<ESC>pi")

-- debug 快捷键配置
--
-- :verbose map

-- lsp install

map("n", "<C-x>", "<cmd>Mason<cr>")

-- 回调函数执行
-- map("n", "<leader>0", function()
-- print("demo")
-- end)

function domsg(s)
  vim.notify(s)
end

map("n", "<leader>a", function()
  vim.notify("heloworld")
end)

map("n", "<C-x>", function()
  if isdap() then
    local dapui = require("dapui")
    dapui.toggle({})
    return
  end
end)

function isdap()
  local dap = require("dap")
  local status = dap.status()
  if status == nil or status == "" then
    return false
  end
  return true
end

function createFile()
  -- local api = require("nvim-tree.api")
  -- api.fs.create()
  domsg("please press key a or A for create file or dir")
end

map("n", "<C-n>", function()
  if isdap() then
    local dap = require("dap")
    dap.step_over()
    return
  end
  createFile()
end)

map("n", "<C-i>", function()
  if isdap() then
    local dap = require("dap")
    dap.step_into()
    return
  end
end)
map("n", "<C-o>", function()
  if isdap() then
    local dap = require("dap")
    dap.continue()
    return
  end
end)

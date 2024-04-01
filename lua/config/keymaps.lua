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

local utils = require("gkit")

vim.cmd("nmap <C-_> gcc")
vim.cmd("nmap <C-/> gcc")

local map = vim.keymap.set
local del = vim.keymap.del
del("n", "<c-/>", {})
del("n", "<c-_>", {})
del("t", "<c-/>", {})
del("t", "<c-_>", {})

-- map("n", "<c-/>", "gcc")
-- map("n", "<c-_>", "gcc")

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
-- map("n", "<A-q>", "<cmd>bd<cr>")

-- mp4viewer.lua
-- guide: https://github.com/glepnir/nvim-lua-guide-zh
-- 定义弹出确认框并处理保存的函数
local function quit()
  return vim.cmd("bd")
  --[[
  if vim.api.nvim_buf_get_changedtick(0) ~= 0 then
    -- 弹出确认框询问是否保存
    local ok, answer = pcall(vim.fn.confirm, "File has been modified. Save changes?", "yes", "no")

    -- 根据用户的选择处理保存
    if ok and answer == 1 then
      -- 用户选择保存，调用 Vim 命令保存并退出
      vim.cmd("w")
      vim.cmd("bd")
    elseif ok and answer == 2 then
      -- 用户选择不保存，直接退出
      vim.cmd("bd")
    end
  else
    -- 没有未保存的更改，直接退出
    vim.cmd("bd")
  end
  --]]
end

-- 设置自动命令，在尝试退出包含 MP4 文件的缓冲区时调用确认函数
vim.api.nvim_command("autocmd BufLeave *.mp4 lua MP4Viewer_ConfirmQuit()")

map("n", "<A-q>", function()
  -- vim.cmd("bd")
  quit()
end)

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

local function domsg(s)
  vim.notify(s)
end


map("n", "<leader>a", function()
  utils.test()
  vim.notify("heloworld")
end)

map("n", "<C-x>", function()
  if isdap() then
    local dapui = require("dapui")
    dapui.toggle({})
    return
  end
end)

local function isdap()
  local dap = require("dap")
  local status = dap.status()
  if status == nil or status == "" then
    return false
  end
  return true
end

local function createFile()
  -- local api = require("nvim-tree.api")
  -- api.fs.create()
  domsg("please press key a or A for create file or dir")
end

-- example:
-- nnoremap <leader>d :lua require 'dap'.toggle_breakpoint() <CR>
--

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

-- 移动 buffer
local moveBy = function(dir)
  if dir == "left" then
    dir = -1
  else
    dir = 1
  end
  local moveBy = vim.v.count
  if moveBy == 0 then
    moveBy = 1
  end
  local myBufferline = require("bufferline")
  for _ = 1, moveBy, 1 do
    myBufferline.move(dir)
  end
end

vim.keymap.set("n", "<b", function()
  moveBy("left")
end, { desc = "Move current buffer to left" })
vim.keymap.set("n", ">b", function()
  moveBy("right")
end, { desc = "Move current buffer to right" })





-- Function to create or toggle a floating window
local function toggle_float_win()
    if float_win and vim.api.nvim_win_is_valid(float_win) then
        -- If the floating window is already open, close it
        vim.api.nvim_win_close(float_win, true)
        float_win = nil
    else
        -- If the floating window is not open, create it
        local buf = vim.api.nvim_create_buf(false, true)
        local width = 40
        local height = 10
        local row = vim.o.lines - height - 3
        local col = vim.o.columns - width - 3
        float_win = vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
            style = 'minimal'
        })
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 'Floating Window Content' })
    end
end


map("n","<C-h>",function ()
  
  toggle_float_win()
end)
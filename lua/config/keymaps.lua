-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- This file is automatically loaded by lazyvim.config.init local Util = require("lazyvim.util")
--
-- -- DO NOT USE THIS IN YOU OWN CONFIG!!
-- -- use `vim.keymap.set` instead
-- local map = Util.safe_keymap_set
--

local gkit = require("gkit")

local function isdap()
  local dap = require("dap")
  local status = dap.status()
  if status == nil or status == "" then
    return false
  end
  return true
end
-- vim.cmd("nmap <C-_> gcc")
-- vim.cmd("nmap <C-/> gcc")

local map = vim.keymap.set
local del = vim.keymap.del
del("n", "<c-/>", {})
del("n", "<c-_>", {})
del("t", "<c-/>", {})
del("t", "<c-_>", {})

-- del("n", "<C-t>", {})
-- map("n", "<leader>t", "<space>fT", { desc = "show ter" })
del("n", "t", {})

local lazyterm = function()
  require("lazyvim.util").terminal.open(nil, { cwd = require("lazyvim.util").root.get() })
end

map("n", "<C-t>", lazyterm, { desc = "show ter" })
-- map("n", "<A-t>", ":echo 'abc'", { desc = "show ter" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "hide ter" })
map("t", "<C-_>", "<cmd>close<cr>", { desc = "hide ter" })
map("t", "<C-t>", "<cmd>close<cr>", { desc = "hide ter" })
map("t", "<C-l>", "clear<enter>", { desc = "clear terminal" })
map("n", "f", "s", {  })
map("n", "F", "s", {  })



map("n", "<a-[>", "<C-o>", { desc = "prev pos" })
map("n", "<a-]>", "<C-i>", { desc = "next pos" })

map("n", "U", "<cmd>redo<cr>")

map("n", "f", "s")
map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")
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

map("n", "<leader>p", "<nop>")

-- map("n", "<A-q>", "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>")

-- mp4viewer.lua
-- guide: https://github.com/glepnir/nvim-lua-guide-zh
-- 定义弹出确认框并处理保存的函数
local function quit()
  return vim.cmd("bd")
end

-- 设置自动命令，在尝试退出包含 MP4 文件的缓冲区时调用确认函数
-- bbssss

map("n", "<A-q>", ":bp<bar>sp<bar>bn<bar>bd<CR>")

map("n", "<C-w><A-q>", "<cmd>BufferLineCloseOthers<cr>")

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

map("n", "gff", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.getcwd()
  })

end, {
  desc = "find files",
})

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
  gkit.test()
  vim.notify("heloworld")
end)

map("n", "<C-x>", function()
  if isdap() then
    local dapui = require("dapui")
    dapui.toggle({})
    return
  end
end)


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

-- map("n,i","<C-i>",vim.diagnostic.open_float)

map("n", "<C-k>", function()
  -- print('end')
  if isdap() then
    local dap = require("dap")
    dap.stop()
    -- print("stop dap")
    return
  else
  end
end)

map("n", "<C-o>", function()
  -- print('end')
  if isdap() then
    local dap = require("dap")
    dap.step_out()
    -- print("step out")
    return
  else
  end
end)

map({ "n" }, "<C-i>", function()
  if isdap() then
    local dap = require("dap")
    dap.step_into()
    -- print("step into")
    return
  else
    -- vim.cmd("<C-h>")
  
  end
end)



map({"n","i"}, "<C-l>", function () 
  -- todo , 判断类型
  vim.cmd(':execute "normal! \\<ESC>A;"')
end, { desc = "<nop>" })


map("n", "<C-c>", function()
  if isdap() then
    local dap = require("dap")
    dap.run_to_cursor()
    return
  end
end)
map("n", "<C-m>", function()
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

-- demo
-- map("n", "<C-q>", function()
-- toggle_float_win()
-- end)
--

-- map("n", "<c-_>","<cmd>Commentary<cr>",{desc="toggle comment"})
-- map("n", "<c-/>",  toggleComment,{desc="toggle comment"})
--
-- map("v", "<c-_>",  toggleComment,{desc="toggle comment"})
-- map("v", "<c-/>",  toggleComment,{desc="toggle comment"})

local command_keymappings = {
  ["FoldAll"] = "<leader>zc",
  ["UnFoldAll"] = "<leader>zo",
  ["FindCommands"] = { modes = "n,i,v", keys = "<C-p>" },
  ["FormatCode"] = { modes = "n,v", keys = "<leader>ff", opt = { desc = "format entire fire" } },
  -- ["FormatCode"] = { modes = "n,v", keys = "<leader>ff",opt = {desc="format entire fire"} },
  ["Commentary"] = {
    modes = "n",
    keys = { "<c-_>", "<c-/>" },
  },
  -- ["echo 'demo'"] = { modes = "n,v", keys = "<A-S-f>" },
}
vim.keymap.set("v", "<C-_>", ":'<,'>Commentary<cr>")
-- neovide use <D-key> represents the cmd key in mac
local function convertNeovideCMDKey(key)
  if vim.g.neovide then
    return string.gsub(key, "M%-", "D-")
  else
    return key
  end
end

local function getKey(keybinding)
  if type(keybinding) == "string" then
    return keybinding
  else
    return keybinding.keys
  end
end
local function registerKeys()
  for command, keybinding in pairs(command_keymappings) do
    local key = convertNeovideCMDKey(getKey(keybinding))
    if type(key) == "string" then
      local modes = keybinding.modes and vim.split(keybinding.modes, ",") or { "n" }
      local opt = keybinding.opt or {}
      vim.keymap.set(modes, key, "<CMD>" .. command .. "<CR>", opt)
    else
      for _, key in pairs(key) do
        local modes = keybinding.modes and vim.split(keybinding.modes, ",") or { "n" }
        local opt = keybinding.opt or {}
        vim.keymap.set(modes, key, "<CMD>" .. command .. "<CR>", opt)
      end
    end
  end
end

registerKeys()

-- lang
--
--

-- local range_formatting = function()
--   local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
--   local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
--   vim.lsp.buf.format({
--     range = {
--       ["start"] = { start_row, 0 },
--       ["end"] = { end_row, 0 },
--     },
--     async = true,
--   })
-- end

-- vim.keymap.set({ "v" }, "<leader>ff", range_formatting, { desc = "Range format" })

map("n", "<leader>cc", function(evt)
  if vim.bo.filetype == nil then
    error("invalid")
    return
  end
  local ft = vim.bo.filetype
  if ft == "cpp" then
    vim.cmd([[
            !g++ -g % -o %<.out
        ]])
  else
    print("illegal file type " .. ft)
  end
  -- vim.cmd(
  --   [[
  -- func! compileRunGcc()
  --   exec "w"
  --   if &filetype == 'c'
  --           exec "!g++  % -o %<"
  --   elseif &filetype == 'cpp'
  --           exec "!g++  % -o %<"
  --   endif
  --
  --   endfunc
  -- <cmd>compileRunGcc()<cr>
  -- ]])
end)

map("n", "<leader>kp", function()
  -- open curr dir
  vim.cmd(":tabe %:h")
end, {
  desc = "open vim config ",
})






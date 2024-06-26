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

-- local gkit = require("gkit")
local safe = require("gkit/safe")

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

-- map("n","<C-scrollWheelUp>","<C-=>")
-- map("n","<C-scrollWheelDown>","<C-->")
--

map("i", "<c-z>", function()
  vim.cmd("normal! u")
end)

map("i", "<c-s-z>", function()
  vim.cmd("redo")
end)



map("n", "<C-t>", lazyterm, { desc = "show ter" })
-- map("n", "<A-t>", ":echo 'abc'", { desc = "show ter" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "hide ter" })
map("t", "<C-_>", "<cmd>close<cr>", { desc = "hide ter" })
map("t", "<C-t>", "<cmd>close<cr>", { desc = "hide ter" })
map("t", "<C-l>", "clear<enter>", { desc = "clear terminal" })

-- del("n","f",{})
-- map({"n","x","o"}, "f", function() require("flash").jump() end, {desc = "map func"})
-- map({"n","x","o"}, "F", function() require("flash").jump() end, {desc = "map func"})

map("n", "<a-[>", "<C-o>", { desc = "prev pos" })
map("n", "<a-]>", "<C-i>", { desc = "next pos" })

map("n", "U", "<cmd>redo<cr>")


map({ "n" }, "<leader>h", function()
  vim.cmd("normal! H")
end, { desc = "top of screen" })

map({ "n" }, "<leader>l", function()
  vim.cmd("normal! L")
end, { desc = "bottom of screen" })

map({ "n" }, "<leader>jo", function()
  local shellv = "open"
  local filename = vim.fn.expand("%:p:h")
  local ret = vim.fn.system("nohup " .. shellv .. " '" .. filename .. "' ")
end, { desc = "open directory" })

map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")
--  buffer切换
map({ "n", "v" }, "<A-h>", "<C-w>h")
map({ "n", "v" }, "<A-l>", "<C-w>l")
map({ "n", "v" }, "<A-j>", "<C-w>j")
map({ "n", "v" }, "<A-k>", "<C-w>k")

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

map("n", "gf", function()
  require("telescope.builtin").live_grep({
    cwd = vim.fn.getcwd(),
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

map("n", "<leader>a", "ggVG", { desc = "select all" })
-- map("n", "<leader>a", function()
--   -- gkit.test()
--   -- vim.notify("heloworld")
--   vim.cmd("ggVG")
-- end)

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


local function putchar(sh)
  -- Get the current line number and column
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_number, column = cursor[1], cursor[2]

  -- Get the content of the current line
  local line_content = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

  -- Calculate the length of the line content
  local line_length = string.len(line_content)

  -- Calculate the column position to insert text
  local insert_column = line_length + 1

  -- Set the cursor position to the desired column
  vim.api.nvim_win_set_cursor(0, { line_number, insert_column })

  -- Insert text at the end of the line
  vim.api.nvim_put({ sh }, "", true, true)
end


map({ "n", "i" }, "<C-l>", function()
  local filename = vim.fn.expand("%:p")
  -- if markdown file, press c-l insert char '。'
  if string.find(filename, '.md') ~= nil then
    -- putchar("。")
    safe.run(putchar, "。")
    return
  end
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
  ["MarkdownPreview"] = { modes = "n", keys = { "<leader>kv", "<C-k>v" }, opt = { desc = "preview markdown" } },
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
    print("illegal file type compile " .. ft)
  end
end, { desc = "compile code file" })

map("n", "<leader>kp", function()
  -- open curr dir
  vim.cmd(":tabe %:h")
end, {
  desc = "open vim config ",
})

map("v", "gr", ":s///g<left><left><left>", { desc = "replace global" })
map("n", "gr", "vawy:%s///g<left><left><left><C-r>+<right>", { desc = "replace word" })

-- map("n","gk",function(opt)
--   return vim.lsp.buf.references(opt)
-- end,{desc="replace word"})

map("n", "gk", "<cmd>Telescope lsp_references<CR>", { desc = "References" })

map("n", "<leader>ka", function()
  vim.cmd("CompetiTest add_testcase")
end, { desc = "add test case" })

map("n", "<leader>kd", "<cmd>CompetiTest delete_testcase<cr>", { desc = "del test" })
map("n", "<leader>ke", "<cmd>CompetiTest edit_testcase<cr>", { desc = "edit test" })
map("n", "<leader>kr", function()
  vim.notify("test run")
  vim.cmd("CompetiTest run")
end, { desc = "runt test" })

-- map({"n","i"},"<c-s-{>","zc")
-- map({"n","i"},"<c-s-}>","zo")

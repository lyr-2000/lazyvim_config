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

-- local command_keymaps = {
--     ["DebugToggleUI"] = "<C-u>"

-- }

-- for k, v in pairs(command_keymaps) do
--    map("n",k,v)
-- end

-- lsp install

map("n", "<C-x>", "<cmd>Mason<cr>")

-- 回调函数执行
-- map("n", "<leader>0", function()
-- print("demo")
-- end)

map("n", "<leader>a", function()
  vim.notify("heloworld")
  --notify({
  --  msg = "helloworld",
  --  level = "info",
  --})
end)

local dap = require("dap")
local dapui = require("dapui")

map("n", "<C-x>", function()
  dapui.toggle({})
end)

map("n", "<C-n>", function()
  -- local dap = require("dap")
  -- local session = dap.session()
  -- if session == nil then
  --   print('helloworld')
  --   return
  -- end
  local status = dap.status()
  if status == nil or status == "" then
    return
  end
  dap.step_over()
end)

map("n", "<C-i>", function()
  dap.step_into()
end)
map("n", "<C-o>", function()
  dap.step_continue()
end)

-- keys = {{
--   "<leader>dB",
--   function()
--       require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
--   end,
--   desc = "Breakpoint Condition"
-- }, {
--   "<leader>db",
--   function()
--       require("dap").toggle_breakpoint()
--   end,
--   desc = "Toggle Breakpoint"
-- }, {
--   "<leader>dc",
--   function()
--       require("dap").continue()
--   end,
--   desc = "Continue"
-- }, {
--   "<leader>da",
--   function()
--       require("dap").continue({
--           before = get_args
--       })
--   end,
--   desc = "Run with Args"
-- }, {
--   "<leader>dC",
--   function()
--       require("dap").run_to_cursor()
--   end,
--   desc = "Run to Cursor"
-- }, {
--   "<leader>dg",
--   function()
--       require("dap").goto_()
--   end,
--   desc = "Go to Line (No Execute)"
-- }, {
--   "<leader>di",
--   function()
--       require("dap").step_into()
--   end,
--   desc = "Step Into"
-- }, {
--   "<leader>dj",
--   function()
--       require("dap").down()
--   end,
--   desc = "Down"
-- }, {
--   "<leader>dk",
--   function()
--       require("dap").up()
--   end,
--   desc = "Up"
-- }, {
--   "<leader>dl",
--   function()
--       require("dap").run_last()
--   end,
--   desc = "Run Last"
-- }, {
--   "<leader>do",
--   function()
--       require("dap").step_out()
--   end,
--   desc = "Step Out"
-- }, {
--   "<leader>dO",
--   function()
--       require("dap").step_over()
--   end,
--   desc = "Step Over"
-- }, {
--   "<leader>dp",
--   function()
--       require("dap").pause()
--   end,
--   desc = "Pause"
-- }, {
--   "<leader>dr",
--   function()
--       require("dap").repl.toggle()
--   end,
--   desc = "Toggle REPL"
-- }, {
--   "<leader>ds",
--   function()
--       require("dap").session()
--   end,
--   desc = "Session"
-- }, {
--   "<leader>dt",
--   function()
--       require("dap").terminate()
--   end,
--   desc = "Terminate"
-- }, {
--   "<leader>dw",
--   function()
--       require("dap.ui.widgets").hover()
--   end,
--   desc = "Widgets"
-- }},

-- config = function()
--   local Config = require("lazyvim.config")
--   vim.api.nvim_set_hl(0, "DapStoppedLine", {
--       default = true,
--       link = "Visual"
--   })

--   for name, sign in pairs(Config.icons.dap) do
--       sign = type(sign) == "table" and sign or {sign}
--       vim.fn.sign_define("Dap" .. name, {
--           text = sign[1],
--           texthl = sign[2] or "DiagnosticInfo",
--           linehl = sign[3],
--           numhl = sign[3]
--       })
--   end
-- end

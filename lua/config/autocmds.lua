-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, {
    clear = true,
  })
end

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false -- 覆盖默认的 true
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("associate_filetype"),
--   pattern = { "htmldjango" },
--   callback = function()
--     vim.api.nvim_command("set filetype=html")
--   end,
-- })

-- change c/cpp file tab width to 4 spaces
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("associate_filetype"),
  pattern = { "c", "cpp", "rust" },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.formatoptions:remove({ "o" })
  end,
})

-- https://github.com/RaafatTurki/hex.nvim/blob/master/lua/hex.lua

-- local mp4 = require("gkit/mp4")

-- -- 当打开 MP4 文件时自动调用显示信息的函数
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   group = augroup("MP4Viewer"),
--   pattern = { "*.mp4" },
--   callback = function()
--     if true then
--         mp4.openWin("read")
--     end
--   end,
-- })

-- -- 当打开 MP4 文件时自动调用显示信息的函数
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = augroup("MP4ViewerEnter"),
--   pattern = { "*.mp4" },
--   callback = function()
--     if true then 
--         mp4.openWin("enter")
--     end
--     -- local filename = vim.api.nvim_buf_get_name(bufnr)
--   end,
-- })

-- vim.api.nvim_create_autocmd("BufLeave", {
--   group = augroup("MP4ViewerClean"),
--   pattern = { "*" },
--   callback = function()
--     -- local lua = require("gkit/pdf")
--     mp4.closeWin("leave")
--   end,
-- })

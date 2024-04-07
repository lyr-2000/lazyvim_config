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
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("MP4ViewerEnter"),
  pattern = { "*.mp4" ,"*.pdf","*.mp3","*.avi"},
  callback = function(evt)
    local mp4 = require("gkit/mp4")
    -- mp4.openWin(evt)
    local ok, err = pcall(mp4.openWin, evt)
    if not ok then
      print("ERROR: ", err)
    end
  end,
})

-- vim.api.nvim_create_autocmd("BufLeave", {
--   group = augroup("MP4ViewerClean"),
--   pattern = { "*" },
--   callback = function()
--     -- local lua = require("gkit/pdf")
--     mp4.closeWin("leave")
--   end,
-- })



-- Open Dashboard after deleting the last buffer (Uses bufdelete plugin)
vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePre *",
  group = "dashboard_on_empty",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)

    if name == "" then
      local current_win = vim.api.nvim_get_current_win()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if win ~= current_win then
          vim.api.nvim_win_close(win, false)
        end
      end

      local current_tab = vim.api.nvim_get_current_tabpage()
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        if tab ~= current_tab then
          vim.api.nvim_tabpage_close(tab, false)
        end
      end

      vim.cmd.Dashboard()
    end
  end,
})



-- Fix go files on save
-- vim.api.nvim_create_augroup("fix_go_on_save", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = "fix_go_on_save",
--   pattern = { "*.go" },
--   callback = function()
--     vim.cmd("!golangci-lint run --fix")
--   end,
-- })



-- local safe = require("gkit/safe")

-- -- Disable the concealing in some file formats 
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = augroup("markdownkey"),
--   pattern = { "markdown" },
--   callback = function(event)
--      vim.wo.conceallevel = 0
--     safe.run(require("gkit/md").bindkey,event)
--   end,
-- })

-- if safe ~= nil then 
--   safe.run(require("gkit/md").setup)
-- end



  --Automatically switch to Chinese input method when code comments, otherwise switch to English input method
  
  require("gkit/fcitx").setup({
    text = { -- 自动切换输入法的文档 
      "*.md",
      "*.txt",
    },
    code = { -- 注释时自动切换输入法的语言,
      "*.lua",
      "*.c",
      "*.cpp",
      "*.py",
      "*.go",
      "*.lua",
    },
    en = "fcitx-remote -o",
    zh = "fcitx-remote -c",
    check = "fcitx-remote",
    zh_code = 1, -- fcitx_code=1 is chinese input method mode
  })

-- require("gkit/lang").setup()


local safe = require("gkit/safe")

if safe ~= nil then 
  -- safe.run(require("gkit/md").setup)
  safe.run(require("gkit/lang").setup())
end

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, {
        clear = true
    })
end

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = {"gitcommit", "markdown"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = false -- 覆盖默认的 true
    end
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
    pattern = {"c", "cpp", "rust"},
    callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.formatoptions:remove({"o"})
    end
})

-- https://github.com/RaafatTurki/hex.nvim/blob/master/lua/hex.lua

-- -- 当打开 MP4 文件时自动调用显示信息的函数  
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = augroup("mp4"),
--   pattern = {"*.mp4"},
--   callback = function()
--     -- vim.opt.shiftwidth = 4
--     -- vim.opt.formatoptions:remove({ "o" })
--     -- MP4Viewer_ShowInfo()
--     create_float_window("hellowolrd")
--   end,
-- })

-- -- Define a function to open MP4 viewer
-- function openMP4Viewer()
--     -- Check if the file is MP4
--     if vim.bo.filetype == 'mp4' then
--         -- Hide the content of the current window
--         vim.opt_local.bufhidden = 'hide'
--         vim.opt_local.buflisted = false

--         -- Define the content for the floating window
--         local content = {'MP4 Content Here'}

--         -- Calculate window size and position
--         local width = 40
--         local height = 10
--         local row = 1
--         local col = 1

--         -- Create a new floating window
--         local win_id = vim.api.nvim_open_win(0, true, {
--             relative = 'editor',
--             width = width,
--             height = height,
--             row = row,
--             col = col,
--             style = 'minimal'
--         })

--         -- Set the content of the floating window
--         vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
--     end
-- end

-- -- Auto command to call openMP4Viewer function when opening a buffer
-- -- vim.cmd([[
-- --     augroup MP4Viewer
-- --         autocmd!
-- --         autocmd BufReadPost *.mp4 lua openMP4Viewer()
-- --     augroup END
-- -- ]])


-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("MP4Viewer"),
--   pattern = {"*.mp4"},
--   callback = function()
--       -- vim.opt.formatoptions:remove({"o"})
--       openMP4Viewer()
--   end
-- })
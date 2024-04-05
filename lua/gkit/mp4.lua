-- local float_win = nil
local prevbuf = -1
local shellv = "google-chrome"

-- local prefile = ""
local function debug(s)
   -- print(s)
end

-- local function toggle_float_win(closeview)
--   debug("debug")
--   if float_win and vim.api.nvim_win_is_valid(float_win) then
--     -- If the floating window is already open, close it
--     vim.api.nvim_win_close(float_win, true)
--     float_win = nil
--   else
--     -- If the floating window is not open, create it
--     local buf = vim.api.nvim_create_buf(false, true)
--     local width = 40
--     local height = 10
--     local row = vim.o.lines - height - 3
--     local col = vim.o.columns - width - 3
--     float_win = vim.api.nvim_open_win(buf, true, {
--       relative = "editor",
--       width = width,
--       height = height,
--       row = row,
--       col = col,
--       style = "minimal",
--     })
--     vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Floating Window Content" })
--   end
-- end
--
--

-- local function openWin2(s)
--   local filename = vim.fn.expand("%:p")
--   local api = vim.api
--   local b0 = vim.fn.bufnr("#")
--   if string.find(filename, ".mp4") ~= nil then
--     api.nvim_buf_set_lines(b0, 0, -1, false, { "This is a binary file. Content not available." })

--     -- 绑定按键 'o' 到一个函数，用于在浏览器中打开文件
--     api.nvim_buf_set_keymap(b0, 'n', 'o', '<Cmd>echo "abc"<CR>', { noremap = true })
--   end
-- end

local function closeWin(evt)
  -- if float_win and vim.api.nvim_win_is_valid(float_win) then
  -- If the floating window is already open, close it
  -- vim.api.nvim_win_close(float_win, true)
  float_win = nil
  -- debug("debug close win")
  vim.cmd("bd")
  if prevbuf >= 0 then
    -- vim.cmd(":bd")
    -- vim.cmd("bp<bar>sp<bar>bn<bar>bd<CR>")
  end
  -- prevbuf = -1
  -- else
  --     prevbuf = -1
  --     return nil
  -- end
end

local function openWin2(event)
  vim.api.nvim_command("bd")

end



-- local function Quit()
--   if vim.fn.winnr('$') > 1 or vim.fn.getline(1, '$') == {''} and vim.fn.bufname('%') == '' then
--     vim.cmd('quit')
--   else
--     vim.cmd('enew')
--   end
-- end


local function openWin(event)
  if event.buf == nil then
    print('error')
    print(event)
    return

  end
  -- print("occur return")
  -- print('doit'..event.buf)
  --   vim.bo[event.buf].buflisted = false
  vim.bo[event.buf].buftype = 'nofile'
  -- prevent to quit vim
  -- vim.keymap.set("n", "q", ":bp<bar>sp<bar>bn<bar>bd<CR>", {
  --   buffer = event.buf,
  --   silent = true
  -- })
  -- vim.api.nvim_command("bd")

  local buf = vim.api.nvim_create_buf(true,true)
  local filename = vim.fn.expand("%:p")
  -- if string.find(filename,".mp4") == nil then
  --     return
  -- end
  local width = vim.o.columns - 4
  local height = 11
  if (vim.o.columns >= 85) then
    width = 80
  end
  local row = vim.o.lines - height - 3
  local col = vim.o.columns - width - 3
  vim.api.nvim_buf_set_lines(buf, 0, -1, false,
    { "file paths: " .. "" .. filename, "Press Key: ", "O:     -  Open File with browsers", "Q:     -  quit buffer",
      "F:     -  Open directory " })
  vim.keymap.set("n", "q", ":bp<bar>sp<bar>bn<bar>bd<CR>", {
    silent = true,
    buffer = buf,

  })
  vim.keymap.set("n", "o", "", {
    silent = true,
    buffer = buf,
    callback = function()
      debug("vcl " .. filename)
      local ret = vim.fn.system("nohup " .. shellv .. " '" .. filename .. "' &")
      debug(ret)
    end

  })
  local ppath = vim.fn.expand("%:p:h")

  vim.keymap.set( "n", "f", "", {
    buffer = buf,
    callback = function()
      debug(ppath)
      local ret = vim.fn.system("nohup " .. "open " .. " '" .. ppath .. "'" .. " ")
      debug(ret)
    end,
    silent = true
  })
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_delete(event.buf,{force=true})
  vim.api.nvim_buf_set_name(buf,filename ..".dashboard")
  -- print('done it end')
  -- local float_win = vim.api.nvim_open_win(buf, true, {
  --   relative = "editor",
  --   width = width,
  --   height = height,
  --   col = math.min((vim.o.columns - width) / 2),
  --   row = math.min((vim.o.lines - height) / 2 - 1),
  --   style = "minimal"
  -- })
end

return {
  -- toggleview = toggle_float_win,
  --  closeWin = closeWin,
  openWin = openWin
}

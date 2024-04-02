local float_win = nil
local prevbuf = -1
local shellv = "google-chrome"

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

local function closeWin()
  if float_win and vim.api.nvim_win_is_valid(float_win) then
    -- If the floating window is already open, close it
    vim.api.nvim_win_close(float_win, true)
    float_win = nil
    debug("debug close win")
    if prevbuf >= 0 then
      -- vim.cmd(":bd")
      vim.cmd("echo 'aaa'")
    end
    prevbuf = -1
  else
    return nil
  end
end

local function openWin()
  debug("debug open win")
  if float_win and vim.api.nvim_win_is_valid(float_win) then
    -- If the floating window is already open, close it
    return float_win
  else
    local b0 = vim.fn.bufnr("#")
    prevbuf = b0
    -- If the floating window is not open, create it
    local buf = vim.api.nvim_create_buf(false, true)
    local filename = vim.fn.expand("%:p")
    -- local width = 200
    -- local height = 100
    local width = vim.o.columns - 4
    local height = 11
    if (vim.o.columns >= 85) then
        width = 80
    end
    local row = vim.o.lines - height - 3
    local col = vim.o.columns - width - 3
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      "O      - Open File with browsers",
      "Q      -  quit buffer",
    })
    float_win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = math.min((vim.o.columns - width) / 2),
      row = math.min((vim.o.lines - height) / 2 - 1),
      style = "minimal",
      -- ahchor = 'NW',
    })
    vim.api.nvim_buf_set_keymap(buf, "n", "o", "", {
      silent = true,
      callback = function()
        debug("vcl " .. filename)
        local ret = vim.fn.system("nohup " .. shellv .. " " .. filename .. " &")
        debug(ret)
      end,
    })
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
      callback = function()
        closeWin()
      end,
      silent = true,
    })
  end
end

return {
  -- toggleview = toggle_float_win,
  closeWin = closeWin,
  openWin = openWin,
}

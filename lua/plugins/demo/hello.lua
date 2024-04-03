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
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
    })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Floating Window Content" })
  end
end

return {}

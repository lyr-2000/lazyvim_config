
local function bindkey(evt)
  if not evt then 
    vim.notify("error occur "..tostring("no event params"))
    return
  end

  vim.keymap.set({"n","i"}, "<C-v>", "", {
    buffer = evt.buf,
    silent = true,
    callback= function()
      vim.cmd("PasteImage")
    end
  })

end



return {
  bindkey = bindkey
}

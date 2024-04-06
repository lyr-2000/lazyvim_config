
local function pasteImage(evt)
  if not evt then 
    vim.notify("error occur "..tostring("no event params"))
    return
  end

  vim.keymap.set({"n","i"}, "<C-v>", "", {
    buffer = evt.buf,
    silent = true,
    callback= function()
      vim.cmd("PasteImage")
      -- local cwd = vim.fn.getcwd()
      -- require("img-clip").paste_image({},tostring(cwd).."/".."static/image/mdfiles/")
    end
  })

end

local run = require("gkit/safe").run

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, {
    clear = true,
  })
end

local function bindkey() 
    -- Disable the concealing in some file formats 
  vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup("markdownkey"),
    pattern = { "markdown" },
    callback = function(event)
      run(pasteImage,event)
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("markStyle-links"),
    pattern = { "markdown" },
    callback = function(event)
      -- no hide images link in markdown
      vim.wo.conceallevel = 0
    end,
  })
end


return {
  bindkey = bindkey
}


--[[
--
--
  vim.keymap.set({"n","i"}, "<C-v>", "", {
    buffer = evt.buf,
    silent = true,
    callback= function()
      local cwd = vim.fn.getcwd()
      require("img-clip").paste_image({
        use_absolute_path =false,
        dir_path = "static/image/mdfiles/",
        file_name = "%Y-%m-%d-%H-%M-%S",
        -- template = "$FILE_PATH",
        show_dir_path_in_prompt = true, -- show dir_path in prompt when prompting for file name
      })
    end
  })

--
--]]
--]]

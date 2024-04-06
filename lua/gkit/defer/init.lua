
local transparent = false


local function setupBg()
  
  if not transparent then 
    return 
  end
--  hi Normal       ctermbg=none  guibg=none
  vim.cmd([[

 hi CursorLineNr               guibg=none
 hi EndOfBuffer                guibg=none
 hi Folded                     guibg=none
 hi LineNr       ctermbg=none  guibg=none
 hi SignColumn   ctermbg=none  guibg=none
hi Normal ctermbg=none guibg=none
hi NonText ctermbg=none guibg=none
  ]])
end


local function setupProjectConf()

  local cwd = vim.fn.getcwd()
  if cwd == vim.fn.stdpath('config') then 
    return
  end

  local projectconf = tostring(cwd) .. '/.nvim/init.lua'
  if   (vim.uv or vim.loop).fs_stat(projectconf) then 
    dofile(projectconf)
  end

end


local function setup(opts)
  setupBg()
  local ok,ret = pcall( setupProjectConf)
  if not ok then 
    vim.notify("ERROR "..tostring(ret))
  end
end




return {
  setup=setup
}

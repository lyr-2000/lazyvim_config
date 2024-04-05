
local transparent = false

local function setup(opts)
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




return {
  setup=setup
}

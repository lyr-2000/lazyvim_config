

local input_toggle = 1
local zh_code = 1
local ts_utils = require('nvim-treesitter.ts_utils')

local function En()
  -- print('en')
  local input_status = tonumber(io.popen(switch.check):read("*all"))
  if (input_status == zh_code) then
    input_toggle = 1
    os.execute(switch.en)
  end
end

local function Zh()
  -- print('zn')  -- 
  local input_status = tonumber(io.popen(switch.check):read("*all"))
  if (input_status ~= zh_code ) then
    os.execute(switch.zh)
    input_toggle = 0
  end
end

local md = {
  "language",
  "fenced_code_block_delimiter",
  "link_destination",
  "code_fence_content",
  "fenced_code_block",
  "latex_block",
}

local md_code = {
  "chunk",            --lua
  "translation_unit", --c/cpp
  "module",           --python
}

local function is_not_in_code_block() --markdown
  local node_cursor = ts_utils.get_node_at_cursor()
  for _, node_type in ipairs(md) do
    if node_cursor and node_cursor:type() == node_type then
      return false
    end
  end
  while node_cursor do
    for _, node_type in ipairs(md_code) do
      if node_cursor and node_cursor:type() == node_type then
        return false
      end
    end
    node_cursor = node_cursor:parent()
  end
  return true
end

local function filetype_checke()
  if vim.bo.filetype == 'markdown' then
    return is_not_in_code_block()
  else
    return true
  end
end


local function getOS()
  -- ask LuaJIT first
  -- if jit then
  --   return jit.os
  -- end
  local Osname = ''
  -- Unix, Linux variants
  local fh =(vim.fn.system("uname -o 2>/dev/null"))
  Osname=fh

  return Osname or "Windows"
end



local function setupCore(opt)
  zh_code = opt.zh_code
  switch = vim.tbl_deep_extend("force", {
    text = {
      "*.md",
      "*.txt"
    },
    code = {
      "*",
    },
    en = "fcitx-remote -o",
    zh = "fcitx-remote -c",
    check = "fcitx-remote",
  }, opt or {})

  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
      En()
    end
  })
  vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = switch.text,
    callback = function()
      if filetype_checke() then
        Zh()
      end
    end
  })
  vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = switch.code,
    callback = function()
      local current_pos = vim.fn.getcurpos()
      current_pos[3] = current_pos[3] - 1
      vim.fn.setpos('.', current_pos)
      local previous_node = ts_utils.get_node_at_cursor()

      if previous_node and (previous_node:type() == 'comment' or previous_node:type() == 'comment_content') then
        Zh()
      end
    end
  })

  vim.api.nvim_create_autocmd("TextChangedI", {
    pattern = switch.code,
    callback = function()
      if (vim.bo.filetype == 'python' or vim.bo.filetype == 'sh') and vim.fn.line('.') == 1 then
        return
      end
      local current_pos = vim.fn.getcurpos()
      current_pos[3] = current_pos[3] - 1
      vim.fn.setpos('.', current_pos)
      local previous_node = ts_utils.get_node_at_cursor()
      if previous_node and (previous_node:type() == 'comment' or previous_node:type() == 'comment_content') then
        Zh()
      end
      current_pos[3] = current_pos[3] + 1
      vim.fn.setpos('.', current_pos)
    end
  })
end

local function setup(opt)
  local ok,os = pcall(getOS)
  if not ok then
    vim.notify('error occur '..tostring(os).."||"..tostring(err))
  end
  if string.find(os,'Linux') ~= nil then 
    setupCore(opt)
  end
end


return {
  setup = setup
}

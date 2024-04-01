local M = {}

-- M.sudo_exec = function(cmd, print_output)
--   local password = vim.fn.inputsecret("Password: ")
--   local out = vim.fn.system(string.format("/usr/bin/sudo -p '' -S %s", cmd), password)
--   if vim.v.shell_error ~= 0 then
--     print("\r\n")
--     print(out)
--     return false
--   end
--   if print_output then
--     print("\r\n", out)
--   end
--   return true
-- end

-- mp4viewer.lua  
  
M.test = function()
  print("hello")
end

return M

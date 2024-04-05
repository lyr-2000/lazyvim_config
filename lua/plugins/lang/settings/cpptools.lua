local dap = require "dap"

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "OpenDebugAD7",
  options = {
    detached = false,
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file (cppdbg)",
    type = "cppdbg",
    request = "launch",
    program = function()
      local dir1 = vim.fn.expand("%:p:h")
      -- local dir1 = vim.expand("%p:h")
      -- dir2 = vim.fn.getcwd()
      local dir = dir1 .. "/main.out"
      return vim.fn.input("Path to exeBin: ", dir , "file")
    end,
    -- console = 'console',
    console = 'external',
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

-- If you want to use this for Rust and C, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

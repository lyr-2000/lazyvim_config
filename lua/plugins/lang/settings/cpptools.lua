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
      local dir = vim.fn.getcwd() .. "/a.out"
      return vim.fn.input("Path to exeBin: ", dir , "file")
    end,
    console = 'integratedTerminal',
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

-- If you want to use this for Rust and C, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
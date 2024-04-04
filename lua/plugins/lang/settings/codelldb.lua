local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000 -- 💀 Use the port printed out or specified with `--port`
}

dap.configurations.cpp = {
  {
    name = "Launch file (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      local dir = vim.fn.getcwd() .. "/a.out"
      return vim.fn.input('Path to executable: ', dir, 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
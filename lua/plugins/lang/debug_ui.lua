return { {
  "mfussenegger/nvim-dap",
  config = function()
    require "plugins.lang.settings.cpptools"
    require "plugins.lang.settings.go"
  end

}, {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  keys = { {
    "<leader>du",
    function()
      require("dapui").toggle({layout=2})
    end,
    desc = "Dap UI toggle console"
  }, {
    "<leader>de",
    function()
      require("dapui").eval()
    end,
    desc = "Eval (dapui-eval)",
    mode = { "n", "v" }
  } },
  opts = {
    layouts = { {
      elements = {       -- Elements can be strings or table with id and size keys.
        {
          id = "scopes",
          size = 0.25
        }, "breakpoints", "stacks", "watches" },
      size = 40,       -- 40 columns
      position = "left"
    }, {
      elements = { "repl", "console" },
      size = 0.25,       -- 25% of total lines
      position = "bottom"
    } }
  },
  config = function(_, opts)
    -- setup dap config by VsCode launch.json file
    -- require("dap.ext.vscode").load_launchjs()
    local dap = require("dap")
    -- vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

    local dapui = require("dapui")
    dapui.setup(opts)
    -- dap.listeners.after.event_initialized["dapui_config"] = function()
    -- 	dapui.open({})
    -- end
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --     dapui.close({})
    -- end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({
        layout = 1
      })
    end

    -- 设置调试相关的字符和颜色
    local dap_breakpoint_color = {
      breakpoint = {
        ctermbg = 0,
        fg = '#993939',
        bg = '#31353f',
      },
      logpoing = {
        ctermbg = 0,
        fg = '#61afef',
        bg = '#31353f',
      },
      stopped = {
        ctermbg = 0,
        fg = '#98c379',
        bg = '#31353f'
      },
    }

    vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
    vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
    vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)

    -- 输入unicode的方法：ctrl + v + u 再输入unicode码
    -- 可在https://www.nerdfonts.com/cheat-sheet查询想要的字符
    local dap_breakpoint = {
      error = {
        text = "",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      },
      condition = {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint',
      },
      rejected = {
        text = "",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      },
      logpoint = {
        text = '',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl = 'DapLogPoint',
      },
      stopped = {
        text = '',
        texthl = 'DapStopped',
        linehl = 'DapStopped',
        numhl = 'DapStopped',
      },
    }

    vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
    vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
    vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
    vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
    vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
    -- end dap
  end
}, -- virtual text for the debugger
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {}
  } -- mason.nvim integration
  ,
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      }
    }
  }
}

-- dependencies = { -- fancy UI for the debugger
-- config = function()
-- 	-- vim.fn.sign_define("DapBreakpoint", {
-- 	-- 	text = "🔴",
-- 	-- 	linehl = "DapBreakpoint",
-- 	-- })

-- 	-- vim.fn.sign_define("DapStopped", {
-- 	-- 	text = "▶️",
-- 	-- 	linehl = "DapBreakpointStopped",
-- 	-- })
-- 	-- vim.fn.sign_define("DapBreakpointCondition", {
-- 	-- 	text = " ",
-- 	-- })
-- 	-- vim.fn.sign_define("DapLogPoint", {
-- 	-- 	text = ".>",
-- 	-- })

-- 	-- vim.api.nvim_set_hl(0, "DapBreakpoint", { bg = "#552B24" })
-- 	-- vim.api.nvim_set_hl(0, "DapBreakpointStopped", { bg = "#244C55" })
-- end,

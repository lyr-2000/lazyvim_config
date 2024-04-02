--
return { -- disable catppuccin
  -- {
  --     "askfiy/SimpleNvim",
  -- },
  {
    "ellisonleao/gruvbox.nvim",
    -- enabled = false
  },
  {
    "LazyVim/LazyVim",
    -- enable = false,
    opts = {
      colorscheme = "gruvbox",
    },
  }, -- change trouble config
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
  },
  {
    "rcarriga/nvim-notify",
    enabled = true,
    -- keys = {{
    --     "<leader>un",
    --     function()
    --         require("notify").dismiss({
    --             silent = true,
    --             pending = true
    --         })
    --     end,
    --     desc = "Dismiss All Notifications"
    -- }},
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, {
          zindex = 100,
        })
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      if not LazyVim then
        return
      end
      if not LazyVim.has("noice.nvim") then
        LazyVim.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { {
      "<leader>cs",
      "<cmd>SymbolsOutline<cr>",
      desc = "Symbols Outline",
    } },
    config = true,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
X
            ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      opts.theme = "doom"
    end,
  },
}

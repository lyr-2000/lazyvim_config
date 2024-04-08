--

useTheme = "molokai"


return { -- disable catppuccin
  {
    "tomasiser/vim-code-dark", --"codedark"
    enabled = useTheme == "codedark",
    config = function()
      vim.cmd([[
set enc=utf-8
      ]])  
    end
  },
  { 
    "tomasr/molokai" ,
    enabled = useTheme == "molokai"
  },
  {
    "ellisonleao/gruvbox.nvim",
    -- enabled = false
    enabled = useTheme == "gruvbox",
  },
  {
    "LazyVim/LazyVim",
    -- enable = false,
    opts = {
      colorscheme = useTheme,
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
          zindex = 100, -- must use this config
        })
      end,
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    event ="VeryLazy",
    cmd = "SymbolsOutline",
    keys = { 
      {
        "<leader>cs",
        "<cmd>SymbolsOutline<cr>",
        desc = "Symbols Outline",
      },
      {
        "<leader>o",
        "<cmd>SymbolsOutline<cr>",
        desc = "Symbols Outline",
      } 
    },
    config = true,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
⣿⣿⣿⣿⣿⣿⡿⠿⠟⠻⠿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠈⠙⣿⣿⣿⣿⣿
⣿⣿⣿⣿⡇⣠⣾⠀⠀⢠⣦⡀⠀⠈⣿⣿⣿⣿
⣿⣿⣿⣿⣾⣿⣿⡀⠀⠈⠋⠀⠀⠀⢸⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⢸⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣆⠀⠀⠀⢸⣿⣿⣿
⣿⣿⣿⣿⡌⢿⣿⣀⣸⣿⡟⠀⠀⢀⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣄⠈⠛⠛⠋⠀⠀⢠⣾⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣷⣤⣀⣠⣤⣾⣿⣿⣿⣿⣿⣿
            ]]

      logo = string.rep("\n", 5) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      opts.theme = "doom"
    end,
  },
}

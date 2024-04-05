return {

  {
    "LintaoAmons/easy-commands.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("easy-commands").setup({
        myCommands = {
          {
            name = "Demo",
            callback = "echo 'abc'",
            description = "hello",
          },
          {
            name = "AddSnippet",
            callback = function()
              require("scissors").addNewSnippet()
            end,
            dependencies = { "https://github.com/chrisgrieser/nvim-scissors" },
          },
          {
            name = "EditSnippet",
            callback = function()
              require("scissors").editSnippet()
            end,
            dependencies = { "https://github.com/chrisgrieser/nvim-scissors" },
          },

        },
      })
    end,
  },
  -- customize file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every
          hide_gitignored = false,
        },
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true,                -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree

       filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            "node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            "*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignore",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
      },
    },
  },

  -- customize telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_cutoff = 0.2,
            preview_height = 0.4,
          },
          height = 0.9,
          width = 0.9,
        },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
          n = {
            ["j"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["k"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["gg"] = function(...)
              return require("telescope.actions").move_to_top(...)
            end,
            ["G"] = function(...)
              return require("telescope.actions").move_to_bottom(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
        },
      },
    },
  },
}

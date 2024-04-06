return {
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    -- GenTocGitLab, GenTocMarded
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    branch = 'fix/insert-base64-markup',
    opts = {
      default = {
        dir_path = "static",          -- directory path to save images to, can be relative (cwd or current file) or absolute
        file_name = "%Y-%m-%d-%H-%M-%S", -- file name format (see lua.org/pil/22.1.html)
        url_encode_path = false,      -- encode spaces and special characters in file path
        use_absolute_path = false,    -- expands dir_path to an absolute path
        relative_to_current_file = false, -- make dir_path relative to current file rather than the cwd
        relative_template_path = true, -- make file path in the template relative to current file rather than the cwd
        prompt_for_file_name = false, -- ask user for file name before saving, leave empty to use default
        show_dir_path_in_prompt = true, -- show dir_path in prompt when prompting for file name
        use_cursor_in_template = true, -- jump to cursor position in template after pasting
        insert_mode_after_paste = false, -- enter insert mode after pasting the markup code
        embed_image_as_base64 = false, -- paste image as base64 string instead of saving to file
        process_cmd = "convert -quality 25 - -",
        max_base64_size = 1000,       -- max size of base64 string in KB
        template = "$FILE_PATH",      -- default template

        drag_and_drop = {
          enabled = true,    -- enable drag and drop mode
          insert_mode = false, -- enable drag and drop in insert mode
          copy_images = false, -- copy images instead of using the original file
          download_images = true, -- download images and save them to dir_path instead of using the URL
        },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        -- markdown = { "markdownlint" },
        markdown = {},
      },
    },

    {
      "vhyrro/luarocks.nvim",
      enabled =false,
      priority = 1001, -- this plugin needs to run before anything else
      opts = {
        rocks = { "magick" },
      },
    },
    {
      "3rd/image.nvim",
      enabled = false,
      -- dependencies = { "luarocks.nvim" },
      config = function()
        -- default config
        require("image").setup({
          backend = "kitty",
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { "norg" },
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = nil,
          max_height_window_percentage = 50,
          window_overlap_clear_enabled = false,                             -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
          editor_only_render_when_focused = false,                          -- auto show/hide images when the editor gains/looses focus
          tmux_show_only_in_active_window = false,                          -- auto show/hide images in the correct Tmux window (needs visual-activity off)
          hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
        })                                                                  -- ...
      end
    }
  }
  -- {
  --   "mfussenegger/nvim-lint",
  --   -- enabled = true,
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {markdown = { "markdownlint" }},
  --   },
  --   config = function()
  --     -- local markdownlint = require("lint").linters.markdownlint
  --     -- markdownlint.args = {
  --     --   "--disable",
  --     --   "MD013", "MD007",
  --     --    -- "MD012",
  --     --   "--",    -- Required
  --     -- }
  --   end
  -- }

}

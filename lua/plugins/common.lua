-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return { -- add gruvbox
-- {"ellisonleao/gruvbox.nvim"}, 
-- {"leafOfTree/vim-preview"}, -- Configure LazyVim to load gruvbox
-- {
--     "LazyVim/LazyVim",
--     opts = {
--         colorscheme = "gruvbox"
--     }
-- }, -- change trouble config
{"lambdalisue/suda.vim"}, {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {{
        "<leader>cs",
        "<cmd>SymbolsOutline<cr>",
        desc = "Symbols Outline"
    }},
    config = true
}, {
    "nvim-telescope/telescope.nvim",
    keys = { -- add a keymap to browse plugin files
    -- stylua: ignore
    {
        "<leader>fp",
        function()
            require("telescope.builtin").find_files({
                cwd = require("lazy.core.config").options.root
            })
        end,
        desc = "Find Plugin File"
    }},
    -- change some options
    opts = {
        defaults = {
            layout_strategy = "horizontal",
            layout_config = {
                prompt_position = "top"
            },
            sorting_strategy = "ascending",
            winblend = 0
        }
    }
}, -- add telescope-fzf-native
{
    "telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
            -- todo: fzf extensions 
        end
    }
}, -- add pyright to lspconfig
{
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
        ---@type lspconfig.options
        servers = {
            -- pyright will be automatically installed with mason and loaded with lspconfig
            pyright = {}
        }
    }
}}

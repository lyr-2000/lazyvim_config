return { -- extend auto completion
-- {
--     "hrsh7th/nvim-cmp",
--     opts = function(_, opts)
--         local cmp = require("cmp")
--         opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
--             ["<C-j>"] = cmp.mapping.select_next_item({
--                 behavior = cmp.SelectBehavior.Insert
--             }),
--             ["<C-k>"] = cmp.mapping.select_prev_item({
--                 behavior = cmp.SelectBehavior.Insert
--             })
--         })
--     end
-- }, -- treesitter
{
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed,
                {"comment", "diff", "dockerfile", "dot", "git_rebase", "gitattributes", "gitcommit", "gitignore",
                 "graphql", "hcl", "http", "jq", "make", "mermaid", "sql"})
        end
    end,
    config = function() 
        require('nvim-treesitter.configs').setup({
          incremental_selection = {
            enable = true,
            keymaps = {
              node_incremental = "v",
              node_decremental= "V",
            }
          }
        })
        -- vav or vaV  to select range
    end
}, -- the opts function can also be used to change the default opts:
{
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
        table.insert(opts.sections.lualine_x, "😄")
    end
}, -- or you can return new options to override all the defaults
-- {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function()
--         return { --[[add your custom lualine config here]] }
--     end
-- },
{
    "tpope/vim-commentary"
}


}

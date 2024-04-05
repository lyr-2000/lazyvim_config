return {{
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        ["<leader>"] = {
            b = {
                f = {"<cmd>GoDoc<cr>", "Go doc"}
            }
        }
    }
    -- config = function()
    --   local wk = require("which-key")
    --   wk.register({
    --     ["q"] = {
    --       name = "golang",
    --       h = {
    --         "<cmd>GoDoc<cr>",
    --         "Go Doc",
    --       },
    --     },
    --   })
    -- end,
}, -- LSP keymaps
{
    "neovim/nvim-lspconfig",
    init = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        -- change a keymap
        -- keys[#keys + 1] = {"gr", "<cmd>echo 'hello'<cr>"}
        keys[#keys + 1] = {"gr", false} -- disable gr command
        -- -- disable a keymap
        -- keys[] = {"K", false}
        -- -- add a keymap
        -- keys[#keys + 1] = {"H", "<cmd>echo 'hello'<cr>"}
    end
}}


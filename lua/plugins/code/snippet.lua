local enableCompletePlugin = true

return {
  {
    "hrsh7th/nvim-cmp",
    enabled = enableCompletePlugin,
    dependencies = {
      "hrsh7th/cmp-emoji",
      {
        "tzachar/cmp-tabnine",
        build = {
          -- LazyVim.is_win() and "pwsh -noni .\\install.ps1" or "./install.sh",
          -- ":CmpTabnineHub",
        },
        dependencies = "hrsh7th/nvim-cmp",
        opts = {
          max_lines = 1000,
          max_num_results = 3,
          sort = true,
        },
        config = function(_, opts)
          require("cmp_tabnine.config"):setup(opts)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      -- local luasnip = require 'luasnip'
      -- issue on trigger mannual :   https://github.com/hrsh7th/nvim-cmp/issues/528
      -- help: https://github.com/hrsh7th/nvim-cmp/issues/531
      local mode1 = {
        completeopt = "menu,menuone,noinsert",
        keyword_length = 3, -- then min length to trigger complete menu
        keyword_pattern = ".*",
      }
      local enableAutoComplete = true
      local disablePlugin = false
      if not enableAutoComplete then
        -- default is it
        mode1.autocomplete = {
          -- cmp.TriggerEvent.TextChanged,
          -- cmp.TriggerEvent.InsertEnter,
        }
      end
      if disablePlugin then
        mode1.autocomplete = false
      end

      local rw = {
        -- snippet = {
        --   expand = function(args)
        --     -- luasnip.lsp_expand(args.body)
        --     vim.snippet.expand(args.body)
        --   end,
        -- },
        completion = mode1,
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-h>"] = cmp.mapping.complete(),
          ["<C-i>"] = cmp.mapping.complete(),
          ["<A-/>"] = cmp.mapping.complete(),
          ["<A-_>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,

          ["<Tab>"] = function(fallback)
            if true or cmp.visible() then
              cmp.mapping.confirm({

                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              })(fallback)
            end
          end,
        }),
        -- sources = cmp.config.sources({
        --   { name = "nvim_lsp" },
        --   { name = "path" },
        -- }, {
        --   {
        --     name = "buffer",
        --     option = {
        --       get_bufnrs = function()
        --         local bufs = {}
        --         for _, win in ipairs(vim.api.nvim_list_wins()) do
        --           local buf = vim.api.nvim_win_get_buf(win)
        --           -- vim.bo[event.buf].buftype = 'nofile'
        --           if vim.bo[buf].buftype ~= 'nofile' then
        --             bufs[buf] = true
        --           end
        --           return vim.tbl_keys(bufs)
        --         end
        --         return vim.tbl_keys(bufs)
        --       end
        --     }
        --
        --   },
        -- }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        sorting = defaults.sorting,
      }
      -- rewrite default mapping config
      opts.mapping = rw.mapping

      return opts
    end,
  },


  {
    "hrsh7th/cmp-cmdline",
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = { "hrsh7th/nvim-cmp" },
    enabled = enableCompletePlugin,
    -- opts = function()
    --   local cmp = require("cmp")
    --   return {
    --     {
    --       type = "/",
    --       mapping = cmp.mapping.preset.cmdline(),
    --       sources = {
    --         { name = "buffer" },
    --       },
    --     },
    --     {
    --       type = ":",
    --       mapping = cmp.mapping.preset.cmdline({
    --
    --         ["<Down>"] = {
    --           c = function(fallback)
    --             if cmp.visible() then
    --               cmp.select_next_item()
    --             else
    --               fallback()
    --             end
    --           end,
    --         },
    --         ["<Up>"] = {
    --           c = function(fallback)
    --             if cmp.visible() then
    --               cmp.select_prev_item()
    --             else
    --               fallback()
    --             end
    --           end,
    --         },
    --         ["<Tab>"] = {
    --           c = function()
    --             -- auto select the first items
    --             cmp.select_next_item()
    --             cmp.select_prev_item()
    --           end,
    --         },
    --         ['<CR>'] = {
    --           c = cmp.mapping.confirm({
    --             select = true,
    --           }),
    --         },
    --       }),
    --       sources = cmp.config.sources({
    --         { name = "path" },
    --       }, {
    --         {
    --           name = "cmdline",
    --           option = {
    --             ignore_cmds = { "Man", "!" },
    --           },
    --         },
    --       }),
    --     },
    --   }
    -- end,
    -- config = function(_, opts)
    --   local cmp = require("cmp")
    --   vim.tbl_map(function(val)
    --     cmp.setup.cmdline(val.type, val)
    --   end, opts)
    -- end,
  },

}

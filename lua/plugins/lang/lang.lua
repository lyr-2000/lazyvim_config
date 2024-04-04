return {
  -- uncomment and add lsp servers with their config to servers below
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = vim.fn.has("nvim-0.10"),
      },
      ---@type lspconfig.options
    },
  },

  -- uncomment and add tools to ensure_installed below
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua-language-server", "marksman" })
      opts.ui = {
        icons = {
          package_installed = "✓",
          package_pending = "",
          package_uninstalled = "✗",
        },
      }
    end,
  },
  

  -- java setup
  -- stylua: ignore
}

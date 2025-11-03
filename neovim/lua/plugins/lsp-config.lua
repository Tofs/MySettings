return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "jedi_language_server",
        "biome",
        "clangd",
        "lua_ls"
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.jedi_language_server.setup({
        capabilities = capabilities
        -- Auto compltion Solved by setting "true" to "include-system-site-packages" string in ~/.local/share/nvim/mason/packages/python-lsp-server/venv/pyvenv.cfg file.
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities
      })
      lspconfig.clangd.setup({
        capabilities = capabilities
      })


      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "td", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "tD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "tr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
    end,
  },
}

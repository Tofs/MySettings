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

        vim.lsp.enable('lua_ls')
        vim.lsp.enable('jedi_language_server')
        vim.lsp.enable('jsonls')
        vim.lsp.enable('cland')


        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "td", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "tD", vim.lsp.buf.declaration, {})
        vim.keymap.set("n", "tr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
    end,
  },
}

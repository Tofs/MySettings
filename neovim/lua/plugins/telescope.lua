return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" , "BurntSushi/ripgrep", "nvim-telescope/telescope-live-grep-args.nvim"},
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
	  require("telescope").load_extension("live_grep_args")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", require('telescope').extensions.live_grep_args.live_grep_args, {})

      require("telescope").load_extension("ui-select")
    end,
  },
}

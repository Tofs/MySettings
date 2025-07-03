return {
  {
        "github/copilot.vim",
        event = "InsertEnter",
        config = function()
            vim.g.copilot_filetypes = {
                ["*"] = true,
                ["markdown"] = false,
                ["text"] = false,
            }
            vim.g.copilot_no_tab_map = false
            vim.g.copilot_assume_mapped = true
            --vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

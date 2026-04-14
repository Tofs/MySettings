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
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        cmd = "CopilotChat",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        model = "claude-haiku-4.5",
        keys = {
            { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
            { "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
            {
                "<leader>aa",
                function()
                    return require("CopilotChat").toggle()
                end,
                desc = "Toggle (CopilotChat)",
                mode = { "n", "x" },
            },
            {
                "<leader>ax",
                function()
                    return require("CopilotChat").reset()
                end,
                desc = "Clear (CopilotChat)",
                mode = { "n", "x" },
            },
            {
                "<leader>aq",
                function()
                    vim.ui.input({
                        prompt = "Quicke Chat: ",
                    }, function(input)
                            if input ~= "" then
                                require("CopilotChat").ask(input)
                            end
                        end)
                end,
                desc = "Quick Chat (CopilotChat)",
                mode = { "n", "x" },
            },
            {
                "<leader>ap",
                function()
                    require("CopilotChat").select_prompt()
                end,
                desc = "Prompt Actions (CopilotChat)",
                mode = { "n", "x" },
            },
        },
        opts = function()
            local user = vim.env.USER or "User"
            user = user:sub(1, 1):upper() .. user:sub(2)
            return {
                auto_insert_mode = true,
                headers = {
                    user = "  " .. user .. " ",
                    assistant = "  Copilot ",
                    tool = "󰊳  Tool ",
                },
                window = {
                    width = 0.2,
                },
            }
        end,
        config = function(_, opts)
            vim.keymap.del("n", "C-l")
        end,
        -- See Commands section for default commands if you want to lazy load on them
    },
}

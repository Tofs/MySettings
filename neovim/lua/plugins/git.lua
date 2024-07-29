return {
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            vim.keymap.set("n", "gl", ":LazyGit\n", {})
        end
    },
    {
        "FabijanZulj/blame.nvim",
        config = function()
            require("blame").setup()
            vim.keymap.set("n", "gb", ":BlameToggle\n", {})
        end
    }
}

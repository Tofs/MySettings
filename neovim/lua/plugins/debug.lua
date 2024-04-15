return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("dapui").setup()
      require('dap-python').setup('./.debugpy/scripts/python')

      local dap, dapui = require("dap"), require("dapui")

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set("n", "<F9>", ":DapToggleBreakpoint<CR>")
      vim.keymap.set("n", "<F5>", ":DapContinue<CR>")
      vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>")
      vim.keymap.set("n", "<F10>", ":DapStepOver<CR>")
    end,
  }
}

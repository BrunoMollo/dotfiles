return {
  setup_commands = function()
    vim.api.nvim_create_user_command('Ccf', function()
      vim.fn.setreg('+', vim.fn.expand '%:p')
    end, {})
  end,
}

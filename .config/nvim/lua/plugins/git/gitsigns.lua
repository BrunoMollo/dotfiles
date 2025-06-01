return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
  config = function()
    require('gitsigns').setup()
    vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { desc = 'Preview hunk' })

    vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })

    vim.keymap.set('n', '<leader>ga', ':Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })
    vim.keymap.set('n', '<leader>gu', ':Gitsigns stage_hunk<CR>', { desc = 'Undo stage hunk' })

    vim.keymap.set('n', 'gn', ':Gitsigns next_hunk<CR>', { desc = 'Go to next hunk' })
    vim.keymap.set('n', 'gp', ':Gitsigns prev_hunk<CR>', { desc = 'Go to previous hunk' })
  end,
}

return {
  'nvim-tree/nvim-tree.lua',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus' }, -- Add commands to load the plugin
  keys = {
    { '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', desc = 'Toggle NvimTree' },
  },
  opts = {
    view = {
      float = {
        enable = true,
        quit_on_focus_loss = true,
        open_win_config = {
          width = 80,
          height = 25,
        },
      },
      width = 80,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    filters = {
      dotfiles = true,
      git_ignored = true,
    },
    renderer = {
      indent_width = 4,
      indent_markers = {
        enable = true,
      },
    },
  },
}

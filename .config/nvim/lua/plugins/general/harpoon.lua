return {
  'ThePrimeagen/harpoon',
  config = function()
    local function goto_harpoon(index)
      return '<cmd>lua require("harpoon.mark").set_current_at(' .. index .. ')<CR><cmd>lua print("File added to list ⇁ ' .. index .. '")<CR>'
    end

    vim.keymap.set('n', '<leader>hh', goto_harpoon(1))
    vim.keymap.set('n', '<leader>hj', goto_harpoon(2))
    vim.keymap.set('n', '<leader>hk', goto_harpoon(3))
    vim.keymap.set('n', '<leader>hl', goto_harpoon(4))

    vim.keymap.set('n', '<leader><leader>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
    vim.keymap.set('n', '1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
    vim.keymap.set('n', '2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
    vim.keymap.set('n', '3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
    vim.keymap.set('n', '4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
  end,
}

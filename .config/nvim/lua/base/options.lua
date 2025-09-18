return {
  setup_options = function()
    -- Must happen before plugins are loaded (otherwise wrong leader will be used)
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    vim.g.have_nerd_font = true

    vim.o.number = true

    -- Enable mouse mode, can be useful for resizing splits for example!
    vim.o.mouse = 'a'

    -- Don't show the mode, since it's already in the status line
    vim.o.showmode = false

    -- Sync clipboard between OS and Neovim.
    --  Schedule the setting after `UiEnter` because it can increase startup-time.
    --  Remove this option if you want your OS clipboard to remain independent.
    --  See `:help 'clipboard'`
    vim.schedule(function()
      vim.o.clipboard = 'unnamedplus'
    end)

    vim.o.breakindent = true
    vim.o.undofile = true
    vim.o.ignorecase = true
    vim.o.smartcase = true
    vim.o.signcolumn = 'yes'
    vim.o.updatetime = 250
    vim.o.timeoutlen = 300
    vim.o.splitright = true
    vim.o.splitbelow = true

    vim.o.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    vim.o.inccommand = 'split'
    vim.o.cursorline = true

    vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

    -- confirm on quit unsaved changes
    vim.o.confirm = false

    vim.opt.swapfile = false

    -- Always use spaces instead of tabs
    vim.opt.expandtab = true
    vim.opt.tabstop = 4 -- Display width of a tab
    vim.opt.shiftwidth = 4 -- Indent size
    vim.opt.softtabstop = 4 -- Makes <Tab>/<BS> feel like 4 spaces
  end,
}

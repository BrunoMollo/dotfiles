-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

-- Disabled because it caused an error and I don't know if i need it
--



lvim.builtin.which_key.mappings["ss"] = {
  name = "Search Laravel", -- Grupo "Search"
  k = { function()
    require("telescope.builtin").find_files({
      cwd = "config",
      prompt_title = "Configuration Files"
    })
  end, "config" },

  c = {
    function()
      require("telescope.builtin").find_files({
        cwd = "./app/Http/Controllers",
        prompt_title = "Controllers"
      })
    end
    , "Controllers" },

  m = {
    function()
      require("telescope.builtin").find_files({
        cwd = "./app/Http/Middleware",
        prompt_title = "Middleware"
      })
    end
    , "Middleware" },

  e = {
    function()
      require("telescope.builtin").find_files({
        cwd = "./app/Models",
        prompt_title = "Models"
      })
    end
    , "Models" },


  v = {
    function()
      require("telescope.builtin").find_files({
        cwd = "./resources/views",
        prompt_title = "Views"
      })
    end
    , "Views" },


  r = {
    function()
      require("telescope.builtin").find_files({
        cwd = "./routes",
        prompt_title = "routes"
      })
    end
    , "routes" },


  d = {
    f = {
      function()
        require("telescope.builtin").find_files({
          cwd = "./database/factories",
          prompt_title = "factories"
        })
      end, 'factories'
    },
    s = {
      function()
        require("telescope.builtin").find_files({
          cwd = "./database/seeders",
          prompt_title = "seeders"
        })
      end, 'seeders'
    },
    m = {
      function()
        require("telescope.builtin").find_files({
          cwd = "./database/migrations",
          prompt_title = "migrations"
        })
      end, 'migrations'
    }
    ,
    "database"
  },
  "Laravel Search"

}


lvim.builtin.bufferline.active = false

lvim.builtin.project.patterns = { ".git" }

lvim.builtin.nvimtree.setup.view.float.quit_on_focus_loss = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.float.enable = true

lvim.builtin.nvimtree.setup.view.width = 80
lvim.builtin.nvimtree.setup.view.float.open_win_config.width = 80
lvim.builtin.nvimtree.setup.view.float.open_win_config.height = 25

lvim.builtin.nvimtree.setup.filters.git_ignored = true
lvim.builtin.nvimtree.setup.filters.dotfiles = true

lvim.builtin.nvimtree.setup.renderer.indent_width = 4
lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true



lvim.plugins = {
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      nvim_tmux_nav.setup {
        disable_when_zoomed = true -- defaults to false
      }

      vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end

  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-pack/nvim-spectre' },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-l>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        log_level = "info",                -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in key maps for more manual control
        condition = function()
          return false
        end -- condition to check for stopping SuperMaven, `true` means to stop SuperMaven when the condition is true.
      })
    end,

  },
  {
    'ThePrimeagen/harpoon',
    config = function()
      local function goto_harpoon(index)
        return '<cmd>lua require("harpoon.mark").set_current_at(' ..
            index .. ')<CR><cmd>lua print("File added to list ⇁ ' .. index .. '")<CR>'
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
    end
  },
  {
    'tpope/vim-surround'
  }

}

lvim.keys.normal_mode["<leader>q"] = false

lvim.builtin.which_key.mappings[";"] = {}
lvim.builtin.which_key.mappings["/"] = {}
lvim.builtin.which_key.mappings["h"] = {}
lvim.builtin.which_key.mappings["T"] = {}



lvim.builtin.which_key.mappings["q"] = {
  name = "Fixlist",
  c = { "<cmd>copen<CR>", "Open" },
  n = { "<cmd>cnext<CR>", "Next" },
  p = { "<cmd>cprev<CR>", "Prev" },
}




-- Formatters
lvim.format_on_save.enabled = true
require("lvim.lsp.null-ls.formatters").setup {
  {
    name = "prettierd",
    ---@usage only start in these file types, by default it will attach to all file types it supports
    filetypes = { "typescript", "typescriptreact", "javascript", "svelte" },
  },
  {
    name = "pint",
    filetypes = { "php" }
  }
}



vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  command = ":silent! !rm '\\'"
})


-- Spell checking (to download the es spelllang I had to run :setlocal spelllang=es,en)
lvim.builtin.nvimtree.setup.disable_netrw = false
vim.opt.spelllang = 'en_us,es'
vim.opt.spell = true
vim.api.nvim_set_keymap('n', 'zg', '', {
  noremap = true,
  silent = true,
  callback = function()
    local word = vim.fn.expand('<cword>') -- Get the current word
    local confirm = vim.fn.input("Add '" .. word .. "' to spell check? (y/n): ")
    if confirm:lower() == 'y' then
      vim.cmd('normal! zg')
      print("'" .. word .. "' added to spell checker.")
    else
      print("Cancelled adding '" .. word .. "' to spell checker.")
    end
  end
})


--- This is really important to work with python
lvim.keys.visual_mode["<Tab>"] = ">gv"
lvim.keys.visual_mode["<S-Tab>"] = "<gv"

lvim.builtin.treesitter.ensure_installed = {
  'javascript',
  'php',
  'html',
  'css',
  'json',
  'typescript',
  'lua',
  'markdown',
  'yaml',
  'toml',
  'bash',
  'dockerfile',
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php", "blade" },
  callback = function()
    vim.lsp.start({
      name = "laravel-ls",
      cmd = { '/home/bruno/go/bin/laravel-ls' },
      -- if you want to recompile everytime
      -- the language server is started.
      -- Uncomment this line instead
      -- cmd = { '/path/to/laravel-ls/start.sh' },
      root_dir = vim.fn.getcwd(),
    })
  end
})

lvim.builtin.treesitter.on_config_done = function()
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.blade = {
    install_info = {
      url = "https://github.com/EmranMR/tree-sitter-blade",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "blade",
  }
end

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git",
  "public/tenant/themes/**/*",    -- this is due to Betfunnels
  "public/tenant/templates/**/*", -- this is due to Betfunnels
  "vendor/*"

}

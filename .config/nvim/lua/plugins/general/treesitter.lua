return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'php',
      'javascript',
      'typescript',
      'svelte',
      'css',
      'html',
      'json',
      'markdown',
      'yaml',
      'bash',
      'c',
      'diff',
      'lua',
      'luadoc',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    },
  },
  config = function(_, opts)
    local treesitter = require 'nvim-treesitter'
    local parsers = opts.ensure_installed

    treesitter.setup()

    local installed = treesitter.get_installed()
    local missing = vim.tbl_filter(function(parser)
      return not vim.list_contains(installed, parser)
    end, parsers)

    if #missing > 0 then
      treesitter.install(missing)
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(event)
        local language = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)

        if language and vim.list_contains(parsers, language) then
          local parser_started = pcall(vim.treesitter.start, event.buf, language)

          if parser_started then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end
      end,
    })
  end,
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      -- Auto install parsers when entering buffer
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft

          local available_parsers = require('nvim-treesitter').get_available()
          if not vim.tbl_contains(available_parsers, lang) then
            return
          end

          if not pcall(vim.treesitter.language.inspect, lang) then
            require('nvim-treesitter').install({ lang })
          end

          -- Enable Tree-sitter highlight
          pcall(vim.treesitter.start, args.buf)

          -- Enable Tree-sitter indent (only if language supports it)
          local has_indent = #vim.api.nvim_get_runtime_file('queries/' .. lang .. '/indents.scm', true) > 0
          if has_indent then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local select = require('nvim-treesitter-textobjects.select')

      vim.keymap.set({ 'x', 'o' }, 'af', function()
        select.select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Select outer function' })

      vim.keymap.set({ 'x', 'o' }, 'if', function()
        select.select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Select inner function' })

      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        select.select_textobject('@class.outer', 'textobjects')
      end, { desc = 'Select outer class' })

      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        select.select_textobject('@class.inner', 'textobjects')
      end, { desc = 'Select inner class' })

      vim.keymap.set({ 'x', 'o' }, 'as', function()
        select.select_textobject('@scope', 'locals')
      end, { desc = 'Select language scope' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 3,
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
}

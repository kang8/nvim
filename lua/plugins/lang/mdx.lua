return {
  {
    -- Registers the `mdx` filetype, maps it to the markdown parser, and ships
    -- injection queries for import/export/JSX. Highlight start is handled both
    -- by this plugin and by our treesitter FileType autocmd (start is idempotent).
    'davidmh/mdx.nvim',
    -- Only defines a filetype + autocmd, so it's safe (and required) at startup.
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      -- Ensure parsers referenced by the MDX injection queries are installed.
      -- Our TS autocmd only auto-installs the primary lang (markdown).
      require('nvim-treesitter').install({
        'markdown',
        'markdown_inline',
        'typescript',
        'tsx',
        'sql',
      })
    end,
  },
}

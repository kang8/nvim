return {
  {
    'saghen/blink.cmp',
    -- Stay on v1: `main` is V2 with breaking changes; release tags also ship the prebuilt fuzzy binary.
    version = '1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = { 'L3MON4D3/LuaSnip' },
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      },
      completion = {
        -- Nothing selected by default; <CR> only accepts an item picked with <C-n>/<C-p>.
        list = { selection = { preselect = false, auto_insert = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true, show_without_selection = true },
      },
      signature = { enabled = true },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
    config = function(_, opts)
      -- Dim ghost text so it reads differently from real code
      vim.api.nvim_set_hl(0, 'BlinkCmpGhostText', { link = 'Whitespace', default = true })
      require('blink.cmp').setup(opts)
    end,
  },
}

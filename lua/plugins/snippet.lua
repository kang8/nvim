return {
  {
    'L3MON4D3/LuaSnip',
    -- Loaded by blink.cmp, which also owns <Tab>/<S-Tab> for jumping between placeholders.
    lazy = true,
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
  },
}

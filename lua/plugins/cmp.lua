return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
          format = function(_, item)
            local icons = {
              Array = ' ',
              Boolean = ' ',
              Class = ' ',
              Color = ' ',
              Constant = ' ',
              Constructor = ' ',
              Enum = ' ',
              EnumMember = ' ',
              Event = ' ',
              Field = ' ',
              File = ' ',
              Folder = ' ',
              Function = ' ',
              Interface = ' ',
              Key = ' ',
              Keyword = ' ',
              Method = ' ',
              Module = ' ',
              Namespace = ' ',
              Null = 'ﳠ ',
              Number = ' ',
              Object = ' ',
              Operator = ' ',
              Package = ' ',
              Property = ' ',
              Reference = ' ',
              Snippet = ' ',
              String = ' ',
              Struct = ' ',
              Text = ' ',
              TypeParameter = ' ',
              Unit = ' ',
              Value = ' ',
              Variable = ' ',
            }

            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = 'LspCodeLens',
          },
        },
      }
    end,
  },
}

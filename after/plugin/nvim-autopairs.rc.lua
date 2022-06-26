local status, autopairs = pcall(require, 'nvim-autopairs')

if not status then
  vim.notify('Not found windwp/nvim-autopairs')
  return
end

autopairs.setup({})

-- add custom rule

local Rule = require('nvim-autopairs.rule')

autopairs.add_rules({
  Rule(' ', ' '):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ '()', '[]', '{}' }, pair)
  end),
  Rule('( ', ' )')
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match('.%)') ~= nil
    end)
    :use_key(')'),
  Rule('{ ', ' }')
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match('.%}') ~= nil
    end)
    :use_key('}'),
  Rule('[ ', ' ]')
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match('.%]') ~= nil
    end)
    :use_key(']'),
})

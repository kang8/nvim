local ls = require('luasnip')
local s = ls.s
local i = ls.i
local t = ls.t
local rep = require('luasnip.extras').rep

return {
  s('plugin-setup', {
    t('local contained, '),
    rep(1),
    t(" = pcall(require, '"),
    i(1, 'plugin_name'),
    t({ "')", '' }),

    t({ '', '' }),

    t({ 'if not contained then', '' }),
    t("  vim.notify('Not found "),
    rep(1),
    t({ "', vim.log.levels.WARN)", '' }),
    t({ '  return', '' }),
    t({ 'end', '' }),

    t({ '', '' }),

    rep(1),
    t('.setup({})'),
  }),
}

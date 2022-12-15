local ls = require('luasnip')
local s = ls.s
local i = ls.i
local t = ls.t

return {
  s('/**', {
    t({ '/**' }),
    t({ '', ' * ' }),
    i(1),
    t({ '', ' */' }),
  }),
  s('main', {
    t({ '#include <stdio.h>' }),
    t({ '', '' }),
    t({ '', 'int main(void) {' }),
    t({ '', '  ' }),
    i(1),
    t({ '', '' }),
    t({ '', '  return 0;' }),
    t({ '', '}' }),
  }),
}

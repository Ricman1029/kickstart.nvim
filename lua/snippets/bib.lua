local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(1)
  end
end)

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(-1)
  end
end)

return {
  s(
    { trig = 'book', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      @book{{{},
        author = {{{}}},
        title = {{{}}},
        year = {{{}}},
        edition = {{{}}},
        publisher = {{{}}}
      }}
      ]],
      { i(1, 'label'), i(2), i(3), i(4), i(5), i(6) }
    )
  ),
}

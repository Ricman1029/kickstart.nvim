-- Estos son los snippets que se van a cargar para todos los documentos de latex
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
  -- NOTE: CELLS
  s(
    { trig = ';python', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      ```{{python}}
      #| label: {}
      #| fig-cap: {}

      {}
      ```
      ]],
      { i(1), i(2), i(3) }
    )
  ),

  s(
    { trig = ';ejemplo', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      ::: {{.callout-tip title=Ejemplo}}
      ::: {{#exm-{}}}

      {}
      :::
      :::
      ]],
      { i(1), i(2) }
    )
  ),

  s(
    { trig = ';definicion', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      ::: {{.callout-note title=Definición}}
      {}
      :::
      ]],
      { i(1) }
    )
  ),

  s(
    { trig = ';teorema', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      ::: {{.callout-warning title=Teorema icon=false}}
      {}
      :::
      ]],
      { i(1) }
    )
  ),

  -- NOTE: ENVIRONMENTS
  s(
    { trig = ';mat', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \begin{{bmatrix}}
        {}
      \end{{bmatrix}}
      ]],
      {
        i(1),
      }
    )
  ),

  s(
    { trig = ';sel', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \left\{{
      \begin{{aligned}}
        {}
      \end{{aligned}}
      \right.
      ]],
      {
        i(1),
      }
    )
  ),

  -- NOTE: MATEMATICA

  s(
    { trig = ';intg', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \int_{{{}}}^{{{}}} {} \,d
    ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),

  s(
    { trig = ';iintg', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \iint_{{{}}} {} \,d
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s(
    { trig = ';iiintg', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \iiint_{{{}}} {} \,d
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s(
    { trig = ';dintg', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \int_{{{}}}^{{{}}} \int_{{{}}}^{{{}}} {} \,d{} d
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
      }
    )
  ),

  s(
    { trig = ';tintg', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \int_{{{}}}^{{{}}} \int_{{{}}}^{{{}}} \int_{{{}}}^{{{}}} {} \,d{} d{} d
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(8),
        i(9),
      }
    )
  ),

  s(
    { trig = ';ointg', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \oint_{{{}}}^{{{}}} {} \,d
    ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),

  s(
    { trig = ';eval', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\Bigg[{}\\Bigg]_{{{}}}^{{{}}}', {
      i(1),
      i(2),
      i(3),
    })
  ),

  s(
    { trig = ';dv', snippetType = 'autosnippet', wordTrig = false },
    fmt([[\dv[{}]{{{}}}{{{}}}]], {
      i(1),
      i(2),
      i(3),
    })
  ),

  s(
    { trig = ';dp', snippetType = 'autosnippet', wordTrig = false },
    fmt([[\frac{{\partial{}}}{{\partial {}}}]], {
      i(1),
      i(2),
    })
  ),

  s(
    { trig = ';sum', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\sum_{{{}}}^{{{}}} {}', {
      i(1),
      i(2),
      i(0),
    })
  ),

  s({ trig = ';sin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\sin^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ';cos', snippetType = 'autosnippet', wordTrig = false }, fmt('\\cos^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ';tg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\tg^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ';arcsin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\csc^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ';arccos', snippetType = 'autosnippet', wordTrig = false }, fmt('\\sec^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ';arctg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\cot^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ';frac', snippetType = 'autosnippet', wordTrig = false }, fmt('\\frac{{{}}}{{{}}}', { i(1), i(2) })),

  s({ trig = ';eql', snippetType = 'autosnippet', wordTrig = false }, fmt('${}$', { i(1) })),

  s(
    { trig = ';eqb', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      $$
        {}
      $$
      ]],
      { i(1) }
    )
  ),

  s(
    { trig = ';bal', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      $$
      \begin{{aligned}}
        {} &= {}
      \end{{aligned}}
      $$
      ]],
      { i(1), i(2) }
    )
  ),

  s(
    { trig = ';log', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\log_{{{}}}{{{}}}', {
      i(1),
      i(2),
    })
  ),

  s(
    { trig = ';ln', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\ln{{{}}}', {
      i(1),
    })
  ),

  s(
    { trig = ';raiz', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\sqrt[{}]{{{}}}', {
      i(1),
      i(2),
    })
  ),

  s(
    { trig = ';lim', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\lim_{{{} \\to {}}}{}', {
      i(1, 'x'),
      c(2, { fmt('{}', { i(1) }), t '\\infty', t '-\\infty' }),
      i(3, ''),
    })
  ),

  s(
    { trig = ';linealim', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\displaystyle \\lim_{{{} \\to {}}}{}', {
      i(1, 'x'),
      c(2, { fmt('{}', { i(1) }), t '\\infty', t '-\\infty' }),
      i(3, ''),
    })
  ),

  s(
    { trig = ';trozo', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      {}=\begin{{cases}}
        {}&{}
      \end{{cases}}
      ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),

  s({ trig = ';neq', snippetType = 'autosnippet', wordTrig = false }, t '\\neq '),

  s({ trig = ';leq', snippetType = 'autosnippet', wordTrig = false }, t '\\leq '),

  s({ trig = ';geq', snippetType = 'autosnippet', wordTrig = false }, t '\\geq '),

  s({ trig = ';aprox', snippetType = 'autosnippet', wordTrig = false }, t '\\approx '),

  -- NOTE: OPERADORES LÓGICOS

  s({ trig = ';fall', snippetType = 'autosnippet', wordTrig = false }, { t ' \\forall ' }),

  s({ trig = ';existe', snippetType = 'autosnippet', wordTrig = false }, { t ' \\exists ' }),

  s({ trig = ';imp', snippetType = 'autosnippet', wordTrig = false }, { t ' \\implies ' }),

  s({ trig = ';dimp', snippetType = 'autosnippet', wordTrig = false }, { t ' \\iff ' }),

  s({ trig = ';subpropio', snippetType = 'autosnippet', wordTrig = false }, { t ' \\subset ' }),

  s({ trig = ';superpropio', snippetType = 'autosnippet', wordTrig = false }, { t ' \\supset ' }),

  s({ trig = ';subcj', snippetType = 'autosnippet', wordTrig = false }, { t ' \\subseteq ' }),

  s({ trig = ';supcj', snippetType = 'autosnippet', wordTrig = false }, { t ' \\supseteq ' }),

  s({ trig = ';inters', snippetType = 'autosnippet', wordTrig = false }, { t ' \\cap ' }),

  s({ trig = ';union', snippetType = 'autosnippet', wordTrig = false }, { t ' \\cup ' }),

  s({ trig = ';uniotoria', snippetType = 'autosnippet', wordTrig = false }, fmt(' \\bigcup_{{{}}}^{{{}}} ', { i(1), i(2) })),

  s({ trig = ';per', snippetType = 'autosnippet', wordTrig = false }, { t ' \\in ' }),

  s({ trig = ';noper', snippetType = 'autosnippet', wordTrig = false }, { t ' \\notin ' }),

  s({ trig = ';vacio', snippetType = 'autosnippet', wordTrig = false }, { t ' \\varnothing ' }),

  s({ trig = ';equiv', snippetType = 'autosnippet', wordTrig = false }, { t ' \\equiv ' }),

  s({ trig = ';land', snippetType = 'autosnippet', wordTrig = false }, { t ' \\land ' }),

  s({ trig = ';lor', snippetType = 'autosnippet', wordTrig = false }, { t ' \\lor ' }),

  s({ trig = ';xor', snippetType = 'autosnippet', wordTrig = false }, { t ' \\oplus ' }),

  s({ trig = ';to', snippetType = 'autosnippet', wordTrig = false }, { t ' \\to ' }),

  s({ trig = ';mid', snippetType = 'autosnippet', wordTrig = false }, { t ' \\mid ' }),

  s({ trig = ';talque', snippetType = 'autosnippet', wordTrig = false }, { t ' \\;/\\; ' }),

  s({ trig = ';move', snippetType = 'autosnippet', wordTrig = false }, { t ' \\mapsto ' }),

  s({ trig = ';eot', snippetType = 'autosnippet', wordTrig = false }, { t ' \\dashv ' }),

  s({ trig = ';bot', snippetType = 'autosnippet', wordTrig = false }, { t ' \\vdash ' }),

  s({ trig = ';cjpot', snippetType = 'autosnippet', wordTrig = false }, fmt(' \\mathcal{{P}}({}) ', { i(1) })),

  -- NOTE: LETRAS

  s({ trig = ';alfa', snippetType = 'autosnippet', wordTrig = false }, { t '\\alpha' }),
  s({ trig = ';beta', snippetType = 'autosnippet', wordTrig = false }, { t '\\beta' }),
  s({ trig = ';gama', snippetType = 'autosnippet', wordTrig = false }, { t '\\gamma' }),
  s({ trig = ';delta', snippetType = 'autosnippet', wordTrig = false }, { t '\\delta' }),
  s({ trig = ';epsilon', snippetType = 'autosnippet', wordTrig = false }, { t '\\varepsilon' }),
  s({ trig = ';teta', snippetType = 'autosnippet', wordTrig = false }, { t '\\theta' }),
  s({ trig = ';kapa', snippetType = 'autosnippet', wordTrig = false }, { t '\\kappa' }),
  s({ trig = ';lamda', snippetType = 'autosnippet', wordTrig = false }, { t '\\lambda' }),
  s({ trig = ';mu', snippetType = 'autosnippet', wordTrig = false }, { t '\\mu' }),
  s({ trig = ';pi', snippetType = 'autosnippet', wordTrig = false }, { t '\\pi' }),
  s({ trig = ';rho', snippetType = 'autosnippet', wordTrig = false }, { t '\\rho' }),
  s({ trig = ';sigma', snippetType = 'autosnippet', wordTrig = false }, { t '\\sigma' }),
  s({ trig = ';tau', snippetType = 'autosnippet', wordTrig = false }, { t '\\tau' }),
  s({ trig = ';phi', snippetType = 'autosnippet', wordTrig = false }, { t '\\phi' }),
  s({ trig = ';varphi', snippetType = 'autosnippet', wordTrig = false }, { t '\\varphi' }),
  s({ trig = ';psi', snippetType = 'autosnippet', wordTrig = false }, { t '\\psi' }),
  s({ trig = ';omega', snippetType = 'autosnippet', wordTrig = false }, { t '\\omega' }),
  s({ trig = ';vardelta', snippetType = 'autosnippet', wordTrig = false }, { t '\\partial' }),
  s({ trig = ';nabla', snippetType = 'autosnippet', wordTrig = false }, { t '\\nabla' }),

  s({ trig = ':gama', snippetType = 'autosnippet', wordTrig = false }, { t '\\Gamma' }),
  s({ trig = ':delta', snippetType = 'autosnippet', wordTrig = false }, { t '\\Delta' }),
  s({ trig = ':teta', snippetType = 'autosnippet', wordTrig = false }, { t '\\Theta' }),
  s({ trig = ':lamda', snippetType = 'autosnippet', wordTrig = false }, { t '\\Lambda' }),
  s({ trig = ':pi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Pi' }),
  s({ trig = ':sigma', snippetType = 'autosnippet', wordTrig = false }, { t '\\Sigma' }),
  s({ trig = ':phi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Phi' }),
  s({ trig = ':psi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Psi' }),
  s({ trig = ':omega', snippetType = 'autosnippet', wordTrig = false }, { t '\\Omega' }),

  -- NOTE: MISELANEOS

  s({ trig = ';sb', snippetType = 'autosnippet', wordTrig = false }, fmt('_{{{}}}', { i(1) })),

  s({ trig = ';dots', snippetType = 'autosnippet', wordTrig = false }, { t '\\dots ' }),

  s({ trig = ';vdots', snippetType = 'autosnippet', wordTrig = false }, { t '\\vdots ' }),

  s({ trig = ';ddots', snippetType = 'autosnippet', wordTrig = false }, { t '\\ddots ' }),

  s({ trig = ';*', snippetType = 'autosnippet', wordTrig = false }, { t '\\cdot ' }),

  s({ trig = ';por', snippetType = 'autosnippet', wordTrig = false }, { t '\\times ' }),

  s({ trig = ';circ', snippetType = 'autosnippet', wordTrig = false }, { t '\\circledcirc ' }),

  s({ trig = ';comp', snippetType = 'autosnippet', wordTrig = false }, { t '\\circ ' }),

  s({ trig = ';prima', snippetType = 'autosnippet', wordTrig = false }, t '^{\\prime}'),

  s({ trig = ';txt', snippetType = 'autosnippet', wordTrig = false }, fmt('\\text{{{}}}', { i(1) })),

  s({ trig = ';mth', snippetType = 'autosnippet', wordTrig = false }, fmt('\\mathcal{{{}}}', { i(1) })),

  s({ trig = ';guion', snippetType = 'autosnippet', wordTrig = false }, t '\\text{{\\textminus}}'),

  s({ trig = ';esp', snippetType = 'autosnippet', wordTrig = false }, t '\\quad '),

  s({ trig = ':esp', snippetType = 'autosnippet', wordTrig = false }, t '\\qquad '),

  s({ trig = ';vmod', snippetType = 'autosnippet', wordTrig = false }, fmt('\\lVert{}\\rVert', { i(1) })),

  s({ trig = ';mod', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left|{}\\right|', { i(1) })),

  s({ trig = ';sq', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left[{}\\right]', { i(1) })),

  s({ trig = ';pa', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left({}\\right)', { i(1) })),

  s({ trig = ';an', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left\\langle {} \\right\\rangle', { i(1) })),
  s({ trig = ';ll', snippetType = 'autosnippet', wordTrig = false }, { t '\\left\\{', i(1), t '\\right\\}' }),

  s({ trig = ';ere', snippetType = 'autosnippet', wordTrig = false }, fmt('\\mathbb{{R}}^{{{}}}', { i(1) })),

  s({ trig = ';vv', snippetType = 'autosnippet', wordTrig = false }, fmt('\\vec{{{}}}', { i(1) })),

  s({ trig = ';vs', snippetType = 'autosnippet', wordTrig = false }, fmt('\\bm{{\\hat{{{}}}}}', { i(1) })),

  s({ trig = ';mbf', snippetType = 'autosnippet', wordTrig = false }, fmt('\\mathbf{{{}}}', { i(1) })),

  s({ trig = ';ala', snippetType = 'autosnippet', wordTrig = false }, fmt('^{{{}}}', { i(1) })),

  s({ trig = ';seg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\overline{{{}}}', { i(1) })),

  s({ trig = ';oll', snippetType = 'autosnippet', wordTrig = false }, fmt('\\overbrace{{{}}}^{{{}}}', { i(1), i(2) })),

  s({ trig = ';ull', snippetType = 'autosnippet', wordTrig = false }, fmt('\\underbrace{{{}}}_{{{}}}', { i(1), i(2) })),
  s(
    { trig = ';atm', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \\
      {} &= {}
      ]],
      { i(1), i(2) }
    )
  ),

  s({ trig = ';inf', snippetType = 'autosnippet', wordTrig = false }, t '\\infty'),

  -- NOTE: OTROS

  s({ trig = ';img', snippetType = 'autosnippet', wordTrig = false }, fmt('![{}]({}){{#fig:{}}}', { i(1), i(2), i(3) })),
  s(
    { trig = ';utninf', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      ---
      lang: es
      author: Ricardo Freccero
      toc: true
      format:
        html:
          theme: cosmo
          code-fold: true
          html-math-method: katex
      bibliography: bibliografia.bib
      jupyter: python3
      ---

      ![](./imagenes/logo_utn_frc.jpg)

      ::: {{ style="text-align: center" }}
      ::: {{ style="font-family: serif" }}

      ### UNIVERSIDAD TECNOLÓGICA NACIONAL

      #### FACULTAD REGIONAL CORDOBA - EXTENSIÓN ÁULICA BARILOCHE

      ##### INGENIERÍA EN SISTEMAS DE INFORMACIÓN

      ###### AÑO LECTIVO {}

      :::

      ---

      # {}
      ### {}

      ---

      :::

      <div style="margin-top: 3rem;"></div>

      **Profesor:** {}

      **Ayudante:** {}

      <div style="margin-top: 10rem;"></div>

      ::: {{ style="text-align: right" }}

      **Alumno:** Ricardo Freccero

      **Número de legajo:** 415753

      :::

      ---

      # {}
      ]],
      {
        i(1),
        i(2, 'Materia'),
        i(3, 'Título'),
        i(4),
        i(5),
        i(6, 'Nombre sección'),
      }
    )
  ),
}

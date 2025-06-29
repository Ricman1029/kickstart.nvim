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

-- Generador dinámico de matrices
local function matrix_generator(_, snip)
  local dims = snip.captures[1] -- Extraído del regex (por ejemplo, "3x3")
  local n, m = dims:match '(%d+)p(%d+)'
  n = tonumber(n)
  m = tonumber(m)
  local nodes = {}

  for row = 1, n do
    for col = 1, m do
      table.insert(nodes, i((row - 1) * m + col, ''))
      if col < m then
        table.insert(nodes, t ' & ')
      end
    end
    if row < n then
      table.insert(nodes, t { ' \\\\', '' })
    end
  end

  return sn(nil, nodes)
end

return {
  -- NOTE: AUTOSNIPPETS

  -- NOTE: ENVIRONMENTS

  s(
    { trig = ';beq', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{equation}}\label{{eq:{}}}
          {}
        \end{{equation}}
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s(
    { trig = ';ben', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{enumerate}}[{}]
          \item {}
        \end{{enumerate}}
      ]],
      {
        i(1, '1.'),
        i(2),
      }
    )
  ),

  s(
    { trig = ':ben', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{enumerate*}}[{}]
          \item {}
        \end{{enumerate*}}
      ]],
      {
        i(1, '1.'),
        i(2),
      }
    )
  ),

  s(
    { trig = ';bal', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{align}}
          {} &= {}
        \end{{align}}
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s(
    { trig = ':bal', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{align*}}
          {} &= {}
        \end{{align*}}
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s(
    { trig = ';bit', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \begin{{itemize}}
        \item {}
      \end{{itemize}}
      ]],
      {
        i(1),
      }
    )
  ),

  s(
    { trig = ';bald', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \begin{{aligned}}
        {}
      \end{{aligned}}
      ]],
      {
        i(1),
      }
    )
  ),

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

  s(
    { trig = ';fig', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{figure}}[{}]
          \centering
          {}
          \caption{{{}}}
          \label{{{}}}
        \end{{figure}}
      ]],
      {
        i(1, 'H'),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s(
    { trig = ';minip', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{minipage}}{{{}\textwidth}}
          {}
        \end{{minipage}}
      ]],
      {
        i(1, '0.5'),
        i(2),
      }
    )
  ),

  s(
    { trig = ';img', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
          \centering
          \includegraphics[width={}\linewidth]{{{}}}
          \caption{{{}}}
          \label{{fig:{}}}
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s(
    { trig = ';tikz', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        {{\large {}}}

        \tikzsetnextfilename{{{}}}
        \begin{{tikzpicture}}
          {}
        \end{{tikzpicture}}
        \caption{{{}}}
        \label{{tkz:{}}}
      ]],
      {
        i(1, 'titulo'),
        i(2, 'nombre archivo'),
        i(3),
        i(4, 'descripción'),
        i(5),
      }
    )
  ),

  s(
    { trig = ';automata', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        {{\large {}}}

        \tikzsetnextfilename{{{}}}
        \begin{{tikzpicture}}[automata]
          {}
        \end{{tikzpicture}}
        \caption{{{}}}
        \label{{aut:{}}}
      ]],
      {
        i(1, 'titulo'),
        i(2, 'nombre archivo'),
        i(3),
        i(4, 'descripción'),
        i(5),
      }
    )
  ),

  s(
    { trig = ';3d', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      {{\large {}}}

      \tikzsetnextfilename{{{}}}
      \begin{{tikzpicture}}
        \begin{{axis}}[
          width={}\textwidth,
          clip=false,
          xlabel={{$x$}}, ylabel={{$y$}}, zlabel={{$f(x,y)$}},
          view={{110}}{{20}},
          axis lines=center,
          axis on top=true,
        ]
          {}
        \end{{axis}}
      \end{{tikzpicture}}
      \caption{{{}}}
      \label{{grf:{}}}
      ]],
      {
        i(1, 'título'),
        i(2, 'nombre archivo'),
        i(3),
        i(4),
        i(5, 'descripción'),
        i(6),
      }
    )
  ),

  s(
    { trig = ';2d', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        {{\large {}}}

        \tikzsetnextfilename{{{}}}
        \begin{{tikzpicture}}
          \begin{{axis}}[
            width={}\textwidth,
            clip=false,
            xlabel={{$x$}}, ylabel={{$y$}},
            axis lines=center,
            axis on top=true,
          ]
            \addplot [{}, thick, name path={}, domain={}:{}] {{{}}};
          \end{{axis}}
        \end{{tikzpicture}}
        \caption{{{}}}
        \label{{grf:{}}}
      ]],
      {
        i(1, 'título'),
        i(2, 'nombre archivo'),
        i(3),
        i(4, 'black'),
        i(5),
        i(6),
        i(7),
        i(8),
        i(9, 'descripción'),
        i(10),
      }
    )
  ),

  -- NOTE: MATH

  s(
    { trig = ';int', snippetType = 'autosnippet', wordTrig = false },
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
    { trig = ';iint', snippetType = 'autosnippet', wordTrig = false },
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
    { trig = ';iiint', snippetType = 'autosnippet', wordTrig = false },
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
    { trig = ';dint', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \int_{{{}}}^{{{}}} \int_{{{}}}^{{{}}} {} \,d{}\,d
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
    { trig = ';tint', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \int_{{{}}}^{{{}}} \int_{{{}}}^{{{}}} \int_{{{}}}^{{{}}} {} \,d{}\,d{}\,d
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
    fmt([[\pdv[{}]{{{}}}{{{}}}]], {
      i(1),
      i(2),
      i(3),
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

  s({ trig = ':sin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\csc^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ':cos', snippetType = 'autosnippet', wordTrig = false }, fmt('\\sec^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ':tg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\cot^{{{}}}({})', { i(1), i(2) })),

  s({ trig = ';fra', snippetType = 'autosnippet', wordTrig = false }, fmt('\\frac{{{}}}{{{}}}', { i(1), i(2) })),

  s({ trig = ';eql', snippetType = 'autosnippet', wordTrig = false }, fmt('$ {} $', { i(1) })),

  s(
    { trig = ';eqb', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \[
        {}
      \]
      ]],
      { i(1) }
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
    { trig = ';ilim', snippetType = 'autosnippet', wordTrig = false },
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

  -- NOTE: SECTIONS

  s({ trig = ';sec', snippetType = 'autosnippet', wordTrig = false }, fmt('\\section{{{}}}', { i(1) })),

  s({ trig = ';ssc', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsection{{{}}}', { i(1) })),

  s({ trig = ';sss', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsubsection{{{}}}', { i(1) })),

  s({ trig = ';spar', snippetType = 'autosnippet', wordTrig = false }, fmt('\\paragraph{{{}}}\\mbox{{}}\\\\', { i(1) })),
  s({ trig = ':sec', snippetType = 'autosnippet', wordTrig = false }, fmt('\\section*{{{}}}', { i(1) })),

  s({ trig = ':ssc', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsection*{{{}}}', { i(1) })),

  s({ trig = ':sss', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsubsection*{{{}}}', { i(1) })),

  s({ trig = ':spar', snippetType = 'autosnippet', wordTrig = false }, fmt('\\paragraph*{{{}}}\\mbox{{}}', { i(1) })),

  -- NOTE:  LOGIC OPERATORS

  s({ trig = ';fall', snippetType = 'autosnippet', wordTrig = false }, { t ' \\forall ' }),

  s({ trig = ';exis', snippetType = 'autosnippet', wordTrig = false }, { t ' \\exists ' }),

  s({ trig = ';imp', snippetType = 'autosnippet', wordTrig = false }, { t ' \\implies ' }),

  s({ trig = ';iff', snippetType = 'autosnippet', wordTrig = false }, { t ' \\iff ' }),

  s({ trig = ';subc', snippetType = 'autosnippet', wordTrig = false }, { t ' \\subset ' }),

  s({ trig = ';supc', snippetType = 'autosnippet', wordTrig = false }, { t ' \\supset ' }),

  s({ trig = ';esub', snippetType = 'autosnippet', wordTrig = false }, { t ' \\subseteq ' }),

  s({ trig = ';esup', snippetType = 'autosnippet', wordTrig = false }, { t ' \\supseteq ' }),

  s({ trig = ';cap', snippetType = 'autosnippet', wordTrig = false }, { t ' \\cap ' }),

  s({ trig = ';cup', snippetType = 'autosnippet', wordTrig = false }, { t ' \\cup ' }),

  s({ trig = ':cup', snippetType = 'autosnippet', wordTrig = false }, fmt(' \\bigcup_{{{}}}^{{{}}} ', { i(1), i(2) })),

  s({ trig = ';per', snippetType = 'autosnippet', wordTrig = false }, { t ' \\in ' }),

  s({ trig = ';nper', snippetType = 'autosnippet', wordTrig = false }, { t ' \\notin ' }),

  s({ trig = ';vacio', snippetType = 'autosnippet', wordTrig = false }, { t ' \\varnothing ' }),

  s({ trig = ';equiv', snippetType = 'autosnippet', wordTrig = false }, { t ' \\equiv ' }),

  s({ trig = ';land', snippetType = 'autosnippet', wordTrig = false }, { t ' \\land ' }),

  s({ trig = ';lor', snippetType = 'autosnippet', wordTrig = false }, { t ' \\lor ' }),

  s({ trig = ';xor', snippetType = 'autosnippet', wordTrig = false }, { t ' \\oplus ' }),

  s({ trig = ';to', snippetType = 'autosnippet', wordTrig = false }, { t ' \\to ' }),

  s({ trig = ';mid', snippetType = 'autosnippet', wordTrig = false }, { t ' \\mid ' }),

  s({ trig = ';talq', snippetType = 'autosnippet', wordTrig = false }, { t ' \\;/\\; ' }),

  s({ trig = ';move', snippetType = 'autosnippet', wordTrig = false }, { t ' \\mapsto ' }),

  s({ trig = ';eot', snippetType = 'autosnippet', wordTrig = false }, { t ' \\dashv ' }),

  s({ trig = ';bot', snippetType = 'autosnippet', wordTrig = false }, { t ' \\vdash ' }),

  s({ trig = ';cpot', snippetType = 'autosnippet', wordTrig = false }, fmt(' \\mathcal{{P}}({}) ', { i(1) })),

  -- NOTE: AUTOMATAS

  s(
    { trig = ';anodo', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\node[{}, {}, {}, yshift={}cm, xshift={}cm] ({}) {{${}$}};', {
      i(1, 'state'),
      i(2, 'initial'),
      i(3, 'posicion'),
      i(4, '0'),
      i(5, '0'),
      i(6, 'nombre'),
      i(7, 'texto'),
    })
  ),

  s(
    { trig = ';aarista', snippetType = 'autosnippet', wordTrig = false },
    fmt('({}) edge[{}, {}] node{{{}}} ({})', {
      i(1, 'nombre salida'),
      i(2, 'posicion texto'),
      i(3, 'bend left'),
      i(4, 'texto flecha'),
      i(5, 'nombre llegada'),
    })
  ),

  s({ trig = ';adibujar', snippetType = 'autosnippet', wordTrig = false }, fmt('\\draw   {}\n;', { i(1) })),

  -- NOTE: DIBUJOS TIKZ

  s(
    { trig = ';tkzflecha', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\draw [->, draw={}, thick] ({}) edge[{}, {}] node{{{}}} ({});', {
      i(1, 'color'),
      i(2, 'nombre salida'),
      i(3, 'posicion texto'),
      i(4, 'bend left'),
      i(5, 'texto flecha'),
      i(6, 'nombre llegada'),
    })
  ),

  s(
    { trig = ';tkzpunto', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\node[{}, yshift={}cm, xshift={}cm] ({}) {{${}$}};', {
      i(1, 'posicion'),
      i(2, '0'),
      i(3, '0'),
      i(4, 'nombre'),
      i(5, 'texto'),
    })
  ),

  s(
    { trig = ';tkzgrupo', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\node[fit={}] ({}) {{{}}};', {
      i(1, 'nodos'),
      i(2, 'nombre'),
      i(3, 'texto'),
    })
  ),

  s(
    { trig = ';tkzembrace', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \draw [decorate, decoration={{brace, amplitude=5pt}}] ({}.north east) -- ({}.south east);
      \draw [decorate, decoration={{brace, amplitude=5pt, mirror}}] ({}.north west) -- ({}.south west);
      ]],
      {
        i(1, 'grupo'),
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),

  -- NOTE: GRÁFICAS

  s(
    { trig = ';grfrestringir', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      domain={}:{}, y domain={}:{},
      zmax={}, point meta max={},
      samples={},
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        rep(5),
        i(6, '40'),
      }
    )
  ),

  s(
    { trig = ';grflimitar', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      xmin={}, xmax={},
      ymin={}, ymax={},
      zmin={}, zmax={},
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
    { trig = ';3funcion', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \addplot3 [{}, shader=flat, colormap/{},]
          {{{}}};
      ]],
      {
        i(1, 'surf'),
        i(2, 'viridis'),
        i(3),
      }
    )
  ),

  s(
    { trig = ';3punto', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \addplot3 [only marks, mark=*, mark size=5pt, color={},]
          coordinates {{({},{},{})}};
      \node at (axis cs:{},{},{}) [anchor={}] {{$P({},{},{})$}};
      ]],
      {
        i(1, 'red!70'),
        i(2),
        i(3),
        i(4),
        rep(2),
        rep(3),
        rep(4),
        i(5, 'north'),
        rep(2),
        rep(3),
        rep(4),
      }
    )
  ),

  s(
    { trig = ';2curva', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \addplot [{}, thick, name path={}, domain={}:{},] {{{}}};
      ]],
      {
        i(1, 'black'),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    )
  ),

  s(
    { trig = ';2area', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \addplot [{}] fill between [of={} and {}, soft clip={{{}}}];
      ]],
      {
        i(1, 'blue!30'),
        i(2, 'A'),
        i(3, 'B'),
        i(4),
      }
    )
  ),

  s(
    { trig = ';2punto', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \addplot [only marks, mark=*, mark size=5pt, color={},]
          coordinates {{({},{})}};
      \node at (axis cs:{},{}) [anchor={}] {{$P({},{})$}};
      ]],
      {
        i(1, 'blue!30'),
        i(2),
        i(3),
        rep(2),
        rep(3),
        i(4, 'south'),
        rep(2),
        rep(3),
      }
    )
  ),

  s(
    { trig = ';2vector', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \addplot [-stealth, very thick, {}] coordinates {{({},{}) ({},{})}};
      ]],
      {
        i(1, 'red!70'),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    )
  ),

  s(
    { trig = ';2label', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \node at (axis cs:{},{}) [{}] {{{}}};
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s({ trig = ';domain', snippetType = 'autosnippet', wordTrig = false }, fmt('domain={}:', { i(1) })),

  -- NOTE: MISCELLANEOUS

  s({ trig = ';alfa', snippetType = 'autosnippet', wordTrig = false }, { t '\\alpha' }),
  s({ trig = ';beta', snippetType = 'autosnippet', wordTrig = false }, { t '\\beta' }),
  s({ trig = ';gama', snippetType = 'autosnippet', wordTrig = false }, { t '\\gamma' }),
  s({ trig = ';delta', snippetType = 'autosnippet', wordTrig = false }, { t '\\delta' }),
  s({ trig = ';epsi', snippetType = 'autosnippet', wordTrig = false }, { t '\\varepsilon' }),
  s({ trig = ';teta', snippetType = 'autosnippet', wordTrig = false }, { t '\\theta' }),
  s({ trig = ';kappa', snippetType = 'autosnippet', wordTrig = false }, { t '\\kappa' }),
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
  s({ trig = ';vardel', snippetType = 'autosnippet', wordTrig = false }, { t '\\partial' }),
  s({ trig = ';nab', snippetType = 'autosnippet', wordTrig = false }, { t '\\nabla' }),

  s({ trig = ':gama', snippetType = 'autosnippet', wordTrig = false }, { t '\\Gamma' }),
  s({ trig = ':delta', snippetType = 'autosnippet', wordTrig = false }, { t '\\Delta' }),
  s({ trig = ':teta', snippetType = 'autosnippet', wordTrig = false }, { t '\\Theta' }),
  s({ trig = ':lamda', snippetType = 'autosnippet', wordTrig = false }, { t '\\Lambda' }),
  s({ trig = ':pi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Pi' }),
  s({ trig = ':sigma', snippetType = 'autosnippet', wordTrig = false }, { t '\\Sigma' }),
  s({ trig = ':phi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Phi' }),
  s({ trig = ':psi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Psi' }),
  s({ trig = ':omega', snippetType = 'autosnippet', wordTrig = false }, { t '\\Omega' }),

  s({ trig = ';neq', snippetType = 'autosnippet', wordTrig = false }, t '\\neq '),

  s({ trig = ';leq', snippetType = 'autosnippet', wordTrig = false }, t '\\leq '),

  s({ trig = ';geq', snippetType = 'autosnippet', wordTrig = false }, t '\\geq '),

  s({ trig = ';app', snippetType = 'autosnippet', wordTrig = false }, t '\\approx '),

  s({ trig = ';inft', snippetType = 'autosnippet', wordTrig = false }, { t '\\infty' }),

  s({ trig = ';dots', snippetType = 'autosnippet', wordTrig = false }, { t '\\dots ' }),

  s({ trig = ';vdots', snippetType = 'autosnippet', wordTrig = false }, { t '\\vdots ' }),

  s({ trig = ';ddots', snippetType = 'autosnippet', wordTrig = false }, { t '\\ddots ' }),

  s({ trig = ';*', snippetType = 'autosnippet', wordTrig = false }, { t '\\cdot ' }),

  s({ trig = '"', snippetType = 'autosnippet', wordTrig = false }, fmt([[``{}'']], { i(1) })),

  s({ trig = ';por', snippetType = 'autosnippet', wordTrig = false }, { t '\\times ' }),

  s({ trig = ';circ', snippetType = 'autosnippet', wordTrig = false }, { t '\\circledcirc ' }),

  s({ trig = ';comp', snippetType = 'autosnippet', wordTrig = false }, { t '\\circ ' }),

  s({ trig = ';prima', snippetType = 'autosnippet', wordTrig = false }, t '^{\\prime}'),

  s({ trig = ';txt', snippetType = 'autosnippet', wordTrig = false }, fmt('\\text{{{}}}', { i(1) })),

  s({ trig = ';guion', snippetType = 'autosnippet', wordTrig = false }, t '\\text{{\\textminus}}'),

  s({ trig = ';esp', snippetType = 'autosnippet', wordTrig = false }, t '\\quad '),

  s({ trig = ':esp', snippetType = 'autosnippet', wordTrig = false }, t '\\qquad '),

  s({ trig = ';it', snippetType = 'autosnippet', wordTrig = false }, { t { '', '', '\\item ' } }),

  s(
    { trig = ';atm', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \\
      {} &= {}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = ';apr', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \\
      {} &:= {}
      ]],
      { i(1), i(0) }
    )
  ),

  s({ trig = ';vmod', snippetType = 'autosnippet', wordTrig = false }, fmt('\\lVert{}\\rVert', { i(1) })),

  s({ trig = ';mod', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left|{}\\right|', { i(1) })),

  s({ trig = ';sq', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left[{}\\right]', { i(1) })),

  s({ trig = ';pa', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left({}\\right)', { i(1) })),

  s({ trig = ';an', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left\\langle {} \\right\\rangle', { i(1) })),
  s({ trig = ';ll', snippetType = 'autosnippet', wordTrig = false }, { t '\\left\\{', i(1), t '\\right\\}' }),

  s({ trig = ';ere', snippetType = 'autosnippet', wordTrig = false }, fmt('\\mathbb{{R}}^{{{}}}', { i(1) })),

  s({ trig = ';vv', snippetType = 'autosnippet', wordTrig = false }, fmt('\\vv{{{}}}', { i(1) })),

  s({ trig = ';vs', snippetType = 'autosnippet', wordTrig = false }, fmt('\\hat{{{}}}', { i(1) })),

  s({ trig = ';mbf', snippetType = 'autosnippet', wordTrig = false }, fmt('\\mathbf{{{}}}', { i(1) })),

  s({ trig = ';tbf', snippetType = 'autosnippet', wordTrig = false }, fmt('\\textbf{{{}}}', { i(1) })),

  s({ trig = ';cod', snippetType = 'autosnippet', wordTrig = false }, fmt('\\verb|{}|', { i(1) })),

  s({ trig = ';tit', snippetType = 'autosnippet', wordTrig = false }, fmt('\\textit{{{}}}', { i(1) })),

  s({ trig = ';seg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\overline{{{}}}', { i(1) })),

  s({ trig = ';sb', snippetType = 'autosnippet', wordTrig = false }, fmt('_{{{}}}', { i(1) })),

  s({ trig = ';ala', snippetType = 'autosnippet', wordTrig = false }, fmt('^{{{}}}', { i(1) })),

  s({ trig = ';ulin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\underline{{{}}}', { i(1) })),

  s({ trig = ';oll', snippetType = 'autosnippet', wordTrig = false }, fmt('\\overbrace{{{}}}^{{{}}}', { i(1), i(2) })),

  s({ trig = ';ull', snippetType = 'autosnippet', wordTrig = false }, fmt('\\underbrace{{{}}}_{{{}}}', { i(1), i(2) })),
  s({ trig = ';cita', snippetType = 'autosnippet', wordTrig = false }, fmt('\\parencite{{{}}}', { i(1) })),

  s({ trig = ';ref', snippetType = 'autosnippet', wordTrig = false }, fmt('\\ref{{{}}}', { i(1) })),

  s({ trig = ';aql', snippetType = 'autosnippet', wordTrig = false }, { t ' &= ' }),

  s({ trig = ';prod', snippetType = 'autosnippet', wordTrig = false }, { t ' &:= ' }),

  s(
    { trig = ';tbox', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \vspace{{0.2cm}}
      \fbox{{\parbox{{{}\linewidth}}{{
      \textbf{{{}}}

      {}
      }}}}\vspace{{0.2cm}}
      ]],
      {
        i(1, '0.9'),
        i(2, 'Título'),
        i(3),
      }
    )
  ),

  s({ trig = ';box', snippetType = 'autosnippet', wordTrig = false }, fmt([[\boxed{{{}}} ]], { i(1) })),

  -- NOTE: NORMAL SNIPPETS
  s(
    'utninf',
    fmt(
      [[
        \documentclass[12pt]{{article}}
        \usepackage[spanish]{{babel}}
        \usepackage[utf8]{{inputenc}}
        \usepackage{{csquotes}}

        % Interlineado 1.5
        \usepackage{{mathpazo}}
        \usepackage{{setspace}}
        \onehalfspacing

        % Fuente Times New Roman
        \usepackage{{mathptmx}}

        % Acomodar margenes del documento
        \usepackage[a4paper, margin=2cm, top=3cm, headheight=50pt]{{geometry}}

        % Paquetes comunes
        \usepackage{{graphicx, float}}
        \usepackage{{amsfonts, amssymb, amsmath}}
        \usepackage{{physics, esvect}}
        \usepackage{{enumerate}}
        \usepackage[colorlinks=true, citecolor=blue]{{hyperref}}

        % Para graficar
        \usepackage{{pgfplots}}
        \usepackage{{tikz, color}}
        \usepackage{{tikz-3dplot}}
        \pgfplotsset{{width=15cm, compat=1.18}}
        \usepgfplotslibrary{{external}}
        \tikzexternalize[prefix=figs/]

        % Para automatas
        \usetikzlibrary{{automata, positioning, arrows, calc}}
        \tikzset{{
                ->,  % makes the edges directed
                >=stealth, % makes the arrow heads bold
                shorten >=2pt, shorten <=2pt, % shorten the arrow
                node distance=3cm, % specifies the minimum distance between two nodes. Change if n
                every state/.style={{draw=blue!55,very thick,fill=blue!20}}, % sets the properties for each ’state’ n
                initial text=$ $, % sets the text that appears on the start arrow
        }}

        % Encabezados
        \usepackage{{fancyhdr}}
        \pagestyle{{fancy}}
        \fancyhf{{}}
        \fancyfoot[C]{{\thepage}}
        \fancyhead[L]{{
          \includegraphics[height=1.2cm]{{~/imagenes/logo_utn.png}}
          \shortstack[l]{{
            {{\footnotesize Universidad Tecnológica Nacional}} \\
            {{\footnotesize Facultad Regional Córdoba}} \\
            {{\footnotesize Extensión Áulica Bariloche}}
          }}
        }}
        \fancyhead[C]{{
          \shortstack[c]{{
            {{\footnotesize {}}} \\
            {{\footnotesize {}}} \\
            {{\footnotesize }}
          }}
        }}
        \fancyhead[R]{{
          \shortstack[r]{{
            {{\footnotesize Profesor: {}}} \\
            {{\footnotesize Alumno: Ricardo Nicolás Freccero}} \\
            {{\footnotesize Fecha: {}}}
          }}
        }}

        % Para bibliografía
        %\usepackage[backend=biber, style=apa]{{biblatex}}
        %\addbibresource{{bibliografia.bib}}

        \begin{{document}}
        \newgeometry{{margin=2cm, top=1.5cm}}
          \begin{{titlepage}}
            \centering
            \includegraphics[width=\linewidth]{{~/imagenes/logo_utn_frc.jpg}}\\

            \textsc{{
              \LARGE Universidad Tecnológica Nacional\\
              \Large Facultad Regional Córdoba - Extensión Áulica Bariloche\\
              \large Ingeniería en Sistemas de Información\\
              Año lectivo {}\\[0.5cm]
            }}

            \rule{{\linewidth}}{{1.0mm}}\\[0.4cm]
            \Huge
            \textbf{{{}}}\\
            {}\\[0.2cm]
            \LARGE
            {}
            \rule{{\linewidth}}{{1.0mm}}\\
            \large
            \begin{{flushleft}}
              Profesor: {}

              Ayudante: {}

              Fecha: {}
            \end{{flushleft}}

            \vfill
            \begin{{flushright}}
              Alumno: Ricardo Nicolás Freccero

              Número de legajo: 415753
            \end{{flushright}}
          \end{{titlepage}}

          \restoregeometry
          \tableofcontents
          \newpage

          \section{{Enunciado}}
          {}

          \section{{Introducción}}


          \section{{Desarrollo}}


          \section{{Conclusión}}

          %\newpage
          %\addcontentsline{{toc}}{{section}}{{Referencias}}
          %\printbibliography

        \end{{document}}
      ]],
      {
        rep(2),
        rep(3),
        rep(5),
        rep(7),
        i(1, 'Año'),
        i(2, 'Materia'),
        i(3, 'Trabajo Práctico N°'),
        i(4, 'Título'),
        i(5, 'Nombre Profesor'),
        i(6, 'Nombre Ayudante'),
        i(7, 'Fecha'),
        i(0),
      }
    )
  ),
  s(
    'begin',
    fmt(
      [[
        \begin{{{}}}{}
          {}
        \end{{{}}}
      ]],
      {
        i(1, 'environment'),
        c(2, {
          t '',
          fmt('[{}]', { i(1, 'opcional') }),
        }),
        i(3),
        rep(1),
      }
    )
  ),
}

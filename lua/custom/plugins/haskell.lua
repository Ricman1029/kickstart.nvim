-- ~/.config/nvim/lua/custom/plugins/haskell.lua

return {
  -- 1. Esto asegura que el parser de Tree-sitter para Haskell esté instalado
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- Añadimos 'haskell' a la lista de lenguajes a instalar
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'haskell' })
      end
    end,
  },

  -- 2. Esta es la configuración principal para el servidor de lenguaje (HLS)
  {
    'neovim/nvim-lspconfig',
    -- Opcional: nos aseguramos de que se configure después de mason.
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      -- Obtenemos la configuración base de lspconfig
      local lspconfig = require 'lspconfig'

      -- Llamamos directamente a la función de setup para 'hls'.
      -- Neovim buscará 'haskell-language-server-wrapper' en tu PATH,
      -- que es exactamente lo que `ghcup` instala y configura.
      lspconfig.hls.setup {
        -- No necesitamos poner nada especial aquí por ahora,
        -- la configuración por defecto que viene con nvim-lspconfig es suficiente.
      }
    end,
  },
}

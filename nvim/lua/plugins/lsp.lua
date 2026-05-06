return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'eslint', 'rust_analyzer', 'lua_ls' },
        automatic_enable = true,
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN]  = 'W',
            [vim.diagnostic.severity.HINT]  = 'H',
            [vim.diagnostic.severity.INFO]  = 'I',
          },
        },
      })

      local format_filetypes = { lua = 'lua_ls', rust = 'rust_analyzer' }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local bufnr = ev.buf
          local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func,
              { buffer = bufnr, desc = 'LSP: ' .. desc, remap = false })
          end

          nmap('gD', vim.lsp.buf.declaration,                            '[G]oto [D]eclaration')
          nmap('gd', vim.lsp.buf.definition,                             '[G]oto [D]efinition')
          nmap('gr', require('telescope.builtin').lsp_references,        '[G]oto [R]eferences')
          nmap('gI', require('telescope.builtin').lsp_implementations,   '[G]oto [I]mplementation')
          nmap('[d', vim.diagnostic.goto_next,                           'Go to next diagnostic')
          nmap(']d', vim.diagnostic.goto_prev,                           'Go to previous diagnostic')
          nmap('K',  vim.lsp.buf.hover,                                  'Hover Documentation')
          nmap('<C-h>', vim.lsp.buf.signature_help,                      'Signature Documentation')
          nmap('<leader>rn', vim.lsp.buf.rename,                         '[R]e[n]ame')
          nmap('<leader>ca', vim.lsp.buf.code_action,                    '[C]ode [A]ction')

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local ft = vim.bo[bufnr].filetype
          if client and format_filetypes[ft] == client.name then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false, timeout_ms = 10000, bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
      },
    },
    config = function()
      local cmp = require('cmp')
      require('luasnip.loaders.from_vscode').lazy_load()

      local select_opts = { behavior = cmp.SelectBehavior.Select }
      cmp.setup({
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lua' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>']     = cmp.mapping.select_prev_item(select_opts),
          ['<C-n>']     = cmp.mapping.select_next_item(select_opts),
          ['<C-y>']     = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
      })
    end,
  },
}

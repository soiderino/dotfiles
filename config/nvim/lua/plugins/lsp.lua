return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {
      ui = {
        icons = {
          package_installed = '+',
          package_pending = '!',
          package_uninstalled = '-',
        },
      },
    },
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        {
          { name = 'buffer' },
          { name = 'path' }
        },

        mapping = cmp.mapping.preset.insert({
          ['<c-space>'] = cmp.mapping.complete(),
          ['<c-[>'] = cmp.mapping.scroll_docs(-4),
          ['<c-]>'] = cmp.mapping.scroll_docs(4),
          ['<cr>'] = cmp.mapping.confirm({ select = true })
        }),

        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
            luasnip.lsp_expand(args.body)
          end,
        },
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },

  -- cmake integration
  'Civitasv/cmake-tools.nvim',

  -- formatter
  {
    'stevearc/conform.nvim',
    opts = {
      stop_after_first = true,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
    keys = {
      {
        '<leader>tf',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- lsp
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },

    init = function()
      vim.opt.signcolumn = 'yes'
    end,

    ---@class PluginLspOpts
    opts = function()
      local ret = {
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = true,
          virtual_text = {
            spacing = 4,
            source = 'if_many',
            prefix = '*',
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = 'E',
              [vim.diagnostic.severity.WARN] = 'W',
              [vim.diagnostic.severity.HINT] = 'H',
              [vim.diagnostic.severity.INFO] = 'I',
            },
          },
        },

        inlay_hints = {
          enabled = true,
          -- exclude = { 'vue' },
        },

        codelens = {
          enabled = true,
        },

        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },

        servers = {
          lua_ls = {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = 'Replace',
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = 'Disable',
                  semicolon = 'Disable',
                  arrayIndex = 'Disable',
                },
              },
            },
          },
          clangd = {},
          bashls = {},
          awk_ls = {},
          marksman = {},
          astro = {},
          cmake = {},
          svelte = {},
          ts_ls = {},
          cssls = {},
          tailwindcss = {},
        },

        setup = {},
      }
      return ret
    end,

    config = function(_, opts)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local ensure_installed = vim.tbl_keys(opts.servers)

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
        automatic_enable = true,
        automatic_installation = true,
        handlers = {
          setup,
        },
      })
    end,
  },
}

-- This is for all kinds of completion, e.g. telescope/fzf-lua, snippets, nvim-cmp, etc.
return {

  -- https://github.com/abeldekat/cmp-mini-snippets


  -- nvim-scissors {{{
  -- https://github.com/chrisgrieser/nvim-scissors
  -- Edit your VSCode style snippets.

  -- }}}

  {},
  -- }}}

  -- mini.snippets {{{
  -- https://github.com/echasnovski/mini.snippets
  -- friendly-snippets
  -- https://github.com/rafamadriz/friendly-snippets
  {
    'echasnovski/mini.snippets',
    dependencies = "rafamadriz/friendly-snippets",
    events = "InsertEnter",
    version = false,
    config = function()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          gen_loader.from_file('~/.config/nvim/snippets/global.json'),

          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          gen_loader.from_lang(),
        },
      })
    end,
  },
  -- }}}

  -- nvim-cmp {{{
  -- https://github.com/hrsh7th/nvim-cmp
  -- A completion engine for Neovim written in lua.
  --
  -- https://github.com/hrsh7th/cmp-buffer
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'davidsierradz/cmp-conventionalcommits',
      'Paterjason/cmp-conjure',
      "abeldekat/cmp-mini-snippets",
    },
    config = function()
      local cmp = require'cmp'
      local select_opts = { behavior = cmp.SelectBehavior.Select }
      local lspkind = require('lspkind')
      lspkind.init({
        mode = 'symbol_text',
      })
      cmp.setup({
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function (entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = "symbol_text",
              menu = {
                nvim_lsp = "[LSP]",
                mini_snippets = "[Snip]",
                nvim_lsp_signature_help = "[Sign]",
                nvim_lua =  "[Lua]",
                buffer = "[Buf]",
                crates = "[Crate]",
                path = "[Path]",
                git = "[Git]",
                conventionalcommits = "[Conv]",
              },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            return kind
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'conjure' },
          { name = "mini_snippets",
            option = {
              use_items_cache = false
            }
          },
          -- { name = 'nvim_lua' },
          -- { name = 'path' },
          { name = 'buffer',
            option = {
              keyword_length = 3,
              keyword_pattern = [[\k\+]],
              -- Visible buffers.
              get_bufnrs = function()
                local bufs= {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_wind_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end
            }
          },
          { name = 'nvim_lsp', max_item_count = 50, keyword_length = 1 },
          { name = 'nvim_lsp_signature_help'},
          -- { name = 'treesitter', max_item_count = 10 },
          -- { name = 'crates' },
        },
        mapping = {
          ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
          ['<Down>'] = cmp.mapping.select_next_item(select_opts),

          ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
          ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          ['<C-g>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({select = false}),

          ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
              cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
              fallback()
            else
              cmp.complete()
            end
          end, {'i', 's'}),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(select_opts)
            end
          end, {'i', 's'}),
        },
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources( {
          { name = 'git' },
          { name = 'buffer' },
          { name = 'conventionalcommits' },
        })
      })

    end,

  },

  -- }}}

}

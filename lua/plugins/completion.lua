-- This is for all kinds of completion, e.g. telescope/fzf-lua, snippets, nvim-cmp, etc.
return {

    -- nvim-cmp {{{
    -- https://github.com/hrsh7th/nvim-cmp
    -- A completion engine for Neovim written in lua.
    --
    -- https://github.com/L3MON4D3/LuaSnip
    -- I am using the snipmate style of snippets because i find the VSCode style annoying.
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
        {
          'L3MON4D3/LuaSnip',
          dependencies = {
            'honza/vim-snippets',
            'saadparwaiz1/cmp_luasnip',
          },
          config = function() require('luasnip.loaders.from_snipmate').lazy_load({ paths = { "./deftpunk_snippets" } }) end,
        },
      },
      config = function()
        local cmp = require'cmp'
        local select_opts = { behavior = cmp.SelectBehavior.Select }
        local lspkind = require('lspkind')
        lspkind.init({
            mode = 'symbol_text',
          })
        cmp.setup({
            snippet = {
              expand = function(args)
                require'luasnip'.lsp_expand(args.body)
                -- luasnip.lsp_expand(args.body)
              end,
            },
            formatting = {
              fields = { "kind", "abbr", "menu" },
              format = function (entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = "symbol_text",
                    menu = {
                      luasnip = "[Snip]",
                      nvim_lsp = "[LSP]",
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
              -- { name = 'nvim_lua' },
              -- { name = 'path' },
              -- { name = 'buffer', keyword_length = 3 },
              { name = 'luasnip' },
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

              ['<C-f>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, {'i', 's'}),

              -- luasnip bindings while we are in cmp
              ['<C-b>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, {'i', 's'}),

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
                else
                  fallback()
                end
              end, {'i', 's'}),
            },
          })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources( {
                { name = 'git' },
                { name = 'buffer' },
                { name = 'conventionalcommits' },
                { name = 'luasnip' },
              })
          })

      end,

    },

    -- {
    --   'petertriho/cmp-git',
    --   ft = { 'gitcommit', 'gitrebase', 'octo' },
    --   dependencies = { 'nvim-lua/plenary.nvim' },
    --   config = function() require('cmp_git').setup() end,
    -- },

    -- }}}

}

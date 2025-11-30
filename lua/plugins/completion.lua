-- This is for all kinds of completion, e.g. telescope/fzf-lua, snippets, nvim-cmp, etc.
return {

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

  -- blink.cmp {{{
  -- https://cmp.saghen.dev/installation.html
  --
  -- https://www.reddit.com/r/neovim/comments/1hlnv7x/blinkcmp_i_finally_have_a_configuration_that/
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {'rafamadriz/friendly-snippets',
                    'echasnovski/mini.snippets',
                  },
    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        -- preset = 'default'
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
            function(cmp)
                return cmp.select_next()
            end,
            "snippet_forward",
            "fallback",
        },
        ["<S-Tab>"] = {
            function(cmp)
                return cmp.select_prev()
            end,
            "snippet_backward",
            "fallback",
        },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          treesitter_highlighting = true,
          window = { border = "rounded" },
        },
      },

      -- Experimental signature help support
      signature = {
          enabled = true,
          window = { border = "rounded" },
      },

      snippets = { preset = 'mini_snippets' },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        -- Sat Nov 29 2025  adding lazydev to your completion providers.
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority.
            score_offset = 100,
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  -- }}}



  -- nvim-scissors {{{
  -- https://github.com/chrisgrieser/nvim-scissors
  -- Edit your VSCode style snippets.


  -- nvim-cmp {{{
  -- https://github.com/hrsh7th/nvim-cmp
  -- A completion engine for Neovim written in lua.
  --
  -- https://github.com/hrsh7th/cmp-buffer
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = { 'InsertEnter', 'CmdLineEnter' },
  --   dependencies = {
  --     'onsails/lspkind.nvim',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'f3fora/cmp-spell',
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-nvim-lsp-document-symbol',
  --     'hrsh7th/cmp-nvim-lsp-signature-help',
  --     'hrsh7th/cmp-nvim-lua',
  --     'davidsierradz/cmp-conventionalcommits',
  --     'Paterjason/cmp-conjure',
  --     "abeldekat/cmp-mini-snippets",
  --   },
  --   config = function()
  --     local cmp = require'cmp'
  --     local select_opts = { behavior = cmp.SelectBehavior.Select }
  --     local lspkind = require('lspkind')
  --     lspkind.init({
  --       mode = 'symbol_text',
  --     })
  --     cmp.setup({
  --       formatting = {
  --         fields = { "kind", "abbr", "menu" },
  --         format = function (entry, vim_item)
  --           local kind = lspkind.cmp_format({
  --             mode = "symbol_text",
  --             menu = {
  --               nvim_lsp = "[LSP]",
  --               mini_snippets = "[Snip]",
  --               nvim_lsp_signature_help = "[Sign]",
  --               nvim_lua =  "[Lua]",
  --               buffer = "[Buf]",
  --               crates = "[Crate]",
  --               path = "[Path]",
  --               git = "[Git]",
  --               conventionalcommits = "[Conv]",
  --             },
  --           })(entry, vim_item)
  --           local strings = vim.split(kind.kind, "%s", { trimempty = true })
  --           kind.kind = " " .. strings[1] .. " "
  --           return kind
  --         end
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       sources = {
  --         { name = 'conjure' },
  --         { name = "mini_snippets",
  --           option = {
  --             use_items_cache = false
  --           }
  --         },
  --         -- { name = 'nvim_lua' },
  --         -- { name = 'path' },
  --         { name = 'buffer',
  --           option = {
  --             keyword_length = 3,
  --             keyword_pattern = [[\k\+]],
  --             -- Visible buffers.
  --             get_bufnrs = function()
  --               local bufs= {}
  --               for _, win in ipairs(vim.api.nvim_list_wins()) do
  --                 bufs[vim.api.nvim_wind_get_buf(win)] = true
  --               end
  --               return vim.tbl_keys(bufs)
  --             end
  --           }
  --         },
  --         { name = 'nvim_lsp', max_item_count = 50, keyword_length = 1 },
  --         { name = 'nvim_lsp_signature_help'},
  --         -- { name = 'treesitter', max_item_count = 10 },
  --         -- { name = 'crates' },
  --       },
  --       mapping = {
  --         ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
  --         ['<Down>'] = cmp.mapping.select_next_item(select_opts),
  --
  --         ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
  --         ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
  --
  --         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-d>'] = cmp.mapping.scroll_docs(4),
  --
  --         ['<C-g>'] = cmp.mapping.abort(),
  --         ['<CR>'] = cmp.mapping.confirm({select = false}),
  --
  --         ['<Tab>'] = cmp.mapping(function(fallback)
  --           local col = vim.fn.col('.') - 1
  --
  --           if cmp.visible() then
  --             cmp.select_next_item(select_opts)
  --           elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
  --             fallback()
  --           else
  --             cmp.complete()
  --           end
  --         end, {'i', 's'}),
  --
  --         ['<S-Tab>'] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item(select_opts)
  --           end
  --         end, {'i', 's'}),
  --       },
  --     })
  --
  --     cmp.setup.filetype('gitcommit', {
  --       sources = cmp.config.sources( {
  --         { name = 'git' },
  --         { name = 'buffer' },
  --         { name = 'conventionalcommits' },
  --       })
  --     })
  --
  --   end,
  --
  -- },

  -- }}}

}

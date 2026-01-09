-- vim: nu fdm=marker

return {

  -- mason & mason-lspconfig {{{
  -- https://www.github.com/williamboman/mason.nvim
  -- https://www.github.com/williamboman/mason-lspconfig.nvim
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  -- Install and manage LSP servers with mason
  -- Use :MasonInstall <lsp server> to install LSP servers.
  {
    'williamboman/mason.nvim',
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      -- Make the border thinner.
      require("mason").setup({ ui = { border = 'single' } })

      -- Install LSP servers.
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "bashls",
          "clojure_lsp",
          "codelldb",       -- Rust debugger
          "dockerls",
          "gopls",
          "groovyls",
          "jsonls",
          "lua_ls",
          "markdown_oxide",
          "markdown_toc",
          "nimlangserver",
          "pyright",
          "rust_analyzer",
          "ruff",
          "taplo",
          "yamlls"
        }
      })

      -- Install linters/formatters and other tools.
      local mason_tool_installer = require("mason-tool-installer")
      mason_tool_installer.setup({
        ensure_installed = {
          "isort",
          "pylint",
          "ruff",
          "shellcheck",
        },
      })
    end,
  },
  -- }}}

  -- LSP client/server configuration needs to come after mason, mason-lspconfig

  -- nvim-lspconfig {{{
  -- https://github.com/neovim/nvim-lspconfig
  -- Basic client LSP configurations for Neovim.
  {
    'neovim/nvim-lspconfig',
    -- dependencies = {
    --   'hrsh7th/cmp-nvim-lsp',
    -- },
    event = 'BufReadPre',
    config = function()
      local lspconfig = require("lspconfig")
      -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(client, bufnr)
      if client.server_capabilities.signatureHelpProvider then
          require('lsp-overloads').setup(client, {
              keymaps = {
                close_signature = "C-x C-c",
              }
            })
        end

        -- Using FzfLua/Telescope for Lsp commands.
        -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      end

      -- put a box around LspInfo
      local _border = "single"
      require('lspconfig.ui.windows').default_options = {
        border = _border
      }

      -- Clojure
      -- https://clojure-lsp.io/settings/
      lspconfig.clojure_lsp.setup({
        on_attach = on_attach,
        -- capabilities = lsp_capabilities
      })

      -- Lua
      --
      lspconfig.lua_ls.setup({
        -- capabilities = lsp_capabilities,
      })

      -- Python {{{

      -- Ruff server setup
      lspconfig.ruff.setup({
        on_attach = on_attach,
        -- capabilities = lsp_capabilities,
        init_options = {
          settings = {
            logLevel = 'debug',
          }
        }
      })

      -- Pyright server setup.
      lspconfig.pyright.setup({
          on_attach = on_attach,
          -- capabilities = lsp_capabilities,
          settings = {
            disableOrganizeImports = true,
          },
          root_dir = function(fname)
            return lspconfig.util.root_pattern("pyrightconfig.json", ".git", "setup.py", "requirements.txt")(fname) or
              lspconfig.util.path.dirname(fname)
            end,
        })

        lspconfig.nim_langserver.setup({
          on_attach = on_attach,
          settings = {
            nim = {
              nimsuggestPath = "~/.nimble/bin/nimlangserver"
            }
          }
        })
      -- }}}
    end,
  },
  -- }}}

  -- tiny-code-action.nvim {{{
  -- https://github.com/rachartier/tiny-code-action.nvim
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "LspAttach",
    keys = {
      { "<leader>la",
        function()
          require("tiny-code-action").code_action()
        end,
        desc = "LSP: tiny-code-[a]ction."
      },
    },
    config = function()
      require("tiny-code-action").setup()
    end
  },
  -- }}}

  -- lsp-overloads {{{
  -- https://github.com/Issafalcon/lsp-overloads.nvim
  -- Using mainly for method overloads - shows different signaatures, this is
  -- useful for Clojure & other multi-method languages.
  --
  -- keymaps = {
  --      next_signature = "<C-j>",
  --      previous_signature = "<C-k>",
  --      next_parameter = "<C-l>",
  --      previous_parameter = "<C-h>",
  --      close_signature = "<A-s>"
  --    },
  --
  -- ** The configuration is done in on_attach function below.
  {
    'Issafalcon/lsp-overloads.nvim',
  },
  -- }}}

  -- lsp-lines {{{
  -- https://github.com/ErichDonGubler/lsp_lines.nvim
  -- Renders diagnostics using virtual lines on top of the real line of code.
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      -- remove the regular diagnostic virtual text since its just duplication.
      vim.diagnostic.config({
          virtual_text = false,
        })
      require("lsp_lines").setup()
    end,
  },
  -- }}}

  -- lspsaga {{{
  -- https://github.com/glepnir/lspsaga.nvim
  -- Highly performant LSP UI based on Neovim's built-in LSP.
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require("lspsaga").setup({
        preview = {
          lines_above = 2,
          lines_below = 12,
        },
        scroll_preview = {
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
      })
    end,
  },
  -- }}}

  -- namu.nvim {{{
  -- https://github.com/bassamsdata/namu.nvim
  -- Jump to symbols in your code w/ live-preview, fuzzy finding + others.
  {
    "bassamsdata/namu.nvim",
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        ui_select = { enable = false }, -- vim.ui.select() wrapper
        colorscheme = {
          enable = false,
          options = {
            -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
            persist = true, -- very efficient mechanism to Remember selected colorscheme
            write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
          },
        },
      })
      -- === Suggested Keymaps: ===
      vim.keymap.set("n", "<leader>ls",":Namu symbols<cr>" , {
        desc = "LSP: Jump to LSP [s]ymbol",
        silent = true,
      })
    end,
  },
  -- }}}

  -- trouble.nvim {{{
  -- A single panel for LSP Server errors & warnings.
  -- https://www.github.com/folke/trouble.nvim
  {
    'folke/trouble.nvim',
    dependencies = {"kyazdani42/nvim-web-devicons"},
    opts = {},
    cmd = "Trouble",
    keys = {
      -- {
      --   "<leader>xx",
      --   "<cmd>Trouble diagnostics toggle<cr>",
      --   desc = "Diagnostics (Trouble)",
      -- },
      -- {
      --   "<leader>xX",
      --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      --   desc = "Buffer Diagnostics (Trouble)",
      -- },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
    },
  },
  -- }}}

  {'RaafatTurki/corn.nvim'}

}

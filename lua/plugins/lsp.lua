return {

  -- lsp-overloads {{
  -- https://github.com/Issafalcon/lsp-overloads.nvim
  -- Using mainly for method overloads - shows different signaatures.
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
  -- }}

  -- nvim-lspconfig {{{
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
      if client.server_capabilities.signatureHelpProvider then
          require('lsp-overloads').setup(client, {
              keymaps = {
                close_signature = "C-x C-c",
              }
            })
        end

      local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      end

      -- put a box around LspInfo
      local _border = "single"
      require('lspconfig.ui.windows').default_options = {
        border = _border
      }

      -- Python server setup
      lspconfig.pyright.setup({
          on_attach = on_attach,
          root_dir = function(fname)
            return lspconfig.util.root_pattern("pyrightconfig.json", ".git", "setup.py", "requirements.txt")(fname) or
              lspconfig.util.path.dirname(fname)
            end,
        })
    end,
  },
  -- }}}

  -- lsp-lines {{{
  -- https://github.com/ErichDonGubler/lsp_lines.nvim
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

  -- mason & mason-lspconfig {{{
  -- Install and manage LSP servers with mason
  -- https://www.github.com/williamboman/mason.nvim
  -- https://www.github.com/williamboman/mason-lspconfig.nvim
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
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
          ensure_installed = { "clojure_lsp", "nimls", "pyright", "rust_analyzer" }
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

  -- trouble.nvim {{{
  -- A single panel for LSP Server errors & warnings.
  -- https://www.github.com/folke/trouble.nvim
  {
    'folke/trouble.nvim',
    dependencies = {"kyazdani42/nvim-web-devicons"},
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
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

}

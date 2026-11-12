-- vim: nu fdm=marker

return {

  -- nvim-lspconfig {{{
  -- https://github.com/neovim/nvim-lspconfig
  -- Basic client LSP configurations for Neovim.
  -- Any changes that we add/override go in nvim/lsp/<server>.lua
  --
  -- Put a file in after/lsp/<server>.lua to override/modify settings.
  --
  -- NOTE: Config is here so that mason/mason-lspconfig pick up lspconfig.
  { 'neovim/nvim-lspconfig' },
  -- }}}

  -- mason.nvim {{{
  -- https://www.github.com/williamboman/mason.nvim
  -- Allows you to easily manage external editor tooling such as LSP servers,
  -- DAP servers, linters, formatters, etc.
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = 'single',
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  -- }}}

  -- mason-lspconfig {{{
  -- https://www.github.com/williamboman/mason-lspconfig.nvim
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {},
  },
  -- }}}

  -- mason-tool-installer {{{
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  -- Install language-servers/linters/formatters and other tools.
  {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = {
        "basedpyright",
        "bashls",
        "clojure_lsp",
        "dockerls",
        "gopls",
        "groovyls",
        "isort",
        "jsonls",
        "lua_ls",
        "markdown-oxide",
        "nimlsp",
        "rust_analyzer",
        "shellcheck",
        "taplo",
        "ty",
        "yamlls"
        }
      }
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

  -- namu.nvim {{{
  -- https://github.com/bassamsdata/namu.nvim
  -- Jump to symbols in your code w/ live-preview, fuzzy finding + others.
  {
    "bassamsdata/namu.nvim",
    cmd = "Namu",
    main = "namu",
    opts = {
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
      },
      keys = {
        {
          "<leader>ls",
          ":Namu symbols<cr>" ,
          desc = "LSP: Jump to LSP [s]ymbol",
          silent = true
      },
      {
        "<leader>lw",
        ":Namu workplace<cr>",
        desc="LSP: Jump to workplace LSP symbols.",
        silent=true
      },
    },
  },
  -- }}}

}

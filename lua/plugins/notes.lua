-- For notes, scratch and related plugins
return {

  -- obsidian.nvim {{{
  -- https://github.com/epwalsh/obsidian.nvim
  --
  -- :ObsidianOpen
  -- :ObsidianNew
  -- :ObsidianQuickSwitch
  -- :ObsidianBacklinks
  -- :ObsidianTags
  -- :ObisidianSearch
  -- :ObsidianLinkNew
  -- :ObsidianToggleCheckbox
  -- :ObsidianRename
  -- :ObsidianTOC
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "ReferenceVault",
            path = "~/Vaults/ReferenceVault/",
          },
          {
            name = "HPEVault",
            path = "~/WorkStuff/hpe_home/HPEVault/",
          },
        },

      -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
      -- way then set 'mappings = {}'.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
      },
    })
  end,
  },
  -- }}}

  -- scratch.nvim {{{
  -- https://github.com/LintaoAmons/scratch.nvim
  -- Create temporary files.
  {
    'LintaoAmons/scratch.nvim',
    event = "VeryLazy",
    dependencies = {
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("scratch").setup({
        scratch_file_dir = "~/WorkStuff/hpe_home",
        window_cmd = "rightbelow vsplit",
        use_telescope = false,
        file_picker = "fzf_lua",
        filetypes = { "md" },
      })
    end,
    keys = {
      { "<leader>cr", ":Scratch<cr>", mode = {"n"}, desc = "Create new scratch file in scratch_file_dir" },
      { "<leader>cn", ":ScratchWithName<cr>", mode = {"n"}, desc = "Create new scratch file w/ name." },
      { "<leader>cf", ":ScratchOpenFzf<cr>", mode = {"n"}, desc = "Use fzf to open scratch file." },
    },
  },
  -- }}}


}

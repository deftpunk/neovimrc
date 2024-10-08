-- vim: nu fdm=marker

return {

  -- telescope-import.nvim {{{
  -- https://github.com/piersolenski/telescope-import.nvim
  -- Import modules/packages
  {
    'piersolenski/telescope-import.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
      require("telescope").load_extension("import")
    end
  },
  -- }}}

  -- telescope-undo.nvim {{{
  -- https://github.com/debugloop/telescope-undo.nvim
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>u",
        "<cmd>Telescope undo<cr>",
        silent = true,
        desc = "undo history",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },
  -- }}}

  -- telescope-heading.nvim {{{
  -- https://github.com/crispgm/telescope-heading.nvim
  -- Headings for Markdown, Restructured Text & help files.
  {
    "crispgm/telescope-heading.nvim",
    opts = {
      extensions = {
        heading = {
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.8,
            preview_width = 0.5,
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension('heading')
    end,
  },
  -- }}}


}

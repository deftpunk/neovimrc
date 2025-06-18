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

  -- telescope-lazy-plugins.nvim {{{
  -- https://github.com/polirritmico/telescope-lazy-plugins.nvim
  -- Quickly access the configuration of plugins managed by lazy
  {
    "polirritmico/telescope-lazy-plugins.nvim",
    keys = {
      {
        "<leader>hc",
        ":Telescope lazy_plugins<cr>",
        mode = {"n"},
        silent = true,
        desc = "Access the configuration of plugins."
      },
    },
    config = function()
      require("telescope").load_extension("lazy_plugins")
    end
  },
  -- }}}

  -- telescope-hierarchy.nvim {{{
  -- https://github.com/jmacadie/telescope-hierarchy.nvim
  -- :Telescope hierarchy incoming_calls opens a Telescope window. It finds all
  -- incoming calls (i.e. other functions) of the function under the current
  -- cursor. Recursive searches are only done on request when the function node
  -- is first attempted to be expanded.
  --
  -- :Telescope hierarchy outgoing_calls will do the same but in the other
  -- direction, so find the definition location of all functions the current
  -- function calls.
  --
  -- Don't worry about committing to the right 'direction', the plugin can also
  -- toggle the direction it is looking in whilst the Telescope session is
  -- running. This means switching from functions that call the current
  -- function to functions the current function calls (incoming -> outgoing)
  -- and vice versa. See below in the keymaps for how to do this.
  --
  -- The finder window is opened in normal mode, since filtering the results
  -- tree doesn't make much sense.
  --
  -- The following keymaps are set:
  -- Key 	Action
  -- e, l or → 	Expand the current node: this will recursively find all
  -- incoming calls of the current node. It will only go the next level deep
  -- though
  --
  -- c, h or ← 	Collapse the current node: the child calls are still found,
  -- just hidden in the finder window
  --
  -- E 	Expand the current node 5 layers: Like e but will go through up to 5
  -- layers recursively. This could in theory be adapted to any depth you want,
  -- see expand_all_to() in actions
  --
  -- t 	Toggle the expanded state of the current node
  --
  -- s 	Switch the direction of the Call hierarchy and toggle between incoming
  -- and outgoing calls
  --
  -- d 	Goto the definition of the current node, not the place it is being
  -- called, which is what Telescope shows
  --
  -- CR 	Navigate to the function call shown
  --
  -- q or ESC 	Quit the Telescope finder
  {
    "jmacadie/telescope-hierarchy.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>li",
        "<cmd>Telescope hierarchy incoming_calls<cr>",
        desc = "LSP: Search [i]ncoming calls.",
      },
      {
        "<leader>lo",
        "<cmd>Telescope hierarchy outgoing_calls<cr>",
        desc = "LSP: Search [o]utgoing calls.",
      },
    },
    config = function(_,opts)
      require("telescope").setup(opts)
      require("telescope").load_extension('hierarchy')
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

  -- telescope-git-file-history.nvim {{{
  -- https://github.com/isak102/telescope-git-file-history.nvim
  {
    "isak102/telescope-git-file-history.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "tpope/vim-fugitive"
    },
    config = function(_, opts)
      require("telescope").load_extension("git_file_history")
    end,
  },
  -- }}}

  -- }}}


}

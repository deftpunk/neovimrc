-- vim: nu fdm=marker

return {

  -- tokyonight colorscheme {{{
  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      -- Lighten the comments so that I can see them better.
      on_colors = function(colors)
        colors.comment = "#7982ab"
      end
    }
  },
  -- }}}

  -- lualine {{{
  -- Use lualine & tabline together to get a faster airline.
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          -- theme  = 'evil_lualine',
          theme  = 'tokyonight',
          always_show_tabline = true,
        },
        sections = {
          lualine_a = {
            'tabs',
            tab_max_length = 50,
            mode = 2,
          },
          -- lualine_b = ...
          lualine_c = {
              { "filename", path = 1 },
              {
                  require("nvim-possession").status,
                  cond = function()
                      return require("nvim-possession").status() ~= nil
                  end,
              },
          },
        },
        tabline = {
          lualine_a = {'tabs'},
          lualine_b = {'buffers'},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      }
    end,
  },
  -- }}}

  -- vim-active-numbers {{{
	-- https://github.com/AssailantLF/vim-active-numbers
  -- Only turn on line numbers in the active window.
	{
    'AssailantLF/vim-active-numbers',
    config = function()
      vim.g.active_number = 1
      vim.g.actnum_exclude = { "help", "neo-tree", "DiffviewFiles", "DiffviewFilePanel", "fugitive", "iron", "terminal", "lazy" }
    end,
  },
  -- }}}

  }

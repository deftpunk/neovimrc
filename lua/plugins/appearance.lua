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
          theme  = 'tokyonight',
        },
        sections = {
          -- lualine_a = ...
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
      }
    end,
  },
  -- }}}

  --tabby.nvim {{{
  {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.o.showtabline = 2  -- always display the tabline.
      require('tabby').setup({
        lualine_theme = 'tokyonight',
        nerdfront = true,
      })
    end,
  },
  -- }}}

  -- tabline {{{
  -- https://github.com/kdheepak/tabline.nvim
  -- {
  --   'kdheepak/tabline.nvim',
  --   config = function()
  --     require'tabline'.setup {
  --       -- Defaults configuration options
  --       enable = true,
  --       options = {
  --         -- If lualine is installed tabline will use separators configured in lualine by default.
  --         -- These options can be used to override those settings.
  --         max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
  --         show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
  --         show_devicons = true, -- this shows devicons in buffer section
  --         show_bufnr = false, -- this appends [bufnr] to buffer section,
  --         show_filename_only = false, -- shows base filename only instead of relative path in filename
  --         modified_icon = "+ ", -- change the default modified icon
  --         modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
  --       }
  --     }
  --     vim.cmd[[
  --     set guioptions-=e " Use showtabline in gui vim
  --     set sessionoptions+=tabpages,globals " store tabpages and globals in session
  --     ]]
  --   end,
  --   dependencies = {
  --     'nvim-lualine/lualine.nvim',
  --     'kyazdani42/nvim-web-devicons',
  --   },
  -- },
  -- }}}

	-- Beacon {{{
	-- Highlight where your cursor is when you move around.
	-- https://github.com/DanilaMihailov/beacon.nvim
  -- {
  --   'DanilaMihailov/beacon.nvim'
  -- },
  -- }}}

  -- vim-active-numbers {{{
	-- https://github.com/AssailantLF/vim-active-numbers
  -- Only turn on line numbers in the active window.
	{
    'AssailantLF/vim-active-numbers',
    config = function()
      vim.g.active_number = 1
      vim.g.actnum_exclude = { "help", "neo-tree", "fugitive", "terminal", "lazy" }
    end,
  },
  -- }}}

  }

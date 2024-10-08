return {

  -- headlines {{{
  -- https://github.com/lukas-reineke/headlines.nvim
  --   Background highlighting for headlines
  --   Background highlighting for code blocks
  --   Whole window separator for horizontal line
  --   Bar for Quotes
  {
      'lukas-reineke/headlines.nvim',
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = true, -- or `opts = {}`
  },
  -- }}}
  --
  -- mdpreview.nvim {{{
  -- https://github.com/mrjones2014/mdpreview.nvim
  -- Preview Markdown in Neovim buffer using glow.
  --
  -- :Mdpreview opens preview window.
  -- :Mdpreview! closes preview window. =q= in the window also closes it.
  {
    'mrjones2014/mdpreview.nvim',
    ft = 'markdown', -- you can lazy load on markdown files only
    -- requires the `terminal` filetype to render ASCII color and format codes
    dependencies = { 'norcalli/nvim-terminal.lua', config = true },
  },
  -- }}}

  -- markdown.nvim {{{
  -- https://github.com/tadmccorkle/markdown.nvim
  -- Adds keybindings for navigating, table of contents, lists, links inside a markdown file, e.g.
  -- }}}
}

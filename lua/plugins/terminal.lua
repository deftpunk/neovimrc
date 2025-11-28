return {

  -- TODO: There is also NeoTerm & others

  -- toggleterm.nvim {{{
  -- https://github.com/akinsho/toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({
          winbar = {
            enabled = true,
            name_formatter = function(term) return term.name end,
          },
        })
    end,
  },
  -- }}}


}

return {

  -- headlines {{{
  -- https://github.com/lukas-reineke/headlines.nvim
  --   Background highlighting for headlines
  --   Background highlighting for code blocks
  --   Whole window separator for horizontal line
  --   Bar for Quotes
  -- {
  --     'lukas-reineke/headlines.nvim',
  --     dependencies = "nvim-treesitter/nvim-treesitter",
  --     config = true, -- or `opts = {}`
  -- },
  -- }}}

  -- install without yarn or npm
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function()
        require("lazy").load({ plugins = { "markdown-preview.nvim" } })
        vim.fn["mkdp#util#install"]()
      end,
      config = function()
        vim.cmd([[
          function OpenMarkdownPreview (url)
            execute "silent ! open -a Firefox -n --args --new-window " . a:url
          endfunction
          let g:mkdp_browserfunc = "OpenMarkdownPreview"
        ]])
      end,
      -- TODO: Is mp a mapped key in markdown-plus?
      keys = {
          {
            "<leader>mp",
            ft = "markdown",
            "<cmd>MarkdownPreviewToggle<cr>",
            desc = "Markdown Preview",
          },
        },
  },

  -- markdown-plus {{{
  -- https://github.com/YousefHadder/markdown-plus.nvim
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
    config = function()
      require("markdown-plus").setup({
        enabled = true,
        callouts = {
          custom_types = { "WARNING", "DEBUG", "TODO", "IMPORTANT" },
        },
      })
    end,
  },
  -- }}}

  --render-markdown.nvim
  --https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
  },
}

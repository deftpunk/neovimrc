-- For notes, scratch and related plugins
return {

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

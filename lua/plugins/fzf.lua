return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local actions = require "fzf-lua.actions"
      require("fzf-lua").setup({
        winopts = {
          -- The bat_native previewer is a lot faster.
          preview = { default = 'bat_native' },
        },
        -- TODO: Not picking up tokyonight colors??
        fzf_colors = true,
        files = {
          actions = {
            -- I can use C-i to select multiple files and then open them w/
            -- <enter> as opposed to the default going to the quicklist first.
            ["enter"] = actions.file_edit,
          },
        },
      })
    end,
    keys = {
      { "<leader>dd", ":FzfLua diagnostics_document<cr>", mode = {"n"}, desc = "Show the diagnostics (errors, warnings, etc.) for the current buffer." },
      { "<leader>dw", ":FzfLua diagnostics_workspace<cr>", mode = {"n"}, desc = "Show the diagnostics (errors, warnings, etc.) for the workspace." },
      -- File,directory,windows,tabs
      { "<leader>ft", ":FzfLua tabs<cr>", mode = {"n"}, desc = "Pick from the available tabs." },
    },
  },

}

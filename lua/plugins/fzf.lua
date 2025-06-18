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
        -- Picking up tokyonight colors.
        -- Installed and added https://github.com/0xTadash1/bat-into-tokyonight?tab=readme-ov-file to the bat config file - ~/.config/bar/config
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
      { "<leader>ff", ":FzfLua files<cr>", mode = {"n"}, desc = "FzfLua find files." },
      { "<leader>fo", ":FzfLua oldfiles<cr>", mode = {"n"}, desc = "FzfLua find recent files." },
      { "<leader>ft", ":FzfLua tabs<cr>", mode = {"n"}, desc = "FzfLua pick from the available tabs." },
      { "<leader>i", ":FzfLua buffers<cr>", mode = {"n"}, desc = "FzfLua pick from the available open buffers." },
      { "<D-i>", ":FzfLua buffers<cr>", mode = {"n"}, desc = "FzfLua pick from the available open buffers." },
      -- Help
      { "<leader>hh", ":FzfLua command_history<cr>", mode = {"n"}, desc = "FzfLua run from command history." },
      { "<leader>hm", ":FzfLua manpages<cr>", mode = {"n"}, desc = "FzfLua choose Man pages." },
      { "<leader>ht", ":FzfLua helptags<cr>", mode = {"n"}, desc = "FzfLua choose Help tags." },
      -- Search
      { '<leader>r', "<cmd>lua require('fzf-lua').grep()<CR>", silent = true, desc = "FzfLua ripgrep the current project." },
      -- { '<leader>s', "<cmd>lua require('fzf-lua').blines()<CR>", silent = true, desc = "FzfLua search lines in buffer." },
      { '<leader>s', ":FzfLua grep_curbuf<cr>", mode = {"n"}, silent = true, desc = "FzfLua search lines in buffer." },
      -- Resume last command
      { '<leader>fr', "<cmd>lua require('fzf-lua').resume()<cr>", silent = true, desc = "Resume FzfLua." },
    },
  },

}

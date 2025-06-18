return {

  -- agitator.nvim {{{
  -- https://github.com/emmanueltouzery/agitator.nvim
  -- Works well with Neogit & Diffview
  -- Supplies the following functionality:
  --   - side-by-side full file blame
  --   - timemachine
  {
    'emmanueltouzery/agitator.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      -- Toggle a side-by-side blame buffer - modify the format to show the short summary.
      { "<leader>gb", function() require('agitator').git_blame_toggle({ sidebar_width=35, formatter=function(r)
          local default_row = string.format('%02d-%02d-%02d %s', r.date.year, r.date.month, r.date.day, r.author)
          return default_row .. " => " .. r.summary; end}) end, desc = "Toggle a side-by-side git buffer blame." },
      { "<leader>gd",
        function()
          local commit_sha = require"agitator".git_blame_commit_for_line()
          vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
        end,
        desc = "Display the commit for the current line of code." },
    },
  },
  -- }}}

  -- advanced-git-search.nvim {{{
  -- https://github.com/aaronhallaert/advanced-git-search.nvim
  -- Search your git history by commit message, content and author in Neovim
  --   1. Search in repo log content
  --   2. Search in file log content
  --   3. Diff current file w/ commit
  --   4. Diff current file w/ selected line history.
  --   5. Diff file w/ branch
  {
    'aaronhallaert/advanced-git-search.nvim',
    cmd={ "AdvancedGitSearch" },
    config = function()
      require('advanced_git_search.fzf').setup({
        diff_plugin= "diffview",
      })
    end,
    dependencies={
      -- Gbrowse is a dependency.
      "tpope/vim-fugitive",
      -- View commits in browser.
      "tpope/vim-rhubarb",
      -- Use the diffview diff instead of the fugitive one.
      "sindrets/diffview.nvim",
    },
    keys = {
      { "<leader>ga", ":AdvancedGitSearch<cr>", mode = {"n"}, desc = "Advanced search of git log, commit & file content." },
    },
  },
  -- }}}

  -- diffview.nvim {{{
  -- https://github.com/sindrets/diffview.nvim
  -- Make diffs much better, not just visually.
  -- There are actions, hooks, modes and mode keymaps...
  --
  -- 'git log' equivalent -> :DiffviewFileHistory %
  {
    'sindrets/diffview.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function ()
      require("diffview").setup({
        view = {
          default = {
            winbar_info = true,
          },
          merge_tool = {
            layout = "diff4_mixed",
          },
        },
        file_panel = {
          win_config = {
            width = 45,
          },
        },
      })
    end
  },
  -- }}}

  -- gh.nvim {{{
  -- https://github.com/ldelossa/gh.nvim
  -- Interactive review of PRs on GitHub.
  {
      "ldelossa/gh.nvim",
      dependencies = {
          {
          "ldelossa/litee.nvim",
          config = function()
              require("litee.lib").setup()
          end,
          },
      },
      config = function()
          require("litee.gh").setup()
      end,
  },
  -- }}}

  -- neogit {{{
  -- https://github.com/TimUntersberger/neogit
  -- A kind of magit clone
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('neogit').setup({
        kind = "split_above_all",
        graph_style = "unicode",
        -- disable_commit_confirmation = true,
        integrations = {
          diffview = true,
          fzf_lua =true,
        },
        commit_editor = {
          kind = "vsplit",
        },
        -- Debug console.
        auto_share_console = true,
        -- auto_close_console = false, -- will leave any command output open.
      })

    end,
    keys = {
      { "<leader>gg", ":Neogit<cr>", mode = {"n"}, desc = "Neogit" },
    },
  },
  -- }}}

  -- git-blame.nvim {{{
  -- https://github.com/f-person/git-blame.nvim
  -- Show a blame message for the line as well as some other useful commands.
  --
  -- :GitBlameToggle toggles git blame on/off,
  -- :GitBlameCopySHA copies the SHA hash of current line's commit into the system's clipboard.
  -- :GitBlameCopyCommitURL copies the commit URL of current line's commit into the system clipboard.
  -- :GitBlameOpenFileURL opens the file in the default browser.
  --
  -- :GitBlameCopyFileURL WE DON'T USE THIS ONE BECAUSE repolink.nvim provides a URL for selections as well.
  --
  -- TODO: set some of the config variables, e.g. use a different highlight group.
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      -- For some reason this works but opts = { enabled = false } DOESNT?
      vim.cmd[[
        let g:gitblame_enabled = 0
      ]]
      require('gitblame').setup()
    end,
    keys = {
      { "<leader>tb", ":GitBlameToggle<cr>", desc = "Toggle the inline blame." },
      { "<leader>gl", ":GitBlameCopyFileURL<cr>", desc = "Copy the File URL to clipboard." },
      { "<leader>gc", ":GitBlameCopyCommitURL<cr>", desc = "Copy the Commit URL to clipboard." },
      { "<leader>gof", ":GitBlameOpenFileURL<cr>", desc = "Open file URL in browser." },
      { "<leader>goc", ":GitBlameOpenCommitURL<cr>", desc = "Open commit Sha URL in browser." },
      { "<leader>gs", ":GitBlameCopySHA<cr>", desc = "Copy current line's SHA in clipboard." },
    },
  },
  -- }}}

  -- gitgraph.nvim {{{
  -- https://github.com/isakbm/gitgraph.nvim
  -- View a git graph of the current repo.
  {
    'isakbm/gitgraph.nvim',
    dependencies = {
      'sindrets/diffview.nvim',
    },
    opts = {
      symbols = {
        merge_commit = 'M',
        commit = '*',
      },
      format = {
        timestamp = '%H:%M:%S %d-%m-%Y',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      hooks = {
        -- Use Diffview
        -- Check diff of a commit.
        on_select_commit = function(commit)
          vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
          vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
          vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        end,
      },
    },
    keys = {
      { "<leader>gr",
        function()
          require('gitgraph').draw({}, { all = false, max_count = 1000 })
        end,
        desc = "GitGraph - Draw just this branch.",
      },
      { "<leader>gR",
        function()
          require('gitgraph').draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
    symbols = {
      merge_commit = '',
      commit = '',
      merge_commit_end = '',
      commit_end = '',

      -- Advanced symbols
      GVER = '',
      GHOR = '',
      GCLD = '',
      GCRD = '╭',
      GCLU = '',
      GCRU = '',
      GLRU = '',
      GLRD = '',
      GLUD = '',
      GRUD = '',
      GFORKU = '',
      GFORKD = '',
      GRUDCD = '',
      GRUDCU = '',
      GLUDCD = '',
      GLUDCU = '',
      GLRDCL = '',
      GLRDCR = '',
      GLRUCL = '',
      GLRUCR = '',
    },
  },
  -- }}}

  -- gitsigns.nvim {{{
  -- https://github.com/lewis6991/gitsigns.nvim
  -- Super fast git decorations.
  -- Integrates with vim-fugitive, repeat (repeat) staging, trouble.nvim
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()

      -- Traverse different change hunks.
      local prev_hunk = function()
        require("gitsigns").prev_hunk({ navigation_message = false })
        vim.cmd([[normal! zz]])
      end
      vim.keymap.set("n", "gk", prev_hunk)

      local next_hunk = function()
        require("gitsigns").next_hunk({ navigation_message = false })
        vim.cmd([[normal! zz]])
      end
      vim.keymap.set("n", "gj", next_hunk)

      require('gitsigns').setup {
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_formatter = '<author>@<author_time:%Y-%m-%d>: <summary>',
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
      }
    end,
  },
  -- }}}

  -- git-messenger {{{
  -- https://github.com/rhysd/git-messenger.vim
  -- View commit info @ line in a popup window.
  -- Popup window mappings
  -- ================================
  -- q	Close the popup window
  -- o	older. Back to older commit at the line
  -- O	Opposite to o. Forward to newer commit at the line
  -- d	Toggle unified diff hunks only in current file of the commit
  -- D	Toggle all unified diff hunks of the commit
  -- r	Toggle word diff hunks only in current file of the commit
  -- R	Toggle all word diff hunks of current commit
  -- ?	Show mappings help
  -- TODO: Thu Jan 30 2025 15:54:26 - check https://github.com/lsig/messenger.nvim .  Move if it matches functionality.
  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.cmd[[
        let g:git_messenger_no_default_mappings=v:true
        let g:git_messenger_always_into_popup=v:true
        let g:git_messenger_include_dir="current"
        let g:git_messenger_floating_win_opts = { 'border': 'single'}
        let g:git_messenger_popup_content_margins = v:false
      ]]
    end,
    keys = {
      { "<leader>gm", ":GitMessenger<cr>", mode = {'n'}, desc = "GitMessenger" },
    },
  },
  -- }}}

  -- octo.nvim {{{
  -- https://github.com/pwntester/octo.nvim
  -- Edit GitHub issues and PRs
  -- Add/Modify/Delete comments
  -- Add/Remove label, reactions, assignees, project cards, reviewers, etc.
  -- Add Review PRs
  -- * NEEDS GitHub CLI installed *
  -- TODO: bindings for Octo
  --
  -- Tue Feb 18 2025 16:58:21
  -- Pinning to a specific commit since octo.nvim + gh have updated but HPE hasn't updated the version.
  -- https://github.com/pwntester/octo.nvim/issues/685
  {
    'pwntester/octo.nvim',
    commit = 'f09ff9413652e3c06a6817ba6284591c00121fe0',
    pin = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    cmd = 'Octo',
    config = function() require('octo').setup() end,

  },
  -- }}}

  {
    'fredeeb/tardis.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
},

}

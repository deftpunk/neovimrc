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
  },
  -- }}}

  -- git-blame.nvim {{{
  -- https://github.com/f-person/git-blame.nvim
  -- Show a blame message for the line as well as some other useful commands.
  --
  -- :GitBlameOpenCommitURL opens the commit URL of commit under the cursor.
  -- Tested to work with GitHub and GitLab.
  --
  -- :GitBlameToggle toggles git blame on/off,
  -- :GitBlameCopySHA copies the SHA hash of current line's commit into the system's clipboard.
  -- :GitBlameCopyCommitURL copies the commit URL of current line's commit into the system clipboard.
  -- :GitBlameOpenFileURL opens the file in the default browser.
  -- :GitBlameCopyFileURL copies the file URL into the system clipboard.
  --
  -- TODO: set some of the config variables, e.g. use a different highlight group.
  {
    "f-person/git-blame.nvim",
    config = function()
      require('gitblame').setup{}
    end,
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
      { "<leader>gh",
        function()
          require('gitgraph').draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
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
  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.cmd[[
        let g:git_messenger_always_into_popup=v:true
        let g:git_messenger_include_dir="current"
        let g:git_messenger_floating_win_opts = { 'border': 'single'}
        let g:git_messenger_popup_content_margins = v:false
      ]]
    end,
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
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    cmd = 'Octo',
    config = function() require('octo').setup() end,
  },
  -- }}}

}

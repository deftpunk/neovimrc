-- vim: nu fdm=marker

-- init.lua based on lazy.

-- External dependencies {{{
--   brew install gnu-sed
--   git
--   GitHub CLI
-- }}}

-- Some notes {{{

-- Run without sources config/plugins/etc.
-- $ nvim --clean

-- }}}

require('core/options')     -- Options
require('core/autocmds')    -- Autocommands
require('core/lazy')        -- Using lazy.nvim as package management - sets 'plugins' directory to get plugins.
require('core/colorscheme')
require('core/keymaps')
require('core/abbreviations')

-- vim-activenumbers doesn't recognize trouble buffer type so doing
-- this workaround instead.
-- NOTE: Need to figure out how to make the "jigger" of window when
--        switching windows.
local filetypes = { "", "trouble" }
local num_group = vim.api.nvim_create_augroup("ActiveWindowLineNumbers", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = num_group,
  callback = function()
    -- Exclude special buffers like terminals, file trees, or popups
    if vim.list_contains(filetypes, vim.bo.buftype) then
    -- if vim.bo.buftype == "" then
      vim.opt_local.number = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = num_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- global bookmarks: https://github.com/LintaoAmons/bookmarks.nvim

-- TODO: Investigate (nvr) https://github.com/mhinz/neovim-remote
-- if [[ ! -z "$NVIM" ]]; then
--     # Use neovim-remote to avoid nested nvim
--     VI_EDITOR="$(command -v nvr)"
--     alias vi="$VI_EDITOR"
--     alias vim="$VI_EDITOR"
-- fi

-- Can gx.nvim combine with -> https://github.com/icholy/lsplinks.nvim

-- https://github.com/rgroli/other.nvim
--   - open alternate files associated w/ current buffer.

-- File/Project/bookmark & such navigation:
-- https://github.com/otavioschwanck/arrow.nvim
--   - better(?) than harpoon2
--
-- https://github.com/cbochs/grapple.nvim + https://github.com/cbochs/portal.nvim

-- https://github.com/stevearc/oil.nvim

-- TODO: neoscroll
-- goto-preview
-- TODO: snippets
-- TODO: auto-session + fzf-lua+possession
-- TODO: vim-repeat
-- TODO: rainbow parenthesis
-- TODO: scrap.nvim to replace vim-abolish - https://github.com/prescientmoon/scrap.nvim
-- TODO: Splitting & joining
-- https://dotfyle.com/plugins/AckslD/nvim-trevJ.lua
-- https://github.com/Wansmer/treesj
-- TODO: Wansmer/treesj - splitting/joining plugin
-- TODO: thethethe - a better vim-abolish
-- TODO: neogen - docstring/annotation for Python
-- TODO: smartsplits
-- https://github.com/mrjones2014/smart-splits.nvim
-- TODO: nvim-lint
-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file
-- TODO: LineDiff: AndrewRadev/linediff.vim
-- TODO: Delete surrounding function call: https://github.com/AndrewRadev/dsf.vim
-- TODO: Navigation between Tmux & editor.
-- https://github.com/rafi/vim-config/blob/master/lua/rafi/plugins/editor.lua#L19
-- TODO: A better window picker?: https://github.com/s1n7ax/nvim-window-picker
-- Another one: https://github.com/ten3roberts/window-picker.nvim
-- TODO: http REST client:
--         rest-nvim/rest.nvim'
--
-- https://github.com/gbprod/yanky.nvim
--
-- winbar/breadcrumbs:
-- https://dotfyle.com/plugins/SmiteshP/nvim-navic
-- https://github.com/utilyre/barbecue.nvim
-- https://dotfyle.com/plugins/Bekaboo/dropbar.nvim
--
-- Telescope:
-- https://github.com/debugloop/telescope-undo.nvim
-- https://github.com/piersolenski/telescope-import.nvim
-- https://github.com/dhruvmanila/browser-bookmarks.nvim
-- https://github.com/crispgm/telescope-heading.nvim

-- Investigate: {{{
--
-- https://github.com/haya14busa/vim-edgemotion

-- improvement on Trouble.nvim?
-- https://github.com/kevinhwang91/nvim-bqf

-- https://github.com/nanozuki/tabby.nvim as tabline alternative.
--
-- markdown:
-- mzlogin/vim-markdown-toc

-- terminals:
-- https://github.com/nyngwang/NeoTerm.lua/
-- https://github.com/NvChad/nvterm
--
-- Source Control (git):

-- split resizing and navigation

-- Different autosave plugins
-- Looking for something that doesn't break undo/redo.
-- https://github.com/aidenlangley/auto-save.nvim
-- https://github.com/Pocco81/auto-save.nvim

-- Should I ever have the need for guessing indentation
-- nmac427/guess-indent.nvim
-- }}}

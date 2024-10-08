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

-- Scratch pad: https://github.com/LintaoAmons/scratch.nvim
-- global bookmarks: https://github.com/LintaoAmons/bookmarks.nvim

-- Task running
-- https://github.com/catgoose/do-the-needful.nvim
--   - requires Tmux

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
-- TODO: Software languages
-- TODO: LSP + mason + cmp + etc.
-- goto-preview
-- lsp_signature -> comes along w/ cmp
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
-- TODO: http REST client: rest-nvim/rest.nvim'
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
--
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
-- https://github.com/ruifm/gitlinker.nvim
--
-- split resizing and navigation

-- Different autosave plugins
-- Looking for something that doesn't break undo/redo.
-- https://github.com/aidenlangley/auto-save.nvim
-- https://github.com/Pocco81/auto-save.nvim

-- Should I ever have the need for guessing indentation
-- nmac427/guess-indent.nvim
-- }}}

--
-- DONE: Tried out tardis.nvim -> not an improvement over other plugins.
-- DONE: Tried out SuperBo/fugit2.nvim
--       - very fast
--       - installation was a pain, had to create /usr/local/opt/lib, copy libgit2.dynlib into despite using the libgit2_path option under opts
--       - the GitHub integration with tiny-git didn't work
--       - fewer features than Neogit

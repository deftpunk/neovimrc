-- Some sensible defaults

-- Leader & localleader
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Folding
-- These values are set for nvim-ufo.
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 250 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
-- Setting to true will close all folds.
-- vim.o.foldenable = true

-- the last windwow will show the statusline if there are at least two windows.
vim.o.laststatus = 1
-- FIX: this is causing an issue for some reason
-- vim.o.fillchars:append { eob = "~" }
vim.o.showtabline = 2  -- always display the tabline.

vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.showmode = false

-- Backups
vim.o.backup = true
vim.o.backupdir = vim.fn.expand("~/.config/nvim/.backups")
vim.o.swapfile = true
vim.o.directory = vim.fn.expand("~/.config/nvim/.swapfiles")
vim.o.wildignore = "*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*.ali"

-- Shada + shada file
-- Command line, search string, input-line history; marks, contents of non-empty registers, etc.
vim.o.shada = "!,'1000,<100,s100,h,f1"
vim.o.shadafile = vim.fn.expand("~/.config/nvim/.shada")

vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.undofile = true
vim.o.incsearch = true
-- Set hlsearch to true so that vim-cool works.
vim.o.hlsearch = true
vim.o.hidden = true
vim.o.completeopt = "menu,menuone,noselect"
vim.o.listchars = "trail:•,extends:❯,precedes:❮"
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

if vim.g.neovide then
  -- this one almost makes the gap in indent-blankline.nvim characters go away.
  -- the gap is function of the font and the OS window manager; most terminals
  -- automatically patch the fonts to make it look better.
  -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/422
  vim.o.guifont="JetBrainsMono Nerd Font:h12"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.print(vim.g.neovide_version)
else
  vim.opt.guifont='MesloLGM_Nerd_Font_Mono:h14:b:i:u:s'
end

-- disable providers that we don't need/use.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Show colored columns so I know how far I've typed without looking down at the
-- statusline all the time.
-- Changed the last column to 100 as Clojure, Common Lisp & Rust use that as a
-- max column length guide.
-- Added 180 because that is the max column for HPE Python code.
vim.opt.colorcolumn={'80', '100', '180'}
vim.opt.cursorline = true

-- copy/paste from clipboard
vim.o.clipboard='unnamedplus'

-- Some env variables
-- Do 'pip install neovim-remote' to install nvr
vim.env.VISUAL = 'nvr -cc split --remote-wait'
vim.env.PYTHONUNBUFFERED = 1
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- This is for nvim-possession and scope.nvim -> see utilities.lua
vim.opt.sessionoptions = { -- required
  "blank",
  "buffers",
  "tabpages",
  "globals",
  "curdir",
  "terminal",
  "winsize",
  "help",
}

-- Fri Apr 28 2023 11:10:41 -> put this in to try and get undercurl properly working on iTerm
vim.cmd([[
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
  ]])

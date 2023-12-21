-- Some sensible defaults
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.errorbells = false
vim.opt.smartcase = true
vim.opt.showmode = false
vim.bo.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.completeopt = {'menu','menuone','noselect'}
vim.opt.listchars:append('trail:•,extends:❯,precedes:❮')
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

if vim.g.neovide then
  vim.o.guifont="Meslo Nerd Font:h10"
  vim.g.neovide_remember_window_size = true
end

-- vim.opt.guifont='RobotoMono_Nerd_Font:h14:b:i:u:s'
vim.opt.guifont='MesloLGM_Nerd_Font_Mono:h14:b:i:u:s'
-- Show colored columns so I know how far I've typed without looking down at the
-- statusline all the time.
-- Changed the last column to 100 as Clojure, Common Lisp & Rust use that as a
-- max column length guide.
-- Added 180 because that is the max column for HPE Python code.
-- vim.cmd([[
--   set cc=80,100,180
--   ]])
vim.opt.colorcolumn={'80', '100', '180'}
vim.opt.cursorline = true

-- copy/paste from clipboard
vim.o.clipboard='unnamedplus'

-- Some env variables 
-- Do 'pip install neovim-remote' to install nvr
vim.env.VISUAL = 'nvr -cc split --remote-wait'
vim.env.PYTHONUNBUFFERED = 1
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- Fri Apr 28 2023 11:10:41 -> put this in to try and get undercurl properly working on iTerm
vim.cmd([[
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
  ]])


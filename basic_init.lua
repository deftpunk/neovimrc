-- vim: nu fdm=marker

-- init.lua based on lazy and not packer.
--
-- Some notes {{{

-- Run without sources config/plugins/etc.
-- $ nvim --clean

-- }}}

-- Some sensible defaults {{{
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

-- }}}

-- lazy.nvim {{{
-- https://github.com/folke/lazy.nvim
-- The Lazy Package Manager.
-- :Lazy check [plugins] - Check for updates and show the log (git fetch).
-- :Lazy clean - Clean plugins that are no longer needed. :Lazy install [plugins] - Install missing plugins.
-- :Lazy update [plugins] - Update plugins.
-- :Lazy log - Show recent updates.
-- :Lazy profile - plugin bootup profiler
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- }}}

-- Plugin Installation/Configuration {{{
require("lazy").setup({

    -- Treesitter {{{
    -- Modern syntax highlighting
	{
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        -- https://github.com/p00f/nvim-ts-rainbow/issues/30#issuecomment-850991264
        local parsers = require("nvim-treesitter.parsers")
        local enabled_list = {"clojure",  "commonlisp", "fennel", "go", "markdown", "markdown_inline", "Python", "ruby", "rust"}

        -- cmd("hi rainbowcol1 guifg=#ff3393")

        require('nvim-treesitter.configs').setup {
          ensure_installed = { "Python", "html", "c", "cmake", "lua", "go", "clojure", "json", "commonlisp", "bash", "dockerfile", "markdown", "markdown_inline",  "ruby", "rust", "toml", "vim", "yaml" },
          highlight = {
            enable = true,
          },
          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 25000,
            colors = {"#ab47bc", "#ec407a", "#42a5f5", "#ffab91", "#82e0aa", "#ff7043" },
            -- Enable for certain filetypes.
            disable = vim.tbl_filter(
              function(p)
                local disable = true
                for _, lang in pairs(enabled_list) do
                  if p==lang then disable = false end
                end
                return disable
              end,
              parsers.available_parsers()
              )
          }
        }
      end,
    },

    -- neorg {{{
    -- https://github.com/nvim-neorg/neorg
    {
      "nvim-neorg/neorg",
      build = ":Neorg sync-parsers", -- update the treesitter parsers
      ft = 'norg', -- lazy load on filetype
      cmd = 'Neorg', -- lazy load on command
      priority = 30, -- makes neorg load after treesitter
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
          load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {
              config = {
                init_open_folds = "always",
              }
            }, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
              config = {
                workspaces = {
                  work = "~/Neorg/work",
                  home = "~/Neorg/home",
                },
              },
            },
          },
        },
      keys = {
        { "<leader>ni", "<cmd>Neorg index<cr>", desc="Neorg Index"},
      },
    },
    -- }}}
})

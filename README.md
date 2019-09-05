# About Neovim

Neovim (https://neovim.io/) - the future of Vim.

> Vim the text editor has been loved by a generation of users.  This is the
> next generation.
- Shougo

# My Configuration

My dark powered Neovim configuration.  I use a lot of plugins, that is how I
choose to use Neovim, as is my perogative to do so.  If you choose a different
way, that is your prerogative but I find "purity" tool discussions dull.

# OS Configuration

## Mac OS X

### Setup Xcode
  1. Install Xcode
  2. Install the cmdline tools: =xcode-select --install=

### Change ITerm Preferences
  Profiles -> Keys -> Left option key acts as +Esc

### External Dependencies
Install the following packages via =brew install=
   - gls
   - coreutils
   - cask
   - ripgrep
   - ispell
   - git
   - bat
   - tree
   - ctags
   * fzf
   - fd

### Git Configuration
  - symlink global configuration files:
  $ ln -s tmp/yah/gitignore_global .gitignore_global
  $ ln -s tmp/yah/gitconfig .gitconfig

### Setup Python
This is the Python for Neovim, not the one for Python development. So DO NOT have miniconda in
the PATH or PYTHONPATH.
  1. brew install python@2
  2. brew install python3
  3. pip2 install neovim --upgrade
  4. pip3 install neovim --upgrade
  5. pip3 install neovim-remote
  6. pip3 install jedi, ipython, requests


## Linux Setup

### Install Rust:

  1. curl https://sh.rustup.rs -sSf | sh
  2. source ~/.cargo/env

### Install Ripgrep:

  1. cargo install ripgrep

### Install Python:

  1. sudo apt-get -y install python-pip


# Neovim Install

## Setup Neovim Remote
https://github.com/mhinz/neovim-remote
This solves the neovim inside of neovim problem you get when you set your
EDITOR=nvim and =git commit= is called.
  1. Change =EDITOR=nvim= in ~.zshrc
  2. Set NVIM_LISTEN_ADDRESS=/tmp/nvimsocket in ~.zshrc

= nvr --remote file1 file2 =

## Install Neovim

1. Use brew to install neovim
   $ brew update && brew install neovim
2. Clone my Neovim configuration.

## Install Plugin Manager

Install vim-plug (https://github.com/junegunn/vim-plug) BEFORE RUNNING NEOVIM
  1. $ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Install Vimr

Grab binary download from http://vimr.org/
  1. Copy CLI tool
  2. Set zsh interactive - so that environment variables are picked up.

# FAQ: Troubleshooting, Debugging & Profiling

## Figuring out what Neovim thinks a key is when pressed:

  - Enter Insert mode.
  - Press Ctrl-v & then the key combination you are trying to figure out.

## How to show all of the filetypes that Neovim supports:

  :echo glob(\$VIMRUNTIME . '/syntax/\*.vim')

## Echo out mappings - you will need to do this by interesting filetype.

  1. :redir! > vim_keys.txt
  2. :silent verbose map
  3. :redir END

## Check messages register:
  1. run =:messages=

## Send =:messages= output to buffer.
  1. =:redir @a=
  2. =:messages=
  3. =:redir END=
  4. Paste into a buffer: ="ap=

## Check the health:
  1. run =:checkhealth=

## Check the Python configuration for Neovim:
  1. Export Python log: export NVIM_PYTHON_LOG_FILE="/~/nvmi_python_log"
  2. Restart Neovim
  3. Check the log above.

## Start without an init file:
$ neovim -u NONE

## Debugging the init file:
$ `nvim -V20 2>&1 | tee logfile`

## Vim startup profiling, optimization etc.
https://coderwall.com/p/sdva9q/how-to-detect-plugins-slowing-vim-down

## Vim Neovim General Reference:

https://github.com/mhinz/vim-galore
http://spacevim.org/documentation/ - useful to mine for ideas.

## General Plugin And Vimscript Development:

VimConf18 - Effective Modern Vim Scripting:
https://www.youtube.com/watch?v=J5BX1FXnKBw&t=0s&list=PLx8bw5NQypsnlh5K5LZAaFvAdxfGpt2iq&index=9

vital.vim - https://github.com/vim-jp/vital.vim - vim utility functions.

https://vimconf.org/2018/slides/Effective_Modern_Vim_scripting_at_vimconf2018_for_PDF.pdf

$ echo set runtimepath+=~/vim-amake >> ~/.vimrc
$ mkdir ~/vim-amake && cd ~/vim-amake
$ mkdir plugin autoload doc
$ touch plugin/amake.vim autoload/amake.vim doc/amake.txt README.md

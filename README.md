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

# FAQ:

  1. Figuring out what Neovim thinks a key is when pressed:
     - Enter Insert mode.
     - Press Ctrl-v & then the key combination you are trying to figure out.
  2. How to show all of the filetypes that Neovim supports:
     =:echo glob($VIMRUNTIME . '/syntax/*.vim')=

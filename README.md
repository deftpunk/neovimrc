# About Neovim

Neovim (https://neovim.io/) - the future of Vim.

> Vim the text editor has been loved by a generation of users.  This is the
> next generation.
- Shougo

# My Configuration

I happen to use a lot of plugins, that is how I choose to use Neovim, as is my perogative to do so.  If you choose a different way, that is your prerogative; I also happen to find "purity" tool discussions dull.

## External Dependencies

Install the following packages via =brew install=, package manager or manual installation procedures:

   - ripgrep
   - ispell
   - git
   - bat
   - tree
   - ctags
   * fzf
   - fd
   - jq
   - curl
   - pandoc
   - The nvim-dap-ui icons & various LSP engines require `npm` (sigh)
       - `npm i @vscode/codicons`

### Git Configuration

  - symlink global configuration files:

```
  $ ln -s tmp/yah/gitignore_global .gitignore_global
  $ ln -s tmp/yah/gitconfig .gitconfig

```
# OS Configuration

## Mac OS X

### OS specific dependencies

- gls
- coreutils
- cask

#### Setup Xcode

  1. Install Xcode
  2. Install the cmdline tools: =xcode-select --install=

#### Karibiner-elements

I use Karibiner-elements to map `caps lock` to both control and escape.  If I hold the `caps lock` key then `Ctrl` is sent, just tapping it sends `Esc`

## Linux Setup

- Install various external dependencies mentioned above.
- Install neovim & neovide using manual install methods from respective websites.

# Neovim Install

## Setup Neovim Remote
https://github.com/mhinz/neovim-remote
This solves the neovim inside of neovim problem you get when you set your
EDITOR=nvim and =git commit= is called.
  1. Change =EDITOR=nvim= in ~.zshrc
  2. Set NVIM_LISTEN_ADDRESS=/tmp/nvimsocket in ~.zshrc

= nvr --remote file1 file2 =

## Install Neovim & Neovide

1. Use brew to install neovim
   $ brew update && brew install neovim neovide
2. Clone my Neovim configuration.

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

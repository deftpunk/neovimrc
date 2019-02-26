" vim: ft=vim nu fdm=marker
"
"                  _       __ _     _   _
"               __| | ___| |_| |_  | | | |_ _ __ ___
"              / _` |/ _ \  _| __| | | | | | '_ ` _ \
"             | (_| |  __/ | | |_  \ \_/ / | | | | | |
"              \__,_|\___|_|  \__|  \___/|_|_| |_| |_|
"
"                  A vimrc for the Emacs RSI emigrant
"                          Author: deftpunk
"
" I am a dark-side Neovim user, I have lots of plugins that I use.  If you
" don't like that, then don't use my configuration.
"
" About Neovim {{{

" Neovim (https://neovim.io/) - the future of Vim.
"
" Vim the text editor has been loved by a generation of users.  This is the
" next generation.
" - Shougo

" }}}

" Bootstrap Neovim Install {{{

" Setup Xcode:
"   1. Install Xcode
"   2. Install the cmdline tools: =xcode-select --install=

" Change ITerm Preferences:
"   Profiles -> Keys -> Left option key acts as +Esc
"
" Install External Dependencies:
" Install the following packages via =brew install=
"    - gls
"    - coreutils
"    - cask
"    - ripgrep
"    - ispell
"    - git
"    - bat
"    - tree
"    - ctags
"    - fd
"
" Git Configuration:
"   - symlink global configuration files:
"   $ ln -s tmp/yah/gitignore_global .gitignore_global
"   $ ln -s tmp/yah/gitconfig .gitconfig

" Setup Python:
" This is the Python for Neovim, not the one for Python development. So DO NOT have miniconda in
" the PATH or PYTHONPATH.
"   1. brew install python@2
"   2. brew install python3
"   3. pip2 install neovim --upgrade
"   4. pip3 install neovim --upgrade
"   5. pip3 install neovim-remote
"   6. pip3 install jedi, ipython, requests

" Setup Neovim Remote:
" https://github.com/mhinz/neovim-remote
" This solves the neovim inside of neovim problem you get when you set your
" EDITOR=nvim and =git commit= is called.
"   1. Change =EDITOR=nvim= in ~.zshrc
"   2. Set NVIM_LISTEN_ADDRESS=/tmp/nvimsocket in ~.zshrc
"
" = nvr --remote file1 file2 =

" Install Neovim:
" 1. Use brew to install neovim
"    $ brew update && brew install neovim
" 2. Clone my Neovim configuration.

" Install Plugin Manager:
" Install vim-plug (https://github.com/junegunn/vim-plug) BEFORE RUNNING NEOVIM
"   1. $ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Install Vimr:
" Grab binary download from http://vimr.org/
"   1. Copy CLI tool
"   2. Set zsh interactive - so that environment variables are picked up.

" Development Language Specifics:
" Check below for any specific settings or install quirks.

" }}}

" Notes {{{

" Investigations: {{{
" Some plugins to check out in the future & notes on comparing classes of
" plugins.
"
" https://github.com/kana/vim-niceblock
" https://github.com/euclio/vim-markdown-composer
" https://gitlab.com/HiPhish/repl.nvim
" https://github.com/svermeulen/vim-subversive
" https://github.com/mcchrish/nnn.vim - a possible replacement for NERDTree
" https://github.com/Yilin-Yang/vim-markbar - show marks, maybe better than
"                                             vim-bookmarks.
" https://github.com/reconquest/vim-pythonx - python tools for easier coding.
" https://github.com/numirias/semshi
" https://github.com/mhinz/vim-galore
" https://github.com/xolox/vim-session
" http://spacevim.org/documentation/
" https://github.com/ludovicchabant/vim-gutentags
" https://github.com/chrisbra/csv.vim - CSV files
" https://github.com/rhysd/vim-gfm-syntax - Github flavored markdown syntax
" 					    hightlighting
" https://github.com/bcicen/vim-jfmt
" https://github.com/idanarye/vim-vebugger
" https://github.com/blueyed/vim-diminactive
" https://github.com/PeterRincker/vim-argumentative - function signatures.
"
" https://github.com/cohama/lexima.vim - parens autoclosing
" https://github.com/alvan/vim-closetag - for closing html tags
" http://mattn.github.io/emmet-vim/ - for closing CSS tags
" https://github.com/jiangmiao/auto-pairs - another parens/backets autoclosing
"
" vim-themis - https://github.com/thinca/vim-themis - testing framework for
"   vimscript.
" vital.vim - https://github.com/vim-jp/vital.vim
" denite - https://github.com/Shougo/denite.nvim
" denite-extras - https://github.com/neoclide/denite-extra
" coc.vim - https://github.com/neoclide/coc.nvim - better(?) completion w/ LSP
"
" Finished:
" Thursday Jan 3, 2019
" https://github.com/terryma/vim-smooth-scroll
" I can do without the smooth scrolling.
"
" }}}

" Plugin And Vimscript Development: {{{
"
" VimConf18 - Effective Modern Vim Scripting:
" https://www.youtube.com/watch?v=J5BX1FXnKBw&t=0s&list=PLx8bw5NQypsnlh5K5LZAaFvAdxfGpt2iq&index=9
" https://vimconf.org/2018/slides/Effective_Modern_Vim_scripting_at_vimconf2018_for_PDF.pdf
"
" $ echo set runtimepath+=~/vim-amake >> ~/.vimrc
" $ mkdir ~/vim-amake && cd ~/vim-amake
" $ mkdir plugin autoload doc
" $ touch plugin/amake.vim autoload/amake.vim doc/amake.txt README.md
" }}}

" Themes:
"   - https://github.com/xero/nord-vim-mod
"
" Search And Replace Plugins:
"   1. far.vim - https://github.com/brooth/far.vim
"       - Edit mode, in the sense that you enter the replace with pattern on
"         the commandline.
"       - ripgrep support
"       - Asynchronous on Neovim without using Dispatch.
"       - Farundo doesn't always undo - known bug
"   2. FlyGrep.vim - https://github.com/wsdjeg/FlyGrep.vim
"       - No Edit mode
"   3. vim-ags - https://github.com/gabesoft/vim-ags
"   	- Edit mode
"   	- Looks like you can change the search utility to ripgrep.
"   	- Async was just added but can be laggy.
"   	- rainbow delimiter conflict that can be worked around.
"   4. ctrlsf.vim - https://github.com/dyng/ctrlsf.vim
"       - leverages multiple-cursors
"       - can make use of ripgrep
"       - Edit mode only allows for modify and delete.
"       - Asynchronous
"       - Dispatch and multiple-cursors dependencies.
"   5. vim-swoop - https://github.com/pelodelfuego/vim-swoop
"   	- Pretty sure its not Asynchronous.
"   	- Edit mode
"   	- Single or multiple buffers.
" }}}

" Troubleshooting Debugging And Profiling The Configuration: {{{
"
" Check messages register:
"   1. run =:messages=
"
" Send =:messages= output to buffer.
"   1. =:redir @a=
"   2. =:messages=
"   3. =:redir END=
"   4. Paste into a buffer: ="ap=
"
" Check the health:
"   1. run =:checkhealth=
"
" Check the Python configuration for Neovim:
"   1. Export Python log: export NVIM_PYTHON_LOG_FILE="/~/nvmi_python_log"
"   2. Restart Neovim
"   3. Check the log above.
"
" Start without an init file:
" $ neovim -u NONE
"
" Debugging the init file:
" $ `nvim -V20 2>&1 | tee logfile`
"
" Vim startup profiling, optimization etc.
" https://coderwall.com/p/sdva9q/how-to-detect-plugins-slowing-vim-down
" }}}

" FAQ: {{{
"
" 1. Figuring out what (Neo)vim thinks a key is when pressed:
"    - Enter Insert mode.
"    - Press Ctrl-v & then the key combination you are trying to figure out.
" 2. How to show all of the filetypes that Neovim supports:
"    =:echo glob($VIMRUNTIME . '/syntax/*.vim')=
" }}}

" Options -------------------------------------------------------- {{{

" neovim-remote
" Avoid nested neovim processes by using neovim-remote. This should have been
" installed prior to Neovim.
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" good encoding
set encoding=utf-8

" Turn off sounds, bells and blinking cursors
set visualbell t_vb=
set noerrorbells
set gcr=a:blinkon0

" Show colored columns so I know how far I've typed without looking down at the
" statusline all the time.
set colorcolumn=80,105

" file name and current directory in the terminal or gui title
set title

" always keep 2 lines at the top or bottom when scrolling lines or scrolling
" the cursor.
set scrolloff=2

" highlight the cursor line
" setting the cursorline slows down screen redraw, hopefully this will help
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Menu
set wildmode=longest,full
set wildignore+=.hg,.git,.svn                      " Version control.
set wildignore+=*.sw?                              " Vim swap files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.elc        " compiled object files
set wildignore+=*.pyc                              " Python byte code.
set wildignore+=*.luac                             " Lua byte code.
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg     " binary image

" copy/paste from clipboard
set clipboard+=unnamedplus
" Optimization for Neovim startup.
" https://www.reddit.com/r/neovim/comments/ab01n8/improve_neovim_startup_by_60ms_for_free_on_macos/
let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 0,
  \ }

" no irritating swapfile.
set noswapfile

" Search incremently + dont keep the highlight around.
set incsearch
set nohlsearch

" When a bracket is inserted, briefly jump to the matching one.  The time to
" show the match is set by matchtime, which is in tenths of seconds.
set showmatch
set matchtime=2

" Turn on hightlighting of tabs, whitespace, etc.
" NOTE: Tue Sep 19 11:57:30
" 1. don't need these since i am using whitespace mode(?)
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
" set listchars+=eol:⤦
set list

" Indentation and line breaks
" - visually show line breaks - got the character to show up w/ <Ctrl-V>u21aa in
"   insert mode.
" - The column used for number/relatvienumber is also used for wrapped lines
set breakindent
set showbreak=↪
set cpo+=n

" Use persistent history
if !isdirectory("/Users/ebodine/tmp/neovim-undo-dir")
	call mkdir("/Users/ebodine/tmp/neovim-undo-dir", "", 0700)
endif
set undodir=/Users/ebodine/tmp/neovimrc/neovim-undo-dir
set undofile

" Automatically reload files that have changed.
set autoread

" Substitute all matches on a line instead of just one - this means that
" supplying 'g' will now only make a single substitution.
set gdefault

" Blanking out nrformat will force decimal arithmetic.
set nrformats=

" Smarter completions by infering case, as opposed to ignorecase.
set infercase

" Only syntax highlight the first 200 characters on a line.  This helps avoid
" some performance penalty with long lines.
set synmaxcol=200

" Take me to my Leader key and make sure that nothing messes with it.
noremap <Leader>      <Nop>
noremap <LocalLeader> <Nop>
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
" Map the localleader.
let g:maplocalleader = '\'

" }}}

" General Autocommands -------------------------------------------- {{{

autocmd BufEnter * :syntax sync fromstart

" Turn off line numbers for help files.
" autocmd FileType help setlocal nonumber norelativenumber

" Automatically equalize splits when Vim is resized.
autocmd VimResized * wincmd =

" Enable functional autosave and autoread behaviour.
" https://bluz71.github.io/2017/05/15/vim-tips-tricks.html
" autoread - When a file has been changed outside of Vim but not inside it,
" automatically read it again.
set autoread

" checktime - Check if any buffers were changed outside of Vim.
augroup autoSaveAndRead
    autocmd!
    autocmd TextChanged,InsertLeave,FocusLost * silent! wall
    autocmd CursorHold * silent! checktime
augroup END

"}}}

" vim-plug - Plugin management {{{
" https://github.com/junegunn/vim-plug
" Make sure you use single quotes when specifying URLs
" Intialize Plug and specify a directory for plugins.
call plug#begin('~/.config/nvim/plugged')
" }}}

" Text Objects ----------------------------------------------------- {{{
"
" Text Objects in Vim are a very handy tool
" https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/

" targets.vim
" https://github.com/wellle/targets.vim
" Vim plugin that provides additional text objects
"   - Pair text objects
"   - Quote text objects
"   - Separator text objects
"   - Argument text objects
Plug 'wellle/targets.vim'

" argtextobj.vim {{{
" https://github.com/vim-scripts/argtextobj.vim
" Text objects for function arguments.
"   aa - an argument
"   ia - inner argument
" Plug 'vim-scripts/argtextobj.vim'
" }}}

" vim-indent-object {{{
" https://github.com/michaeljsmith/vim-indent-object
"   Mapping              Description
"  -----------------------------------------------------------------
"  <count>ai         (A)n (I)ndentation level and line above.
"  <count>ii         (I)nner (I)ndentation level (no line above).
"  <count>aI         (A)n (I)ndentation level and lines above/below.
"  <count>iI (I)nner (I)ndentation level (no lines above/below).
"  -----------------------------------------------------------------
Plug 'michaeljsmith/vim-indent-object'
" }}}

" vim-textobj-user {{{
" https://github.com/kana/vim-textobj-user
" Create your own textobjects - dependency for textobj-python
"
" vim-textobj-user is a Vim plugin to create your own text objects without
"   pain. It is hard to create text objects, because there are many pitfalls to
"   deal with. This plugin hides such details and provides a declarative way to
"   define text objects. You can use regular expressions to define simple text
"   objects, or use functions to define complex ones.
Plug 'kana/vim-textobj-user'
" }}}

" }}}

" Navigation ------------------------------------------------------------- {{{

" Navigation Plugins:
" 1. Denite 1/31/2019 - not sure if it will be fast enough to work w/ Linux
"                       Kernel code. base.
"    - uses Python3
"    - outline/tags source requires ctags to be installed.
"    - Denite Lines doesn't work with the jumplist == C-i/C-o don't work.
" 2. CtrlP
"    - outline/tags (CtrlPFunky) doesn't require ctags to be installed.
"    - CtrlPLine works with jumplist so that C-i/C-o work but doesn't seem to
"      find stuff as well.
"    - fruzzy & ripgrep help make it much faster.
"    - CtrlPFunky is the bomb.
" 3. LeaderF - https://github.com/Yggdroot/LeaderF
"              1/31/2019 - not fast enough.
"    - uses Python
" 4. FZF
"    - wicked fast.
"    - No boommarks
"    - No outline/tags
"    - MRU is a different command - no mixed results, that I can see.
"    - Lines+BLines Does work with jumplist.

" fruzzy {{{
" https://github.com/raghur/fruzzy
" Freaky fast fuzzy finder for (denite.nvim/CtrlP matcher) for vim/neovim
" 01/21/2019 - Got a pretty fast speed up using fruzzy with CtrlP.
Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
" optional - but recommended - see below
let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 1 " default value
" }}}

" The active fork of CtrlP {{{
" https://github.com/ctrlpvim/ctrlp.vim
"
" Fri Oct 27, 2017 11:36:42am - Try out using cpsm as a matcher
" https://github.com/nixprime/cpsm
" NOTE: Didn't work out so well
"
" Use the silver searcher in deference to what ctrlp normally does.
" 3/23/2016 - commented this out because it wasn't working for some reason.
" 10/4/2016 - giving this another shot with a modified Ag cmdline.
" let g:ctrlp_user_command='ag %s -i --nocolor --nogroup --hidden
"                             \ --ignore .git
"                             \ --ignore .hg
"                             \ --ignore .DS_store
"                             \ --ignore "**/*.pyc"
"                             \ -g ""'
" let g:ctrlp_root_markers = ['makepythontags']
" let g:ctrlp_extensions=['smarttabs']

Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_user_command='rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching=0
let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
let g:ctrlp_match_current_file = 1 " to include current file in matches

nnoremap <leader>fb :CtrlPBuffer<cr>
nnoremap <leader>fc :CtrlPChange<cr>
nnoremap <leader>fd :CtrlPDir<cr>
nnoremap <leader>i :CtrlPMixed<cr>
nnoremap <leader>fm :CtrlPMRUFiles<cr>
nnoremap <leader>fq :CtrlPQuickfix<cr>

nnoremap <leader>s :CtrlPLine %<cr>

let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("n")':   ['<c-n>', '<down>'],
    \ 'PrtSelectMove("p")':   ['<c-p>', '<up>'],
    \ }

" vim-ctrlp-ag - Ag with CtrlP
" https://github.com/lokikl/vim-ctrlp-ag
Plug 'lokikl/vim-ctrlp-ag'

nnoremap <leader>ca :CtrlPagLocate
nnoremap <leader>cp :CtrlPagPrevious<cr>
let g:ctrlp_ag_ignores = '--ignore .git
    \ --ignore "deps/*"
    \ --ignore ".mypy_cache"
    \ --ignore "__pycache__"
    \ --ignore "_build/*"
    \ --ignore "node_modules/*"'

" Show tags (ctags) for current file.
" https://github.com/tacahiroy/ctrlp-funky
Plug 'tacahiroy/ctrlp-funky'
let g:ctrlp_funky_syntax_highlight=1
let g:ctrlp_funky_after_jump = {
    \ 'default' : 'zxzz',
    \ 'python'  : 'zOzz'
    \}
let g:ctrlp_funky_cache_dir='~/.config/nvim/.cache/ctrlp-funky'
" Only Funky can give you tags without generating something via ctags.  The
" BTags and Tags functions in fzf.vim can't do it.
" NOTE: 8/24/2017 - Its still a bit slow.
nnoremap <leader>ci :CtrlPFunky<cr>

" CtrlPtjump - doesn't work without a tags file, so i deleted it - Sep 24, 2018

" cmdline, yankring + menu
" https://github.com/sgur/ctrlp-extensions.vim
Plug 'sgur/ctrlp-extensions.vim'

" marks - local and global
Plug 'mattn/ctrlp-mark'

" Show and exec command history from CtrlP
" Adds cmd history (what you see in g:) and search history
" (what you see in g/) to ctrlp so you can quickly re-run commands or searches.
" https://github.com/ompugao/ctrlp-history
Plug 'ompugao/ctrlp-history'
nnoremap <silent><C-p><C-h> :CtrlPCmdHistory<CR>
nnoremap <silent><C-p><C-s> :CtrlPSearchHistory<CR>

" CtrlP extension for vim help keywords.
" https://github.com/zeero/vim-ctrlp-help
Plug 'zeero/vim-ctrlp-help'
nnoremap <leader>he :CtrlPHelp<cr>

" }}}

" FZF {{{
"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" }}}

" vim-easymotion {{{
" Moving around in a buffer like ace-jump and avy.
" https://github.com/easymotion/vim-easymotion
Plug 'easymotion/vim-easymotion'
nmap <leader><leader>s <Plug>(easymotion-s)
nmap <leader><leader>l <Plug>(easymotion-bd-tl)
" }}}

" ListToggle {{{
" Toggle location & quickfix windows.
" https://github.com/Valloric/ListToggle
Plug 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>cl'
let g:lt_quickfix_list_toggle_map = '<leader>cq'
let g:lt_height = 15
" }}}

" Visual Star Search
" Allow for * and # searches to occur on the current visual selection.
" https://github.com/nelstrom/vim-visual-star-search
Plug 'nelstrom/vim-visual-star-search'

" }}}

" General Utilities -------------------------------------------------------- {{{

" vim-abolish {{{
" https://github.com/tpope/tpope-vim-abolish
" Abbreviate multiple variants of words
"
" Coercion
" Press crs (coerce to snake_case).
" MixedCase (crm),
" camelCase (crc),
" snake_case (crs),
" UPPER_CASE (cru),
" dash-case (cr-),
" dot.case (cr.),
" space case (cr<space>),
" and Title Case (crt) are all just 3 keystrokes away.
" These commands support repeat.vim.
Plug 'tpope/tpope-vim-abolish'
let g:abolish_save_file="/Users/ebodine/.config/nvim/abolish-abbreviations.vim"
" }}}

" vim-active-numbers {{{
" https://github.com/AssailantLF/vim-active-numbers
" Only show line numbers in the active window.
Plug 'AssailantLF/vim-active-numbers'
let g:active_number = 1
let g:actnum_exclude =
\ [ 'denite', 'tagbar', 'startify', 'undotree', 'gundo', 'vimshell', 'w3m',
\   'help', 'mundo', 'magit', 'fugitive', 'nerdtree']
" }}}

" Ale - async syntax checking {{{
" https://github.com/w0rp/ale
Plug 'w0rp/ale'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '≈'
let g:ale_linters = {
\    'python': ['flake8'],
\}
let g:ale_python_flake8_options = '--config=/Users/ebodine/.flake8'
let g:ale_emit_conflict_warnings = 0
" }}}

" arpeggio {{{
" https://github.com/kana/vim-arpeggio
" keychords for vim. You cant create heirarchies with this unlike key-chord in
" Emacs. It is initialized after the plug#end statement.
Plug 'kana/vim-arpeggio'
" }}}

" vim-asterisk {{{
" https://github.com/haya14busa/vim-asterisk
" Provides improved * motions.
Plug 'haya14busa/vim-asterisk'
nmap * <Plug>(asterisk-*)
nmap # <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
" }}}

" vim-autosave {{{
" https://github.com/907th/vim-auto-save
" Automatically saves changes to disk without having to use :w (or any binding
" to it) every time a buffer has been modified or based on your preferred
" events.
"
" By default AutoSave will save every time something has been changed in normal
" mode and when the user leaves insert mode. This configuration is a mix
" between save as often as possible and try to avoid breaking other plugins
" that depend on filewrite-events.
Plug '907th/vim-auto-save'

" Enable AutoSave on Vim startup
let g:auto_save = 1
" Do not display the auto-save notification
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]
" }}}

" vim-bbye - Handle deleting buffers and closing files. {{{
" https://github.com/moll/vim-bbye
Plug 'moll/vim-bbye'
" Buffer delete
nnoremap <leader>k :Bdelete<cr>
" }}}

" vim-bookmarks {{{
" NTOE: Wed Nov 22, 2017 2:57:13pm - commented out to see if I use this at
" all.
" https://github.com/MattesGroeger/vim-bookmarks
"
" Default mappings::
"   Action 	                                    Shortcut 	Command
"   Add/remove bookmark at current line 	        mm 	:BookmarkToggle
"   Add/edit/remove annotation at current line 	        mi 	:BookmarkAnnotate <TEXT>
"   Jump to next bookmark in buffer 	                mn 	:BookmarkNext
"   Jump to previous bookmark in buffer 	        mp 	:BookmarkPrev
"   Show all bookmarks (toggle) 	                ma 	:BookmarkShowAll
"   Clear bookmarks in current buffer only 	        mc 	:BookmarkClear
"   Clear bookmarks in all buffers 	                mx 	:BookmarkClearAll
"   Save all bookmarks to a file 		:BookmarkSave <FILE_PATH>
"   Load bookmarks from a file 		        :BookmarkLoad <FILE_PATH>
" Plug 'MattesGroeger/vim-bookmarks'
" disable default mappings.
" let g:bookmark_no_default_key_mappings = 1
" }}}

" delimitMate {{{
" auto quotes, parens, brackets
" https://github.com/raimondi/delimitMate
" NOTE: Another pairs plugin to try - https://github.com/jiangmiao/auto-pairs
Plug 'raimondi/delimitMate'
" }}}

" dash.vim {{{
" https://github.com/rizzatti/dash.vim
" Use Dash.app to lookup documentation.
" Usage:
"     :Dash[!] [TERM] [KEYWORD]
"     :Dash os.path.dirname python
Plug 'rizzatti/dash.vim'
" }}}

" deoplete {{{
" https://github.com/Shougo/deoplete.nvim
" Dark powered async completion framework for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" NOTE: Feb 15, 2018  9:12 am - Had to comment out NVIM_LISTEN_ADDRESS in ~/.zshrc
" https://github.com/Shougo/deoplete.nvim/issues/646
let g:deoplete#enable_at_startup = 1
" }}}

" vim-eunuch {{{
" https://github.com/tpope/vim-eunuch
" Some vim sugar for Unix commands that need it the most, e.g.
" :Remove - delete buffer and file on disk
" :Move - rename buffer and file on disk
" :Rename - same as above but relative fo file's curent directory.
" :SudoWrite - Write file w/ sudo
" :SudoEdit - Edit a file w/ sudo
" NOTE: Wed Nov 22, 2017 2:58:32pm - The Sudo* functions are not working(?) on
" Mac ... not sure if this is Mac or vim-eunuch
Plug 'tpope/vim-eunuch'
" }}}

" Folding {{{

" FastFold {{{
" https://github.com/Konfekt/FastFold
" Automatic folds bog down Neovim/Vim, make this go away.
Plug 'Konfekt/FastFold'
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" Folding by filetype - python folds by indent, so don't worry about this for
" python code.
let g:vimsyn_folding='af'
" Create a fold text object, mapped to iz and az
xnoremap iz :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>
xnoremap az :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>
" }}}

" Tabfold {{{
" https://github.com/thalesmello/tabfold
" Plugin that enables fold toggle using the <Tab> key
Plug 'thalesmello/tabfold'
" }}}

" }}}

" vim-commentary - comment/uncomment stuff out {{{
" https://github.com/tpope/vim-commentary
" Using this instead of nerdcommenter which turned out to be very slow on
" Neovim <shrug>
" Usage:
"  - Use gcc to comment out a line (takes a count),
"  - gc to comment out the target of a motion (for example, gcap to comment out a paragraph),
"  - gc in visual mode to comment out the selection,
"  - gc in operator pending mode to target a comment.
"  - You can also use it as a command, either with a range like :7,17Commentary, or
"    as part of a :global invocation like with :g/TODO/Commentary. That's it.
Plug 'tpope/vim-commentary'
" }}}

" ctrlsf - Ctrl-Shift-F (Sublime Text 3) {{{
" https://github.com/dyng/ctrlsf.vim
" An ack/ag/pt/rg powered code search and view tool.
"
" :CtrlSF [pattern]
"
" In CtrlSF window:
"     Enter, o, double-click - Open corresponding file of current line in the
"                              window which CtrlSF is launched from.
"     <C-O> - Like Enter but open file in a horizontal split window.
"     t - Like Enter but open file in a new tab.
"     p - Like Enter but open file in a preview window.
"     P - Like Enter but open file in a preview window and switch focus to it.
"     O - Like Enter but always leave CtrlSF window opening.
"     T - Like t but focus CtrlSF window instead of new opened tab.
"     M - Switch result window between normal view and compact view.
"     q - Quit CtrlSF window.
"     <C-J> - Move cursor to next match.
"     <C-K> - Move cursor to previous match.
"
" In preview window:
"     q - Close preview window.
Plug 'dyng/ctrlsf.vim'
let g:ctrlsf_ackprg = '/usr/local/bin/rg'
let g:ctrlsf_indent = 2
let g:ctrlsf_search_mode = 'async'

" vim-multiple-cursors
" https://github.com/terryma/vim-multiple-cursors
" Dependency for edit mode in CtrlSF
Plug 'terryma/vim-multiple-cursors'
" }}}

" indentLine {{{
" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '┆'
let g:indentLine_indentLevel = 6
let g:indentLine_fileType = ['python', 'perl', 'go']
" }}}

" vim-lastplace {{{
" https://github.com/farmergreg/vim-lastplace
" Remember your last location in a file.
" - Folds are automatically opened when jumping to the last edit position
Plug 'farmergreg/vim-lastplace'
" }}}

" vim-lion {{{
" https://github.com/tommcdo/vim-lion
" Align text around a given character.
" I find it easiest to select a visual region and then invoke gl<character> to
" re-align text around a chosen character (which will often be equals).
Plug 'tommcdo/vim-lion'
let g:lion_squeeze_spaces = 1
" }}}

" vim-move {{{
" https://github.com/matze/vim-move
" Move line/selection up/down, move char/selection left/right
" NOTE: To get the default Meta mappings to work in iTerm, do the following:
"       - In iTerm: Profiles -> Keys -> Left option key acts as +Esc
" e.g.
"    A-j line/selection up
"    A-h char/selection left
Plug 'matze/vim-move'
" }}}

" Mundo {{{
" http://simnalamburt.github.io/vim-mundo/dist/
" Graph your Vim undo tree in style; less painful browsing of the undo tree.

" Also tried out Undotree:
" https://github.com/mbbill/undotree
" Plug 'mbbill/undotree'
" nnoremap <silent><leader>nu :UndotreeToggle<cr>

" Your current position in the undo tree is marked with an @ character. Other
" nodes are marked with an o character.

" When you toggle open the graph Mundo will put your cursor on your current
" position in the tree. You can move up and down the graph with the j and k
" keys.

" You can move to the top of the graph (the newest state) with gg and to the
" bottom of the graph (the oldest state) with G.

" As you move between undo states the preview pane will show you a unified
" diff of the change that state made.

" Pressing return on a state (or double clicking on it) will revert the
" contents of the file to match that state.

" You can use p on a state to make the preview window show the diff between
" your current state and the selected state, instead of a preview of what the
" selected state changed.

" Pressing P while on a state will initiate "play to" mode targeted at that
" state. This will replay all the changes between your current state and the
" target, with a slight pause after each change. It's mostly useless, but can
" be fun to watch and see where your editing lags — that might be a good place
" to define a new mapping to speed up your editing.

" Pressing q while in the undo graph will close it. You can also just press
" your toggle mapping key.
Plug 'simnalamburt/vim-mundo'
let g:mundo_width = 52
let g:mundo_preview_height = 40
let g:mundo_preview_bottom = 1

nnoremap <silent><leader>u :MundoToggle<cr>
" }}}

" NERDTree {{{
" https://github.com/scrooloose/nerdtree.git
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowBookmarks=1
nnoremap <leader>nt :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" open-browser {{{
" https://github.com/tyru/open-browser.vim
" Open a broser from Neovim - I mostly use this to start a web search from
" Neovim.  It opens your default browser.
Plug 'tyru/open-browser.vim'
" }}}

" scratch.vim {{{
" https://github.com/mtth/scratch.vim
" An unobtrusive scratch window.
"
"  :Scratch opens a scratch buffer in a new window (by default using the top
"  20% of the screen, configurable via g:scratch_height and g:scratch_top).
"  The window automatically closes when inactive (and its contents will be
"  available the next time it is opened).

"  gs - in normal mode opens the scratch window and enters insert mode. The
"  scratch window closes when you leave insert mode. This is especially
"  useful for quick notes.
"  gs - in visual mode pastes the current selection (character-wise,
"  line-wise or block-wise) into the scratch buffer.

"  Both above mappings have a gS variant that clears the scratch buffer before
"  opening it. Note also that the auto-closing features require hidden to be
"  set (and can be disabled via the g:scratch_autohide option).

"  By default the contents of the scratch window are lost when leaving Vim. To
"  enable cross-session persistence, set the g:scratch_persistence_file option
"  to a valid file path.
Plug 'mtth/scratch.vim'
let g:scratch_height=25
let g:scratch_persistence_file='/Home/Users/ebodine/tmp/neovim-scratch.txt'
" }}}

" vim-scriptease {{{
" https://github.com/tpope/vim-scriptease
" Some utilities to add in the creation of plugins and other goodies.
" e.g.
" 	:Messages
" 	:Verbose
" 	:Time
" 	K - look help for the VimL construct.
Plug 'tpope/vim-scriptease'
" }}}

" vim-repeat {{{
" https://github.com/tpope/vim-repeat
" Enable repeating supported plugin maps.
Plug 'https://github.com/tpope/vim-repeat.git'
" }}}

" incsearch.vim - Incrementally highlight search pattern matches. {{{
" https://github.com/haya14busa/incsearch.vim
Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
" g/ Search will NOT move the cursor.
map g/ <Plug>(incsearch-stay)

" incsearch-fuzzy.vim
" https://github.com/haya14busa/incsearch-fuzzy.vim
Plug 'haya14busa/incsearch-fuzzy.vim'

nmap z/ <Plug>(incsearch-fuzzy-/)
nmap z? <Plug>(incsearch-fuzzy-?)
nmap zg/ <Plug>(incsearch-fuzzy-stay)<Paste>
" }}}

" Sessions - obssesion+prosession {{{

" vim-obsession
" Better manage the :mksession interface - see vim-prosession below.
" https://github.com/tpope/vim-obsession
Plug 'tpope/vim-obsession'

" prosession
" Leverage vim-obsession to switch between multiple sessions cleanly
" https://github.com/dhruvasagar/vim-prosession/
Plug 'dhruvasagar/vim-prosession'
let g:prosession_dir='~/tmp/neovimrc/sessions'
let g:prosession_on_startup = 1

" ctrlp-obsession
" https://github.com/gikmx/vim-ctrlposession
" A super simple session-navigator using obsession / prosession & CtrlP
Plug 'gikmx/ctrlp-obsession'
" }}}

" Snippets {{{
" Using Ultisnips instead of neocomplete because neocomplete does not allow
" you to use additional snippet directories.

" Ultisnips - the ultimate snippet solution for Neovim/Vim
" https://github.com/SirVer/ultisnips
"   - youtube tutorials at the bottom of website
Plug 'SirVer/ultisnips'
" expand via tab.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" vim-snippets
" https://github.com/honza/vim-snippets
Plug 'honza/vim-snippets'
" }}}

" vim-fat-finger {{{
" https://github.com/chip/vim-fat-finger
" Fix common misspellings and typos.  Supports over 4,000 common misspellings.
Plug 'chip/vim-fat-finger'
" }}}

" rainbow - rainbow parentheses improved {{{
" https://github.com/luochen1990/rainbow
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
" }}}

" vim-sandwich {{{
" https://github.com/machakann/vim-sandwich
" Replacement for vim-surround; uses text objects to surround/sandwich things.
" The set of operator and textobject plugins to search/select/edit sandwiched textobjects.
"   add:
"   Press sa{motion/textobject}{addition}. For example, a key sequence
"   saiw( makes foo to (foo).
"
"   delete:
"   Press sdb or sd{deletion}. For example, key sequences sdb or
"   sd( makes (foo) to foo. sdb searches a set of surrounding automatically.
"
"   replace:
"   Press srb{addition} or sr{deletion}{addition}.
"   For example, key sequences srb" or sr(" makes (foo) to "foo".
Plug 'machakann/vim-sandwich'
" }}}

" vim-slash {{{
" https://github.com/junegunn/vim-slash
" Enhancing in-buffer search experience.
"   - Clears highlight when cursor moves.
"   - star-search: highlighting without moving.
Plug 'junegunn/vim-slash'
noremap <plug>(slash-after) zz
" }}}

" tagbar - a class outline viewer {{{
" https://majutsushi.github.io/tagbar
Plug 'majutsushi/tagbar'

" In the CloseWindow() function there is a call to honor the defualt
" equalalways setting.  As a result, when closing/toggling Tagbar, any window
" sizing gets equalized
set noequalalways

let g:tagbar_sort = 0
let g:tagbar_left = 1
let g:tagbar_expand = 1
let g:tagbar_width = 45
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_show_linenumbers = 1

" Use the ctags that homebrew installs rather than the stupid Xcode one.
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" Tagbar configuration for Golang
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" Tagbar configuration for Groovy.  Requires a corresponding ~/.ctags config.
" https://github.com/majutsushi/tagbar/wiki#groovy
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package:1',
        \ 'c:classes',
        \ 'i:interfaces',
        \ 't:traits',
        \ 'e:enums',
        \ 'm:methods',
        \ 'f:fields:1'
    \ ]
\ }

nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>to :TagbarOpen<CR>
" }}}

" traces {{{
" https://github.com/markonm/traces.vim
" A better way to highlight search+replace actions.  Works in more situations
" than inccomand.
Plug 'markonm/traces.vim'
" }}}

" unimpaired - pairs of handy bracket mappings {{{
" https://github.com/tpope/vim-unimpaired
" Some of the mappings i care about:
" [<Space>    Add [count] blank lines above the cursor.
" ]<Space>    Add [count] blank lines below the cursor.
" [e          Exchange the current line with [count] lines above it.
" ]e          Exchange the current line with [count] lines below it.
"
" On  Off  Toggle Option
" [od ]od  cod    'diff' (actually |:diffthis| / |:diffoff|)
" [oh ]oh  coh    'hlsearch'
" [os ]os  cos    'spell'
" [ow ]ow  cow    'wrap'
"
" Buffer commands
" [b          :bprevious
" ]b          :bnext
" [B          :bfirst
" ]B          :blast
"
" [n          Go to the previous SCM conflict marker or diff/patch
"             hunk.  Try d[n inside a conflict.
" ]n          Go to the next SCM conflict marker or diff/patch hunk.
"             Try d]n inside a conflict.
Plug 'tpope/vim-unimpaired'
" }}}

" vim-better-whitespace {{{
" https://github.com/ntpeters/vim-better-whitespace
" Cause trailing whitespace characters to be highlighted.  Also make stripping
" whitespace painless.
Plug 'ntpeters/vim-better-whitespace'
autocmd FileType python autocmd BufEnter <buffer> EnableStripWhitespaceOnSave
autocmd FileType vim autocmd BufEnter <buffer> EnableStripWhitespaceOnSave
" }}}

" }}}

" Note Taking {{{

" 1. Have tried vim-orgmode.
"    https://github.com/jceb/vim-orgmode
"    It is kind of slow at parsing - it started to bog at just 1900 lines.
"    It can't do tables.
"
" 2. Have tried vim-wiki
"    Just to much going back and forth.  Not lean enough, should give it
"    another try at some point.  Maybe just as a way of keeping reference
"    material.
"    Wed December 5 2:51:20pm 2018 - tried again; didn't like dealling with the
"    binding conflicts.

" vim-speeddating
" https://github.com/tpope/vim-speeddating
" Use Ctrl-a/Ctrl-x to increment dates, times and more
Plug 'tpope/vim-speeddating'

" }}}

" Software Development: Utilities {{{

" Conflict marker highlighting. {{{
" https://github.com/rhysd/conflict-marker.vim
"
" Highlight Conflict Markers
"  Conflict markers (<<<<<<<, ======= and >>>>>>> as default) are highlighted automatically.
"
" Jump among Conflict Markers
"   [x and ]x mappings are defined as default.
"
"   Jump within a Conflict Marker
"   This feature uses matchit.vim, which is bundled in Vim (macros/matchit.vim).
"   % mapping is extened by matchit.vim.
"
" Resolve a Conflict with Various Strategies
"   This plugin defines mappings as default, =ct= for themselves,
"   =co= for ourselves, =cn= for none and =cb= for both.
"
"   <<<<<<< HEAD
"   ourselves
"   =======
"   themselves
"   >>>>>>> deadbeef0123
"
Plug 'rhysd/conflict-marker.vim'
" Don't use default mappings.
" let g:conflict_marker_enable_mappings=0
" }}}

" vim-endwise {{{
" https://github.com/tpope/vim-endwise
" Primarily for Ruby but will also Vimscript, Shell and Lua
" e.g. will put an -end- after your -if-
Plug 'tpope/vim-endwise'
" }}}

" vim-sexp
"https://github.com/guns/vim-sexp
" Precision editing of S-expressions in Clojure, Common Lisp
Plug 'guns/vim-sexp'

" vim-test - run your tests at the speed of thought.
" https://github.com/janko-m/vim-test
Plug 'janko-m/vim-test'

" vim-illuminate {{{
" https://github.com/RRethy/vim-illuminate
" Selectively illuminating other uses of the current word under the cursor.
Plug 'RRethy/vim-illuminate'
" make the illumination stand out a bit more.
hi link illuminatedWord Visual
" toggle word illumination.
let g:Illuminate_highlightUnderCursor = 0
nnoremap <leader>it :IlluminationToggle<cr>
" }}}

" }}}

" Software Development: Languages {{{

" Clojure {{{

" Acid
" Asynchronous Clojure Interactive Development
" https://github.com/clojure-vim/acid.nvim
" Plug 'clojure-vim/acid.nvim', { 'do': ':UpdateRemotePlugins' }

" }}}

" Golang {{{

" https//golang.org
"
" Install golang:
" 1. Get the binary pkg from the .org site and install it. The homebrew
" install is not official and is not recommended.
"
" Create the directories & requisite environment variables:
" 1. mkdir -p workspace/go/src workspace/go/bin workspace/go/pkg
" 2. export GOPATH=$HOME/workspace/go
" 3. export GOROOT=/usr/local/go
" 4. export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
" 5. Add the variables to .zshrc

" Install Golang utilities:
" go get -u github.com/nsf/gocode
" go get -u github.com/alecthomas/gometalinter
" go get -u github.com/rogpeppe/godef
" go get -u golang.org/x/tools/cmd/goimports
" go get -u github.com/jstemmer/gotags
" go get github.com/matryer/moq
" go get -u github.com/zmb3/gogetdoc
" go get -u golang.org/x/tools/cmd/guru
" go get -u golang.org/x/lint/golint
" go get github.com/fatih/gomodifytags

" vim-go
" https://github.com/fatih/vim-go
" There are A LOT of commands in vim-go:
"   * :GoAddTags + :GoRemoveTags - modify/update field tags in a structs.
Plug 'fatih/vim-go'
let g:go_version_warning = 0
" let g:go_bin_path="$HOME/workspace/go/bin/"
let g:go_bin_path="/Users/ebodine/workspace/go/bin/"

" deoplete-go
" https://github.com/zchee/deoplete-go
" deoplete.nvim source for Go. Asynchronous Go completion for Neovim.
Plug 'zchee/deoplete-go', {'do': 'make'}

" }}}

" Python {{{
"
" Setup: Using ipython in a terminal:
" - The biggest problem is creating multiline (more than 2 lines) code in
"   ipython.
"   Create an ipython config file to turn on vi mode:
"      echo "c.TerminalInteractiveShell.editing_mode = 'vi'" \
"      >>~/.ipython/profile_default/ipython_config.py
" - You need to have miniconda in the PATH and have installed ipython
" - You need to `source activate <env>` to get the correct environment.
" - Configure your terminal binding to use <leader><ESC> to Escape to Normal
"   mode.  You can then use <Esc>o to create a new line in ipython.
" - Start up ipython in a terminal and enjoy.

" deoplete source for Jedi/Python
" https://github.com/zchee/deoplete-jedi
Plug 'zchee/deoplete-jedi'

" jedi-vim
" https://github.com/davidhalter/jedi-vim
Plug 'davidhalter/jedi-vim'
" Show the function signatures in the commandline.
let g:jedi#show_call_signatures = 2
" We want to use deoplete-jedi for completion.
let g:jedi#completions_enabled = 0

" vim-conda
" https://github.com/cjrh/vim-conda
" Support python development using Conda env manager
Plug 'cjrh/vim-conda'

" impsort.vim - sensibly sort imports
" https://github.com/tweekmonster/impsort.vim
" Utility for sorting and highlighting Python imports.
" We'll see if this is any better than using isort.
Plug 'tweekmonster/impsort.vim'
let g:impsort_textwidth = 104
" so that the linter doesn't complain.
let g:impsort_lines_after_imports = 2
" run impsort on save.
autocmd BufWritePre *.py ImpSort!

" vim-python-pep8-indent
" https://github.com/Vimjas/vim-python-pep8-indent
Plug 'Vimjas/vim-python-pep8-indent'

" Syntax highlighting - PaperColor scheme targets this syntax file specifically
" https://github.com/hdima/python-syntax/
Plug 'https://github.com/hdima/python-syntax/'
let python_highlight_all = 1

" SimpylFold - No-BS Python code folding
" https://github.com/tmhedberg/SimpylFold
Plug 'tmhedberg/SimpylFold'

" Python textobjects
" https://github.com/bps/vim-textobj-python
"
" This is a Vim plugin to provide text objects for Python functions and
" classes. It provides the following objects:
"     af: a function
"     if: inner function
"     ac: a class
"     ic: inner class
"
" It also provides a few motions in normal and operator-pending mode:
"     [pf / ]pf: move to next/previous function
"     [pc / ]pc: move to next/previous class
Plug 'bps/vim-textobj-python'

" }}}

" Ruby {{{

" vim-ruby
" https://github.com/vim-ruby/vim-ruby
" Ruby configuration
Plug 'vim-ruby/vim-ruby'

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

" Vagrant files need to be set to Ruby filetype.
augroup ft_vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set ft=ruby
augroup END
" }}}

" Web development - Javascript, CSS, HTML, etc. {{{
"Plug 'rstacruz/vim-hyperstyle'

" Colorizer
" https://github.com/chrisbra/Colorizer
" Highlight color codes inside CSS and Html files.
Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html'

" HTML {{{

" html5.vim
" https://github.com/othree/html5.vim
Plug 'othree/html5.vim'
let g:html5_rdfa_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
" }}}

" }}}

" }}}

" Miscellaneous File Types {{{

" ansible-vim {{{
" https://github.com/pearofducks/ansible-vim
Plug 'pearofducks/ansible-vim'
" }}}

" Dockerfile {{{
" https://github.com/ekalinin/Dockerfile.vim
" NOTE: No docs for this plugin.
Plug 'ekalinin/Dockerfile.vim'
" }}}

" vim-jinja {{{
"https://github.com/mitsuhiko/vim-jinja
" Jinja2 is a full featured template engine for Python - http://jinja.pocoo.org/
Plug 'mitsuhiko/vim-jinja'
" }}}

" JSON {{{
" vim-json
" https://github.com/elzr/vim-json
" NOTE: If the json file doesn't look right, check the concealcursor value
" problem mentioned in the github README.
Plug 'elzr/vim-json'
" }}}

" Markdown {{{

" NOTE: Wed Sep 20 11:24:32 - commenting out while trying the gabrielelana
" version of vim-markdown
" " vim-markdown
" " https://github.com/tpope/vim-markdown
" Plug 'tpope/vim-markdown'
" " Make sure that .md file get detected as Markdown
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" let g:markdown_minlines = 100

" vim-markdown
" https://github.com/gabrielelana/vim-markdown
" Not the tpope version
" NOTE: Mon Feb 25, 2019 4:17:32pm - Really slow for big *.md files, trying to
" see if disabling folding will help things.
Plug 'gabrielelana/vim-markdown'
let g:markdown_include_jekyll_support = 0
let g:markdown_enable_conceal = 1
" let g:markdown_enable_folding = 1

" }}}

" vim-polyglot {{{
" Various language packs for vim.
" https://github.com/sheerun/vim-polyglot
" A best-of-breed collection of programming language syntax,indent,ftplugin
" config files.
" ** HAS TO COME AFTER LANGUAGE DEFINITIONS THAT YOU HAVE DISABLED BELOW **
" ** HAS CONFLICTS WITH VIM-GO - https://github.com/fatih/vim-go/issues/2045 **
Plug 'sheerun/vim-polyglot'
" I prefer my own configuration of Python, Markdown and Golang
let g:polyglot_disabled = ['go', 'python', 'markdown']
let g:markdown_fenced_languages = ['bash=sh', 'css', 'django', 'javascript', 'js=javascript', 'json=javascript', 'perl', 'php', 'python', 'ruby', 'sass', 'xml', 'html', 'vim']
" }}}

" Version Control -------------------------------------------------- {{{

" vim-fugitive + vim-merginal + vim-rhubarb - Git management  {{{

" Git porcelain in Neovim/Vim comes primarily in the form of
" vim-fugitive, vim-magit & vim-gina.  Unfortunately, none are of the caliber
" of Emacs magit ... sigh.
"
" Gina:
"   - requires a 2 command workflow => =Gina status= & =Gina commit=
"
" Vim Magit:
"   - can lock up on large commits, doesn't seem to be async
"   - can show you the status of everything in current repo.
"   - operations are from a =status= buffer.
"
" Vim Fugitive Vim Rhubarb GV Merginal:
"   -

" gina
" https://github.com/lambdalisue/gina.vim
" Gina.vim (gina) is a plugin to asynchronously control git repositories.
Plug 'lambdalisue/gina.vim'

" vim-fugitive {{{
" https://github.com/tpope/vim-fugitive
"
" :Gstatus - Brings up output of git status {{{
"    g?    show this help
"    <C-N> next file
"    <C-P> previous file
"    <CR>  |:Gedit|
"    -     |:Git| add
"    -     |:Git| reset (staged files)
"    ca    |:Gcommit| --amend
"    cc    |:Gcommit|
"    ce    |:Gcommit| --amend --no-edit
"    cw    |:Gcommit| --amend --only
"    cva   |:Gcommit| --verbose --amend
"    cvc   |:Gcommit| --verbose
"    cf    |:Gcommit| --fixup=
"    cs    |:Gcommit| --squash=
"    cA    |:Gcommit| --edit --squash=
"    =     toggle inline diff
"    <     show inline diff
"    >     hide inline diff
"    D     |:Gdiff|
"    ds    |:Gsdiff|
"    dp    |:Git!| diff (p for patch; use :Gw to apply)
"    dp    |:Git| add --intent-to-add (untracked files)
"    dv    |:Gvdiff|
"    gO    |:Gvsplit|
"    O     |:Gtabedit|
"    o     |:Gsplit|
"    P     |:Git| add --patch
"    P     |:Git| reset --patch (staged files)
"    s     |:Git| add
"    u     |:Git| reset
"    X     |:Git| checkout
"    X     |:Git| checkout HEAD (staged files)
"    X     |:Git| clean (untracked files)
"    X     |:Git| rm (unmerged files)
"    q     close status
"    R     reload status
"    . enter |:| command line with file prepopulated
" }}}

" :Gblame - Brings up an interactive vertical split with git blame output {{{
"     g?    show this help
"     A     resize to end of author column
"     C     resize to end of commit column
"     D     resize to end of date/time column
"     q     close blame and return to blamed window
"     gq    q, then |:Gedit| to return to work tree version
"     <CR>  q, then open commit
"     o     open commit in horizontal split
"     O     open commit in new tab
"     p     open commit in preview window
"     -     reblame at commit
"     ~     reblame at [count]th first grandparent
"     P reblame at [count]th parent (like HEAD^[count])
" }}}

" :Gcommit - Brings up a split window to obtain a commit message.  A :wq or
"            :Gwrite will write the commit and close the window.

" :Gdiff / :Gsdiff / :Gvdiff - vimdiff / vimdiff split horizontally / vimdiff
"                              split vertically

" :Gbrowse - Open the current file, blob, tree, commit or tag in your browser
"            at the hosting provider.  vim-rhubarb provides Github access.
Plug 'tpope/vim-fugitive'
" }}}

" Merginal {{{
" https://github.com/idanarye/vim-merginal
" A fugitive extension to manage and merge Git branches through a nice interface
"   - Viewing the list of branches
"   - Checking out branches from that list
"   - Creating new branches
"   - Deleting branches
"   - Merging branches
"   - Rebasing branches
"   - Solving merge conflicts
"   - Interacting with remotes(pulling, pushing, fetching, tracking)
"   - Diffing against other branches
"   - Renaming branches
"   - Viewing git history for branches
Plug 'idanarye/vim-merginal'
nnoremap <silent> <leader>gm :MerginalToggle<CR>
" }}}

" vim-rhubarb {{{
" GitHub extension for fugitive
" https://github.com/tpope/vim-rhubarb
" Provides :Gbrowse functionality as well as being able to use
" |i_CTRL-X_CTRL-O| to omni-complete GitHub issues or project collaborator
" usernames when editing a commit message.
Plug 'tpope/vim-rhubarb'
" }}}

nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Gpush<CR>
nnoremap <silent> <leader>gr :Gremove<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gu :Gbrowse<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>

" }}}

" vim-gitgutter - show git diff in the gutter {{{
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" set update time - gitgutter recommends 100
set updatetime=100

" both of these work with repeat.vim
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Preview a hunks changes
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" text objects that operate on hunks
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

" have gitgutter ignore whitespace
let g:gitgutter_diff_args = '-w'

" Set the maximum number of signs to show in a buffer.
let g:gitgutter_max_signs = 2500

"symbols
let g:gitgutter_sign_added = "✚"
let g:gitgutter_sign_modified = "✹"
let g:gitgutter_sign_removed = "✖"
let g:gitgutter_sign_modified_removed = "✖"
" }}}

" gv - view git commits {{{
" https://github.com/junegunn/gv.vim
Plug 'junegunn/gv.vim'

" commit browser for repo
nnoremap <silent> <leader>gva :GV<cr>
" commit browser for current file only
nnoremap <silent> <leader>gvc :GV!<cr>
" commit browser for current file in location list.
nnoremap <silent> <leader>gvl :GV?<cr>
" }}}

" vimagit - A Vim implementation of the awesome Emacs magit {{{
" https://github.com/jreybert/vimagit
" Fri Feb 1 2019 - Commented out in favor of vim-fugitive
"
" Local mappings:
"   - <cr> on a file will hide/unhide diffs
"   - zc hide diffs on a file
"   - zo unhide diffs on a file
"   - +,-,0  enlarge,shrink,reset the diff context
"   - S stage/unstage hunk or stage/unstage whole file depending on cursor
"       position.
"   - F stage/unstage the whole file at cursor position
"   - CC from `stage mode` set commit mode
"        :w, :x, :wq, ZZ will commit all staged changes
"   - I  add the file under the cursor position to gitignore
"   - R  refresh the magit buffer
"   - ?  Toggle help showing in magit buffer.
" Plug 'jreybert/vimagit'
" nnoremap <silent><leader>vv :MagitOnly<cr>
" vimagit is pretty dumb from a performance perspective and has a really hard
" time with files that lots of diffs or really long lines.
" let g:magit_default_fold_level = 0
" }}}

" }}}

" Terminal: {{{

" Terminal Settings {{{
" NOTE: Neither of these seems to work?? Wed Oct 24, 2018 5:30:24pm
" 	Only works when I set the highlight from the statusline??
" highlight TermCursor ctermfg=red guifg=red
au TermOpen :highlight TermCursor ctermfg=red guifg=red

" No line numbers in terminals.
" We also have to tell acitve-numbers to ignore Terminals as well.  There is
" no =terminal= filetype so we have to do it this way.
augroup TerminalStuff
   au!
   autocmd TermOpen * setlocal nonumber norelativenumber
   autocmd TermOpen * ActiveNumbersIgnore | setlocal nonumber norelativenumber
augroup END

" Keep terminal splits below and to the right.
set splitbelow
set splitright

" Start in insert mode not normal mode.
" Mon Sep 18 11:44:23 2018 - commented out, this makes me lose place when
" going in and out of the terminal.
" :au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Set the terminal scrollback to the maximum.
" https://stackoverflow.com/questions/34009064/how-do-i-set-the-terminal-buffer-scrollback-size
" It seems that 100000 is the maximum.
set scrollback=100000
" }}}

" neoterm {{{
" https://github.com/kassio/neoterm
" Wrapper of some neovim's :terminal functions.
" NOTE: Can we use neoterm to send python code/selection to the terminal?
Plug 'kassio/neoterm'
let g:neoterm_open_in_all_tabs=0
let g:neoterm_repl_python="ipython"

" Use gn{text-object} in normal mode
nmap gn <Plug>(neoterm-repl-send)
" Send selected contents in visual mode.
xmap gn <Plug>(neoterm-repl-send)
" Send line
nmap gnl <plug>(neoterm-repl-send-line)

" }}}

" Terminal Mappings {{{

" switch back to Normal mode this way so as to allow for ipython.
tnoremap <leader><Esc> <C-\><C-n>
" }}}

" }}}

" Appearances: {{{
" Themes, airline, devicons, etc.

" Squeeze out all of the color that we can.
set t_Co=256   " This is may or may not needed.

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Support for true color terminal.
" Used to be a env variable
if (has("termguicolors"))
    set termguicolors
endif

" xterm color table & other color related things
Plug 'guns/xterm-color-table.vim'

" winresizer {{{
" https://github.com/simeji/winresizer
" Easy resizing of windows in side vim. Ctrl-e starts the window resize mode
" and Enter or Esc exits it.
" NOTE: 8/19/2017 - screen redraw in Neovim is killing any resize?!?
"       8/23/2017 - nope, this was unique to Tagbar & the equalalways option.
Plug 'jimsei/winresizer'
let g:winresizer_vert_resize=3
let g:winresizer_horiz_resize=3
" I want to use CTRL-W_e to trigger the resize.
let g:winresizer_start_key='<C-w>e'
let g:winresizer_gui_start_key='<C-w>e'
" }}}

" vim-choosewin - as close to ace-window as we get. {{{
" https://github.com/t9md/vim-choosewin
" TODO: Create FR/PR for adding = key to equalize windows
" Some bindings:
"   Move between tabs using ] and [
"   Move to first tab - 0
"   Move to last tab - $
"   Close current tab - x
Plug 't9md/vim-choosewin'
" overlay the window shortcuts
" let g:choosewin_overlay_enable = 1
" Turn off the blink when we land on the window.  I find this annoying, it
" makes me think something is wrong with redraw.
let g:choosewin_blink_on_land = 0
" Shade the windows a little bit when overlay enabled.
let g:choosewin_overlay_shade = 1
nmap  -  <Plug>(choosewin)

" nerdtree_choosewin
" https://github.com/weilbith/nerdtree_choosewin-plugin
Plug 'weilbith/nerdtree_choosewin-plugin'
" }}}

" Themes {{{
Plug 'tomasr/molokai'
Plug 'NLKNguyen/papercolor-theme'

" gotham
" https://github.com/whatyouhide/vim-gotham
" Also has an airline theme as well:
"   gotham
"   let g:gotham_airline_emphasised_insert = 0
" Plug 'whatyouhide/vim-gotham'
" }}}

" Statuslines:
" There are a number of different options: powerline, airline, lightline, etc.
" 1. lightline - https://github.com/itchyny/lightline.vim
"   - Mon Jun 25 4:57:32pm 2018
"     Appears to be faster(?) in normal operation - startup is not faster.
"     A LOT less information on the statusline that you then have to configure
"     yourself.
" 2. powerline - much too much and slow.
" 3. airline - is a good middle ground for me.

" vim-airline {{{
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/paranoida/vim-airlineish'
Plug 'vim-airline/vim-airline-themes'

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'" enable integration with ale
let g:airline#extensions#ale#enabled=1
" " need to enable this for vim-devicons
let g:airline_powerline_fonts = 1
" }}}

" VimDevIcons - add glyphs/icons to plugins {{{
" https://github.com/ryanoasis/vim-devicons
" Goes at the end so that any preceding plugins can take advantage of it.
" For Mac:
" 1. Install the Nerd fonts via Homebrew
"    - $ brew tap caskroom/fonts
"    - $ brew cask install font-hack-nerd-font
" 2. Install a patched font from http://nerdfonts.com/
"    - I chose RobotoMono.zip; scroll down the page to Downloads
" 3. Unzip the font, click on Complete font to install
" 4. Edit Profiles in iTerm2 and change to Roboto Nerd font
" NOTE: vim-devicons has to be installed last in order to work properly with airline, etc.
Plug 'ryanoasis/vim-devicons'
" }}}
" }}}

" Conclude plugin initialization.
call plug#end()
filetype plugin indent on
syntax enable

" colorschemes {{{
" Turn on different colorschemes for gui or terminal.
" NOTE: This has to be after the `plug#end & syntax enable` above.
if has('gui_running') || has('gui_vimr')
    set background=light
    colorscheme PaperColor
    let g:airline_theme='papercolor'
else
    set background=dark
    colorscheme molokai
    let g:airline_theme='airlineish'
endif

" comments should always be in italics
highlight Comment cterm=italic
" }}}

" General Mappings: {{{

" Some general leader mappings. {{{
" Kill all of the open currently open buffers.
nnoremap <leader>bd :bufdo bd<cr>
" }}}

" Disable some bindings that I find annoying & potentially dangerous if hit
" accidentally.
" ZZ - save and close Vim
" ZQ - close Vim
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" A test to see if i could map the MacOSX Command key
" Friday July 6 2018 - Is working in Vimr
" Saturday December 29, 2018 - Won't work in iTerm2
" nnoremap <D-l> :echo "testing"<cr>

" Edit Neovim configuration file.
nnoremap <silent> <leader>ec :e $MYVIMRC<cr>

" toggle between line numbers, relative line numbers and no numbers.
nnoremap <silent> <leader>nn :exec &nu==&rnu? "se nu!" : "se rnu!"<cr>

" Exit Neovim
nnoremap <leader>q :qa<cr>

" quick save
nnoremap <leader>w :w!<cr>

" Make D behave
nnoremap D d$
" Yank to the end of the line.
nnoremap Y y$
" U is a better redo
nnoremap U <C-r>

" make vv act like V
nnoremap vv 0v$

" Windows
" Ease the window split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" follow lines that wrap.
" NOTE: 8/24/2014 - these 2 mappings resulted in the following message on nvim
"                   startup.
" Key 'j' is already mapped in mode 'n'
" Key 'k' is already mapped in mode 'n'
" NOTE: 4/7/2018 - Same errors as above, this is probably because Arpeggio is
" doing a remap of j + k
" nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
" nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" cmdline mappings
cmap <c-a> <home>
cmap <c-e> <end>

" Remap VIM 0 to first non-blank character
map 0 ^

" Omni completion remap
inoremap <C-l> <C-x><C-l>
" Delete the previous word.
inoremap <C-b> <C-O>diw

" Quit vimdiff using q but also don't mess with macro.
nnoremap <expr> q &diff ? ":diffoff!\<bar>only\<cr>" : "q"

" Use Q to play macro normally and over visual selections.
xnoremap Q :'<,'>:normal @q<CR>

" }}}

" Because, for some reason, this doesn't work until after neobundle#end or
" plug#end
call arpeggio#load()
Arpeggioinoremap jk <Esc>:
Arpeggionnoremap jk :

" Appbreviations {{{
" NOTE: You can make filetype/bufferlocal abbreviations by adding the
"       following to a ftplugin/<filetype>.vim file:
"   	  iab <buffer> ebx erick.bodine
iab sb " {{{
iab eb " }}}
iab ydate <c-r>=strfitime("%a %b %d %T %Y")
" }}}

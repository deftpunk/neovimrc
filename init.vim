" vim: ft=vim nu fdm=marker
"
"                  A vimrc for the Emacs RSI emigrant
"                          Author: deftpunk
"
" Investigations: {{{
" Some plugins to check out in the future & notes on comparing classes of
" plugins.
"
" figlet: adein/vim-figlet
"
" nvim-jqx
" https://github.com/gennaro-tedesco/nvim-jqx
"
" ultest - more/better unit test running
" https://github.com/rcarriga/vim-ultest

" Poor mans ipython.
" https://www.reddit.com/r/neovim/comments/axilbq/using_nvim_as_python_ide_via_pynvim/ehu2fa2
"
" Sat Feb 08 2020 21:24:57 - removing dasht
" " https://github.com/sunaku/vim-dasht
" Was not as intuitive as I would have liked, as a result, I never really used
" it.
"
" Mon Apr 1, 2019 6:05:34pm - mostly usablem not yet entirely stable.
" Sat Aug 17 2019 21:05:52 - coc.vim not fully functional.
" coc.vim - https://github.com/neoclide/coc.nvim - better(?) completion w/ LSP
"   Using python (pyls) or other client - https://github.com/neoclide/coc-pyls/issues/5
"   https://www.reddit.com/r/neovim/comments/ay14vz/show_use_neovim_floating_window_instead_of/
"   https://github.com/ncm2/float-preview.nvim/issues/1#issuecomment-470524243
"
" http://liuchengxu.org/vista.vim/ - a new and improved tagbar using LSP.
" Mon Dec 02 2019 22:22:37 - I can never get this to display properly with
" python code.
"
" https://github.com/liuchengxu/vim-clap - a more performant finder/searcher
" Sat Feb 01 2020 22:47:43 - bcommit & commits still not implemented...
"
" https://gitlab.com/HiPhish/repl.nvim
" https://github.com/svermeulen/vim-subversive - operator motions to quickly
" replace text.
" https://github.com/svermeulen/vim-yoink - maintain a yank history to cycle
" between when pasting.
" https://github.com/Yilin-Yang/vim-markbar - show marks, maybe better than
"                                             vim-bookmarks.
" https://github.com/reconquest/vim-pythonx - python tools for easier coding.
" https://github.com/numirias/semshi - semantic python hightlighting.
" https://github.com/mjbrownie/GetFilePlus - possible help for python gf

" https://github.com/ludovicchabant/vim-gutentags - Tags management.
" let g:gutentags_project_root = ['package.json', 'package.yaml', 'Cargo.toml']
" This makes gutentags magically respect gitignore because ripgrep does so
" let g:gutentags_file_list_command        = 'rg --files'
" let g:gutentags_exclude_filetypes        = ['haskell', 'markdown']
" let g:gutentags_ctags_exclude_wildignore = 1
" let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')"
" Use the following command to clear the cache quickly:
" command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')
" let g:gutentags_generate_on_new = 1
" let g:gutentags_generate_on_missing = 1
" let g:gutentags_generate_on_write = 1
" let g:gutentags_generate_on_empty_buffer = 0
" Explaining --fields=+ailmnS (info gathered from: $ ctags --list-fields)
"     a: Access (or export) of class members
"     i: Inheritance information
"     l: Language of input file containing tag
"     m: Implementation information
"     n: Line number of tag definition
"     S: Signature of routine (e.g. prototype or parameter list)
" let g:gutentags_ctags_extra_args = [
"       \ '--tag-relative=yes',
"       \ '--fields=+ailmnS',
"       \ ]
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/

" https://github.com/chrisbra/csv.vim - CSV files
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
" https://github.com/thaerkh/vim-workspace - a single plugin for
" sessions+obsession+prosession+fuzzy
"
" https://github.com/diepm/vim-rest-console - A REST API console for vim
"
" Need to see if this will bring Emacs style abbreviations, e.g. C-x a i g
" https://github.com/omrisarig13/vim-auto-abbrev
"
" https://github.com/jeetsukumaran/vim-pythonsense
"
" Finished:
" Thursday Jan 3, 2019
" https://github.com/terryma/vim-smooth-scroll
" I can do without the smooth scrolling.
"
" Tuesday March 5, 2019
" https://github.com/mcchrish/nnn.vim - a possible replacement for NERDTree
" Not really a full-featured replacement.
"
" https://github.com/kana/vim-niceblock - Visual Block extras.
" Functionality is filled in elsewhere.

" }}}

" Options -------------------------------------------------------- {{{

" neovim-remote
" Avoid nested neovim processes by using neovim-remote. This should have been
" installed prior to Neovim.
if has('nvim')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif

if has('macunix')
	let g:python3_host_prog="/Users/ebodine/miniconda3/bin/python3"
	let g:python_host_prog="/Users/ebodine/miniconda3/bin/python"
elseif has('unix')
	let g:python3_host_prog="/usr/bin/python3"
	let g:python_host_prog="/usr/bin/python"
endif

" THis is a generic - and somewhat lazy - usage of path.  You can be much more
" specific.
set path=.,**

set hidden

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

" Search is incremental by default but dont keep the highlight around.
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
if has('macunix')
    let s:mac_directory = "/Users/ebodine/.config/nvim/neovim-undo-dir"
    if !isdirectory(s:mac_directory)
	call mkdir(s:mac_directory, "", 0700)
    endif
    execute "set undodir=".s:mac_directory
elseif has('unix')
    let s:unix_directory = "/home/erickb/tmp/neovim-undo-dir"
    if !isdirectory(s:unix_directory)
	call mkdir(s:unix_directory, "", 0700)
    endif
    execute "set undodir=".s:unix_directory
endif

set undofile

" Automatically write files.
set autowrite
set autowriteall

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
let g:maplocalleader = ','

" }}}

" General Autocommands -------------------------------------------- {{{

autocmd BufEnter * :syntax sync fromstart

" Automatically equalize splits when Vim is resized.
autocmd VimResized * wincmd =

" Enable functional autosave and autoread behaviour.
" https://bluz71.github.io/2017/05/15/vim-tips-tricks.html
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
"
" There are plugins installed further down that are specific for file types.

" targets.vim
" https://github.com/wellle/targets.vim
" Vim plugin that provides additional text objects
"   - Pair text objects
"   - Quote text objects
"   - Separator text objects
"   - Argument text objects
Plug 'wellle/targets.vim'

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

" vim-wordmotion {{{
" Expands the definition of a word.
" https://github.com/chaoren/vim-wordmotion
" --------------------------------------------------
"      word            	      Example
" --------------------------------------------------
" Camel case words     	    [Camel][Case]
" Acronyms             	    [HTML]And[CSS]
" Uppercase words      	    [UPPERCASE] [WORDS]
" Lowercase words      	    [lowercase] [words]
" Hexadecimal literals 	    [0x00ffFF] [0x0f]
" Binary literals      	    [0b01] [0b0011]
" Regular numbers      	    [1234] [5678]
" Other characters     	    [~!@#$]
" --------------------------------------------------
Plug 'chaoren/vim-wordmotion'
" }}}

" }}}

" Navigation ------------------------------------------------------------- {{{

" Navigation Plugins:
" 1. Denite 1/31/2019 - not fast enough to work w/ Linux Kernel codebase.
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
"    - tags but requires ctags
"    - MRU is a different command - no mixed results, that I can see.
"    - Lines+BLines Does work with jumplist.
"
" 5. vim-clap
"
" 6. telescope

" FZF {{{
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'

" https://github.com/pbogut/fzf-mru.vim
" Command - :FZFMru
Plug 'pbogut/fzf-mru.vim'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Modify the git log commeand.
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

" Augment the Rg command with a preview window.
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Mappings:
" search lines in buffer.
nmap <leader>s :BLines<cr>
" list open buffers.
nmap <leader>i :Buffers<cr>
" search files.
nmap <leader>f :Files<cr>
nmap <leader>F :Gfiles<cr>
nmap <leader>M :FZFMru<cr>
" search file contents using ripgrep.
nmap <leader>r :Rg<cr>
" Search help files.  See General mappings below & filetype/help.vim for other
" Help related mappings.
nnoremap <leader>he :Helptags<cr>
" }}}

" https://github.com/nvim-telescope/telescope.nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" vim-easymotion {{{
" Moving around in a buffer like ace-jump and avy.
" https://github.com/easymotion/vim-easymotion
" }}}
Plug 'easymotion/vim-easymotion'

" ListToggle {{{
" Toggle location & quickfix windows.
" https://github.com/Valloric/ListToggle
" }}}
Plug 'Valloric/ListToggle'

" nvim-gqf {{{
" https://github.com/kevinhwang91/nvim-bqf
" Make Neovim's quickfix window better.
" }}}
Plug 'kevinhwang91/nvim-bqf'

" nvim-treesitter {{{
" https://github.com/nvim-treesitter/nvim-treesitter
" Provide a simple and easy way to use the interface for tree-sitter in
" Neovim and to provide some basic functionality such as highlighting based
" on it:
" }}}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" }}}
"
" Completion {{{

" " deoplete {{{
" " https://github.com/Shougo/deoplete.nvim
" " Dark powered asynchronous completion framework for neovim/Vim8
" " Need to make sure that pynvim is installed.
" " pip3 install --user --upgrade pynvim
" Tue Feb 16 2021 17:06:12 - commented out this is a nvim-lspconfig
" dependency.
" " }}}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" " deoplete-lsp
" " https://github.com/deoplete-plugins/deoplete-lsp
" Plug 'deoplete-plugins/deoplete-lsp'

" " }}}

" General Utilities -------------------------------------------------------- {{{

" vim-abolish {{{
" https://github.com/tpope/tpope-vim-abolish
" Abbreviate multiple variants of words
"
" Abbreviate:
" :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
"
" Substitution:
" :%Subvert/facilit{y,ies}/building{,s}/g
"
" Coercion:
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

if has('macunix')
    let g:abolish_save_file="/Users/ebodine/.config/nvim/abolish-abbreviations.vim"
elseif has('unix')
    let g:abolish_save_file="/home/erickb/.config/nvim/abolish-abbreviations.vim"
endif
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

" AnsiEsc {{{
" https://github.com/powerman/vim-plugin-AnsiEsc
" Conceal or highlight ansi escape sequences.  This is a fork of the original
" with some improvements.
Plug 'powerman/vim-plugin-AnsiEsc'
" }}}

" Ale - async syntax checking {{{
" https://github.com/w0rp/ale
" Plug 'w0rp/ale'
" let g:ale_sign_error = '✗'
" let g:ale_sign_warning = '≈'
" let g:ale_linters = {
" \    'python': ['flake8', 'pylint'],
" \    'rust': [ 'cargo', 'rls', 'rustc', 'clippy', 'rustfmt' ],
" \    'clojure': ['clj-kondo', 'joker'],
" \}

" " Python flake8 + Ale
" if has('macunix')
"     let g:ale_python_flake8_options = '--config=/Users/ebodine/.flake8'
" elseif has('unix')
"     let g:ale_python_flake8_options = '--config=/home/erickb/.flake8'
" endif

" let g:ale_emit_conflict_warnings = 0
" let g:ale_list_window_size = 15
" }}}

" arpeggio {{{
" https://github.com/kana/vim-arpeggio
" keychords for vim. You cant create heirarchies with this unlike key-chord in
" Emacs. It is initialized after the plug#end statement.
Plug 'kana/vim-arpeggio'
" }}}

" vim-auto-abbrev {{{
" https://github.com/omrisarig13/vim-auto-abbrev
" TODO: Look at changing/modifying the mapping.
" '<leader>aa' - call AutoAbbrevAddCurrentWord
" '<leader>al' - call AutoAbbrevAddCurrentLhsWord
" '<leader>ar' - call AutoAbbrevAddCurrentRhsWord
" '<leader>ae' - call AutoAbbrevReload
Plug 'omrisarig13/vim-auto-abbrev'
let g:auto_abbrev_file_path = '~/.config/nvim/abbreviates'
" }}}

" vim-bbye - {{{
" https://github.com/moll/vim-bbye
" Handle deleting buffers and closing files.
Plug 'moll/vim-bbye'
" Buffer delete
nnoremap <leader>k :Bdelete<cr>
" }}}

" delimitMate {{{
" auto quotes, parens, brackets
" https://github.com/raimondi/delimitMate
" NOTE: Another pairs plugin to try - https://github.com/jiangmiao/auto-pairs
Plug 'raimondi/delimitMate'
" }}}

" DirDiff - diff directories {{{
" https://github.com/will133/vim-dirdiff
" Usage
"   :DirDiff <dir1> <dir2>
Plug 'will133/vim-dirdiff'
" Exclude python compiled files & some image files that i dont care about.
let g:DirDiffExcludes="*.pyc,*.class,*.exe,*.swp,*.pyo,*.jpg,*.jpeg"
" Ignore whitespace differences and ignore the .git/ directory.
let g:DirDiffAddArgs="-w --exclude=direxclude -r .git"
" }}}

" vim-eunuch
" https://github.com/tpope/vim-eunuch
Plug 'tpope/vim-eunuch'

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

" Search And Replace Plugins: {{{
"
" Tue Oct 08 2019 19:43:23 - I haven't used any of these since installing and
" trying them out.  The best is probably ctrlsf.
"
"   1. far.vim - https://github.com/brooth/far.vim
"       - Edit mode, in the sense that you enter the replace with pattern on
"         the commandline.
"       - ripgrep support
"       - Asynchronous on Neovim without using Dispatch.
"       - undo doesn't always undo - known bug
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
"
" }}}

" indentLine {{{
" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '┆'
let g:indentLine_indentLevel = 6
let g:indentLine_fileType = ['python', 'perl', 'go', 'rust', 'nim']
" }}}

" vim-lastplace {{{
" https://github.com/farmergreg/vim-lastplace
" Remember your last location in a file.
" - Folds are automatically opened when jumping to the last edit position
" - Center the cursor vertically after restoring last edit position.
" - Keep as much of the file on screen as possible when last edit position is
"   at the end of the file.
Plug 'farmergreg/vim-lastplace'
" }}}

" vim-easy-align {{{
" https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" NERDTree {{{
" https://github.com/scrooloose/nerdtree.git
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
let g:NERDTreeGitStatusUpdateOnCursorHold = 0
let g:NERDTreeGitStatusUpdateOnWrite      = 0
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

" Sort naturally, e.g. z11.txt follows z10.txt NOT after z100.txt
let NERDTreeNaturalSort=1
" Turn off the ? help at the top.
let NERDTreeMinimalUI=1
" SHow hidden files/directories, can be toggled with I in NERDTree
let NERDTreeShowHidden=1
" Automatically remove a buffer when a file is deleted in NERDTree
let NERDTreeAutoDeleteBuffer=1

let NERDTreeIgnore=['\~$', '\.pyc$', '\.o$', '\.pyo$', '\.class$', '\.swp$']

nnoremap <leader>nt :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html
" One inconvenience is that NERDTree, by default, will not refresh itself when
" one enters the file-tree window. For instance, it won’t display new files
" not created within NERDTree unless a manual refresh is executed. This can be
" overcome with the following auto-refreshing snippet:
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" nerdtree-syntax-highlight
" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
" This is intended to be used with vim-devicons to add color to icons or
" entire labels
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" }}}

" open-browser {{{
" https://github.com/tyru/open-browser.vim
" Open a broser from Neovim - I mostly use this to start a web search from
" Neovim.  It opens your default browser.
Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

" asyncrun.vim {{{
" Run Async Shell Commands in Vim 8.0 / NeoVim and Output to Quickfix Window
" https://github.com/skywind3000/asyncrun.vim
" There are two vim commands: :AsyncRun and :AsyncStop to control async jobs.
"
" :AsyncRun[!] [options] {cmd} ...
" Run shell command in background and output to quickfix. when ! is included,
" auto-scroll in quickfix will be disabled. Parameters are splited by space, if
" a parameter contains space, it should be quoted or escaped as backslash +
" space (unix only).
"
" Parameters accept macros start with '%', '#' or '<' :
"
" %:p     - File name of current buffer with full path
" %:t     - File name of current buffer without path
" %:p:h   - File path of current buffer without file name
" %:e     - File extension of current buffer
" %:t:r   - File name of current buffer without path and extension
" %       - File name relativize to current directory
" %:h:.   - File path relativize to current directory
" <cwd>   - Current directory
" <cword> - Current word under cursor
" <cfile> - Current file name under cursor
" <root>  - Project root directory
Plug 'skywind3000/asyncrun.vim'

" Open the quickfix window at least 12 lines.
let g:asyncrun_open = 12
" Disable python stdout buffering
" https://github.com/skywind3000/asyncrun.vim/wiki/FAQ#cant-see-the-realtime-output-when-running-a-python-script
" To execute a python script:
"   :AsyncRun -raw python %:p
let $PYTHONUNBUFFERED=1
" }}}

" vim-quickrun {{{
" https://github.com/thinca/vim-quickrun
" Execute the current buffer or run commands quickly.
"
" Execute current buffer.
"  :QuickRun
"
" Execute current buffer from line 3 to line 6.
"  :3,6QuickRun
"
" Execute current buffer as perl program.
"  :QuickRun perl
"
" Execute one-liner program given from command-line.
"  :QuickRun ruby -src 'puts "Hello, world!"'
"
"  " Set shortcut keys.
"  for [key, com] in items({
"  \   '<Leader>x' : '>:',
"  \   '<Leader>p' : '>!',
"  \   '<Leader>w' : '>',
"  \   '<Leader>q' : '>>',
"  \ })
"  	execute 'nnoremap <silent>' key ':QuickRun' com '-mode n<CR>'
"  	execute 'vnoremap <silent>' key ':QuickRun' com '-mode v<CR>'
" endfor
Plug 'thinca/vim-quickrun'
let g:quickrun_config = {}
let g:quickrun_config.python = {'command': 'python'}
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
Plug 'tpope/vim-repeat'
" }}}

" incsearch.vim - Incrementally highlight search pattern matches. {{{
" https://github.com/haya14busa/incsearch.vim
" }}}
Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
" g/ Search will NOT move the cursor.
map g/ <Plug>(incsearch-stay)


" vim-obsession {{{
" Better manage the :mksession interface - see vim-prosession below.
" https://github.com/tpope/vim-obsession
" }}}
Plug 'tpope/vim-obsession'

" prosession {{{
" Leverage vim-obsession to switch between multiple sessions cleanly
" https://github.com/dhruvasagar/vim-prosession/
" }}}
Plug 'dhruvasagar/vim-prosession'

" Snippets {{{
" Using Ultisnips instead of neocomplete because neocomplete does not allow
" you to use additional snippet directories.

" Ultisnips - the ultimate snippet solution for Neovim/Vim
" https://github.com/SirVer/ultisnips
"   - youtube tutorials at the bottom of website

" Mon Dec 02 2019 21:56:48 - there are some utility scripts that ultisnips
" makes use of, e.g.
"   ~/.config/nvim/plugged/ultisnips/pythonx/UltiSnips/snippet_manager.py
" that have [#!/usr/bin/env python] at the top of the file.
" This causes problems on systems that have python & python3 installed.
"
" I got around it by moving $HOME/miniconda3/bin to the front of PATH.
" }}}
Plug 'SirVer/ultisnips'

" vim-snippets
" https://github.com/honza/vim-snippets
" }}}
Plug 'honza/vim-snippets'

" vim-fat-finger {{{
" https://github.com/chip/vim-fat-finger
" Fix common misspellings and typos.  Supports over 4,000 common misspellings.
" }}}
Plug 'chip/vim-fat-finger'

" rainbow - rainbow parentheses improved {{{
" https://github.com/luochen1990/rainbow
" }}}
Plug 'luochen1990/rainbow'

" vim-slash {{{
" https://github.com/junegunn/vim-slash
" Enhancing in-buffer search experience.
"   - Clears highlight when cursor moves.
"   - star-search: highlighting without moving.
Plug 'junegunn/vim-slash'
noremap <plug>(slash-after) zz
" }}}

" vim-surround {{{
" https://github.com/tpope/vim-surround
" Surrounding things in parens, brackets, quotes, etc. "- works with repeat.vim
" cs, ds, yss
" }}}
Plug 'tpope/vim-surround'

" tagbar {{{
" A class outline viewer
" https://majutsushi.github.io/tagbar
" }}}
Plug 'majutsushi/tagbar'

" traces {{{
" https://github.com/markonm/traces.vim
" A better way to highlight search+replace actions.  Works in more situations
" than inccomand.
" }}}
Plug 'markonm/traces.vim'

" undotree {{{
" https://github.com/mbbill/undotree
" }}}
Plug 'mbbill/undotree'

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
" }}}
Plug 'tpope/vim-unimpaired'

" vim-better-whitespace {{{
" https://github.com/ntpeters/vim-better-whitespace
" Cause trailing whitespace characters to be highlighted.  Also make stripping
" whitespace painless.
" }}}
Plug 'ntpeters/vim-better-whitespace'

" }}}

" Software Development: Utilities {{{

" Plug 'neovim/nvim-lspconfig'

" coc.nvim {{{
" https://github.com/neoclide/coc.nvim
" Intellisense engine for vim8 & neovim, full language server protocol support
" as VSCode
 Plug 'neoclide/coc.nvim', {'branch': 'release'}

 inoremap <silent><expr> <TAB>
       \ pumvisible() ? coc#_select_confirm() :
       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ coc#refresh()

 function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
 endfunction

 let g:coc_snippet_next = '<tab>'
 " Use tab for trigger completion with characters ahead and navigate.
 " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
 " inoremap <silent><expr> <TAB>
 "       \ pumvisible() ? "\<C-n>" :
 "       \ <SID>check_back_space() ? "\<TAB>" :
 "       \ coc#refresh()
 " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

 " function! s:check_back_space() abort
 "   let col = col('.') - 1
 "   return !col || getline('.')[col - 1]  =~# '\s'
 " endfunction

 " Use <c-space> to trigger completion.
 inoremap <silent><expr> <c-space> coc#refresh()

 " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
 " Coc only does snippet and additional edit on confirm.
 " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
 " Or use `complete_info` if your vim support it, like:
 " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

 " Use `[g` and `]g` to navigate diagnostics
 nmap <silent> [g <Plug>(coc-diagnostic-prev)
 nmap <silent> ]g <Plug>(coc-diagnostic-next)

 " Remap keys for gotos
 nmap <silent> gd <Plug>(coc-definition)
 nmap <silent> gy <Plug>(coc-type-definition)
 nmap <silent> gi <Plug>(coc-implementation)
 nmap <silent> gr <Plug>(coc-references)
 nmap <silent> gl :exe 'CocList outline'<cr>

 " Use K to show documentation in preview window
 nnoremap <silent> K :call <SID>show_documentation()<CR>

 function! s:show_documentation()
   if (index(['vim','help'], &filetype) >= 0)
     execute 'h '.expand('<cword>')
   else
     call CocAction('doHover')
   endif
 endfunction

 " Highlight symbol under cursor on CursorHold
 autocmd CursorHold * silent call CocActionAsync('highlight')

 " Remap for rename current word
 nmap <leader>rn <Plug>(coc-rename)

 " Remap for format selected region
 " xmap <leader>f  <Plug>(coc-format-selected)
 " nmap <leader>f  <Plug>(coc-format-selected)

 augroup mygroup
   autocmd!
   " Setup formatexpr specified filetype(s).
   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
   " Update signature help on jump placeholder
   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
 augroup end

 " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
 xmap <leader>a  <Plug>(coc-codeaction-selected)
 nmap <leader>a  <Plug>(coc-codeaction-selected)

 " Remap for do codeAction of current line
 nmap <leader>ac  <Plug>(coc-codeaction)
 " Fix autofix problem of current line
 " nmap <leader>qf  <Plug>(coc-fix-current)

 " Create mappings for function text object, requires document symbols feature of languageserver.
 " xmap if <Plug>(coc-funcobj-i)
 " xmap af <Plug>(coc-funcobj-a)
 " omap if <Plug>(coc-funcobj-i)
 " omap af <Plug>(coc-funcobj-a)

 " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
 " nmap <silent> <C-d> <Plug>(coc-range-select)
 " xmap <silent> <C-d> <Plug>(coc-range-select)

 " Use `:Format` to format current buffer
 command! -nargs=0 Format :call CocAction('format')

 " Use `:Fold` to fold current buffer
 " command! -nargs=? Fold :call     CocAction('fold', <f-args>)

 " use `:OR` for organize import of current buffer
 " command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

 " Add status line support, for integration with other plugin, checkout `:h coc-status`
 " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

 " Using CocList
 " Show all diagnostics
 nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
 " Manage extensions
 nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
 " Show commands
 nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
 " Find symbol of current document
 nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
 " Search workspace symbols
 " nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
 " Do default action for next item.
 nnoremap <silent> <space>j  :<C-u>CocNext<CR>
 " Do default action for previous item.
 " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
 " Resume latest coc list
 nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}

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
" }}}
Plug 'rhysd/conflict-marker.vim'

" vim-endwise {{{
" https://github.com/tpope/vim-endwise
" Primarily for Ruby but will also Vimscript, Shell and Lua
" e.g. will put an -end- after your -if-
" }}}
Plug 'tpope/vim-endwise'

" vim-illuminate {{{
" https://github.com/RRethy/vim-illuminate
" Selectively illuminating other uses of the current word under the cursor.
" }}}
Plug 'RRethy/vim-illuminate'

" }}}

" Software Development: Languages {{{

" Bash, Zsh, *.etest {{{
" *.etest files are unit test files in bash for NetApp Ember.
autocmd BufRead,BufNewFile *.etest setfiletype sh
" Set the indent to 4.
autocmd FileType sh set tabstop=4 shiftwidth=4
" }}}

" C/C++ {{{

" Folding for C/C++
" Wed Apr 17 2019 8:34pm - function error on initialization.
" https://github.com/LucHermitte/VimFold4C
" Plug 'LucHermitte/VimFold4C'

" vim-fswitch
" https://github.com/derekwyatt/vim-fswitch
" Switch between header files and their partner files.
Plug 'derekwyatt/vim-fswitch'
" Switch to the file and load it into the current window >
" nmap <silent> <Leader>of :FSHere<cr>
"  " Switch to the file and load it into the window on the right >
" nmap <silent> <Leader>ol :FSRight<cr>
"  " Switch to the file and load it into a new window split on the right >
" nmap <silent> <Leader>oL :FSSplitRight<cr>
"  " Switch to the file and load it into the window on the left >
" nmap <silent> <Leader>oh :FSLeft<cr>
"  " Switch to the file and load it into a new window split on the left >
" nmap <silent> <Leader>oH :FSSplitLeft<cr>
"  " Switch to the file and load it into the window above >
" nmap <silent> <Leader>ok :FSAbove<cr>
"  " Switch to the file and load it into a new window split above >
" nmap <silent> <Leader>oK :FSSplitAbove<cr>
"  " Switch to the file and load it into the window below >
" nmap <silent> <Leader>oj :FSBelow<cr>
"  " Switch to the file and load it into a new window split below >
" nmap <silent> <Leader>oJ :FSSplitBelow<cr>

" Additional C++ highlighting.
" https://github.com/octol/vim-cpp-enhanced-highlight
Plug 'octol/vim-cpp-enhanced-highlight'

" }}}

" Clojure {{{

" Install Java:
" 1. Download from Oracle.
"
" Install Clojure:
" 1. brew update
" 2. brew install leiningen

" There are about 4 different Clojure support plugins.
" 1. vim-fireplace
"    - This is the workflow that most people use in Vim/Neovim.
" 2. acid.vim
" 3. vim-iced
"    - Sat Oct 12 2019 22:46:46 - got some weird error on startup.  I think it
"    is lag from starting up the nREPL more than anything because a subsequent
"    start of :IcedInNreplNS worked just fine.
" 4. conjure

" vim-iced
" Plug 'liquidz/vim-iced', {'for': 'clojure'}

" Conjure
" https://github.com/Olical/conjure
" Plug 'Olical/conjure', { 'tag': 'v4.7.0' }
" let g:conjure_log_direction = "horizontal"
" let g:conjure_log_blacklist = ["up", "ret", "ret-multiline", "load-file", "eval"]

" " vim-replant & vim-fireplace
" " https://github.com/SevereOverfl0w/vim-replant
" " https://github.com/tpope/vim-fireplace
" " These make use of CIDER-nrepl & refactor-nrepl middleware for their
" " functionality.  These should be in :plugins in your ~/.lein/profiles.clj
" " file.
" Plug 'SevereOverfl0w/vim-replant', { 'do': ':UpdateRemotePlugins' }
" Plug 'tpope/vim-fireplace'

" Evaluate Clojure buffers on load
" autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" vim-clojure-static
" https://github.com/guns/vim-clojure-static
Plug 'guns/vim-clojure-static'

" vim-clojure-highlight
" https://github.com/guns/vim-clojure-highlight
" Extended clojure highlighting
Plug 'guns/vim-clojure-highlight'

" vim-sexp
" https://github.com/guns/vim-sexp
" Precision editing of S-expressions in Clojure, Common Lisp
Plug 'guns/vim-sexp', {'for': ['clojure', 'lisp']}

" vim-sexp-mappings-for-regular-people
" https://github.com/tpope/vim-sexp-mappings-for-regular-people
" Make the sexp mappings easier in the beginning.
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" vim-iced
" https://github.com/liquidz/vim-iced
" https://liquidz.github.io/vim-iced/#_getting_started
" :IcedJackIn
"
" External plugins:
" vim-iced-kaocha
" - Provides some commands for testing with kaocha.
" vim-iced-project-namespaces
" - Provides :IcedBrowseNamespace command for jumping to namespace in your project.
" vim-iced-function-list
" - Provides :IcedBrowseFunction command for jumping to functions in current namespace.
" vim-iced-coc-source
" - Provides auto completion by coc.nvim.
Plug 'liquidz/vim-iced', {'for': 'clojure'}
let g:iced_enable_default_key_mappings = v:true

Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}

" }}}

" Golang {{{

" https//golang.org
"
" Install golang:
" 1. brew update
" 2. brew install golang
"
" Install the golang utilities.
" 1. :GoInstallBinaries

" vim-go
" https://github.com/fatih/vim-go
" There are A LOT of commands in vim-go:
"   * :GoAddTags + :GoRemoveTags - modify/update field tags in a structs.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_version_warning = 0

if has('macunix')
    let g:go_bin_path="/Users/ebodine/workspace/bin/"
elseif has('unix')
    let g:go_bin_path="/home/erickb/workspace/bin/"
endif

" }}}

" Groovy {{{
" This is mainly for Jenkins pipeline files.
" Some of the files we work with have ./<path> full path names in them, remove
" it so that gf will work properly.
autocmd FileType groovy setlocal includeexpr=substitute(v:filename,'\\.\/','','g')
" }}}

" Nim {{{
" https://github.com/alaviss/nim.nvim
" Nim plugin for Neovim only - Investigating using Nim at work for network
" stack management.
" Some convenience mappings:
"     <Plug>NimGoToDefBuf: Go to definition using the current buffer.
"     <Plug>NimGoToDefSplit: Open the definition in a horizontal split.
"     <Plug>NimGoToDefVSplit: Open the definition in a vertical split.
" }}}
Plug 'alaviss/nim.nvim'

" Python {{{

" vim-conda {{{
" https://github.com/cjrh/vim-conda
" Support python development using Conda env manager
" }}}
Plug 'cjrh/vim-conda'

" impsort.vim - sensibly sort imports {{{
" https://github.com/tweekmonster/impsort.vim
" Utility for sorting and highlighting Python imports.  More flexible than
" isort.
Plug 'tweekmonster/impsort.vim'
let g:impsort_textwidth = 104
" so that the linter doesn't complain.
let g:impsort_lines_after_imports = 2
let g:impsort_start_nextline = 1
" run impsort on save.
" Wed Nov 06 2019 11:37:33 - ImpSort messes with the Valence __init__.py
" formatting.
" autocmd BufWritePre *.py ImpSort!
" }}}

" vim-python-pep8-indent {{{
" https://github.com/Vimjas/vim-python-pep8-indent
" Modify the Vim indenting of Python to conform with PEP8 and some nicer style
" changes.
Plug 'Vimjas/vim-python-pep8-indent'
" }}}

" Syntax highlighting {{{
" https://github.com/numirias/semshi
" Much improved semantic highlighting for Python.
" Mon Feb 01 2021 22:55:22 - Turned this off while trying out nvim-treesitter,
" which works brilliantly so far.
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" }}}

" SimpylFold {{{
" No-BS Python code folding, used in conjunction with FastFold.
" https://github.com/tmhedberg/SimpylFold
" }}}
Plug 'tmhedberg/SimpylFold'

" Python textobjects {{{
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

" requirements.txt.vim {{{
" https://github.com/raimon49/requirements.txt.vim
" the Requirements File Format syntax support for Vim
Plug 'raimon49/requirements.txt.vim'
" Add 'freeze' to your .vimrc as a detection pattern
let g:requirements#detect_filename_pattern = 'freeze'
" }}}

" }}}

" Ruby {{{

" vim-ruby
" https://github.com/vim-ruby/vim-ruby
" Ruby configuration.  Also covers Vagrantfiles.
Plug 'vim-ruby/vim-ruby'

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
" }}}

" Rust {{{

" Writing Rust plugin in Neovim.
" https://blog.usejournal.com/a-detailed-guide-to-writing-your-first-neovim-plugin-in-rust-a81604c606b1
" rust-lang & *.toml support comes in vim-polyglot

" Install rustfmt
" rustup component add rustfmt --toolchain stable-x86_64-apple-darwin
"
" Install rustls - only if using coc.vim
" Fri Aug 16 2019 17:01:42 - disabled coc.vim because the functionality was
" just not there compared to deoplete.
" :CocInstall coc-rls

" deoplete-rust {{{
" Use Racer (https://github.com/racer-rust/racer) for code completion and
" navigation.
"
" Install racer
" $ cargo +nightly install racer
"
" Install the Rust src
" $ rustup component add rust-src
"

" Enable deoplete autocompletion in Rust files
" let g:deoplete#enable_at_startup = 1
" customise deoplete maximum candidate window length
" Sat Sep 26 2020 17:51:54 - Unknown function?
" call deoplete#custom#source('_', 'max_menu_width', 80)
" Plug 'sebastianmarkow/deoplete-rust'
" let g:deoplete#sources#rust#racer_binary='/Users/ebodine/.cargo/bin/racer'
" let g:deoplete#sources#rust#rust_source_path='/Users/ebodine/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
" let g:deoplete#sources#rust#show_duplicates=1
" let g:deoplete#sources#rust#documentation_max_height=30
" }}}

" Some Rust configuration.
" let g:rustfmt_autosave=1
" let g:racer_experimental_completer=1

au FileType rust set makeprg=cargo\ build\ -j\ 4
au FileType rust nmap <leader>et :!cargo test<cr>
au FileType rust nmap <leader>er :!RUST_BACKTRACE=1 cargo run<cr>
au FileType rust nmap <leader>ec :terminal cargo build -j 4<cr>
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gv <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gk <Plug>(rust-doc)
" }}}

" Vimscript {{{
" If you want to script Vim, you have to use vimscript, at least some.

" }}}

" vim-polyglot {{{
" Various language packs for vim.
" https://github.com/sheerun/vim-polyglot
"
" Mon Oct 14 2019 18:00:39 - moved after the language plugins so that it
" doesn't conflict with any of them, e.g. vim-go
" ** HAS CONFLICTS WITH VIM-GO - https://github.com/fatih/vim-go/issues/2045 **
" ** HAS TO COME AFTER LANGUAGE DEFINITIONS THAT YOU HAVE DISABLED BELOW **
"
" A best-of-breed collection of programming language syntax,indent,ftplugin
" config files.
" Plug 'sheerun/vim-polyglot'
" I prefer my own configuration of Python, Markdown and Golang
" let g:polyglot_disabled = ['go', 'python', 'markdown']
" let g:markdown_fenced_languages = ['bash=sh', 'css', 'django', 'javascript', 'js=javascript', 'json=javascript', 'perl', 'php', 'python', 'ruby', 'sass', 'xml', 'html', 'vim']
"
" Rust & *.toml
" let g:autofmt_autosave = 1
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

" gentoo-syntax {{{
" Gentoo and portage related syntax highlighting, filetype, and indent settings for vim
Plug 'gentoo/gentoo-syntax'
" }}}

" ini files {{{
" Specically need to set .flake8 to dosini
au BufRead,BufNewFile flake8 set filetype=dosini
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

" Enable folding for json files.
augroup ft_json
    au!
    au BufRead,BufNewFile *.json setlocal foldmethod=syntax
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END
" }}}

" Log files. {{{
" A lot here applies to log files that I have to deal with at work.
"

" Clean up just a selection.
" Solidfire/NetApp logs will often have json embedded in log messages.  I can
" make a new line at the Json, select it and make it more readable with this.
" :call LogJson()
function! LogJson()
	:'<. '>!python -m json.tool
endfunction

" Autogroup for log files.
" 1. Set foldmethod to manual so that we can create adhoc folds when we go log
"    spelunking.
" 2. Some bindings for just logfiles.
augroup ft_log
	autocmd! ft_log
    	autocmd BufRead,BufNewFile *.log setlocal foldmethod=manual
	autocmd BufRead *.log if getline(1) =~ '^\[\[34m' | :call AnsiEsc | endif
	autocmd Filetype log nmap <buffer> <silent> <localleader>lj :call LogJson()<cr>
augroup END
" }}}

" Markdown {{{

" Try out the following at some point.
" https://github.com/itchyny/vim-highlighturl
"
" https://github.com/SidOfc/mkdx
" https://github.com/euclio/vim-markdown-composer
" https://github.com/rhysd/vim-gfm-syntax - Github flavored markdown syntax
" 					    hightlighting

" vim-pandoc {{{
" https://github.com/vim-pandoc/vim-pandoc
" There are many different markdown plugins.  Most are too slow.
" 1. gabrielelana/vim-markdown too slow for large *.md files.
" 2. plasticboy/vim-markdown too slow for large *.md files.
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" }}}

" markdown-preview.nvim {{{
" https://github.com/iamcco/markdown-preview.nvim
" Preview markdown on your modern browser with synchronised scrolling and flexible configuration
"
" Main features:
"  - Cross platform (macos/linux/windows)
"  - Synchronised scrolling
"  - Fast asynchronous updates
"  - Katex for typesetting of math
"  - Plantuml
"  - Mermaid
"  - Chart.js
"  - sequence-diagrams
"  - Toc
"  - Emoji
"  - Task lists
"  - Local images
"  - Flexible configuration
"
" Start the preview
" :MarkdownPreview
"
" Stop the preview"
" :MarkdownPreviewStop
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
nnoremap <leader>ms <Plug>MarkdownPreviewToggle
" }}}

" }}}

" Vagrantfile {{{
" https://github.com/hashivim/vim-vagrant
" Sets up the syntax highlighting and provides :Vagrant [args] provided that
" vagrant is in your PATH.
Plug 'hashivim/vim-vagrant'
" }}}

" }}}

" Version Control -------------------------------------------------- {{{

" vim-fugitive + vim-merginal - Git management  {{{

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

" TODO: Get vim-fubitive (Bitbucket repos) & vim-rhubarb working together.

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

" Add/Stage the current file.
nnoremap <silent> <leader>ga :Git add .<cr>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
" Use \q\ to quit the diff.
" Tue Sep 10 2019 19:51:21 - right now this blows away all other splits.
nnoremap <silent> <leader>gd :Gdiff<CR>
" Adding 0 at the beginning points to the local file - :GV! is better.
nnoremap <silent> <leader>gl :0Glog<CR>
nnoremap <silent> <leader>gp :Gpush<CR>
nnoremap <silent> <leader>gr :Gremove<CR>
nnoremap <silent> <leader>gg :Gstatus<CR>
nnoremap <silent> <leader>gu :Gpull<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>

" }}}

" Conflicted {{{
" https://github.com/christoomey/vim-conflicted
" Conflicted is a Vim plugin that aids in resolving git merge and rebase
" conflicts.  Provides a few wrapper commands and a streamlined workflow to
" make resolving conflicts much more straightforward.
"
" Let's say you just pulled code from the project's master branch on github
" and you got a merge conflict error. To resolve it, you can run the
" :Conflicted command that this plugin offers. This command creates a
" three-way diff and puts the results in three vertical split windows. The
" left split is upstream changes, the middle split is working changes, and the
" right split is local changes. You can either accept upstream diff or the
" local diff to resolve the conflict. Conflicted offers two key mappings for
" quickly accepting the right diff. The dgu command will use the upstream diff
" and dgl will use the local diff. To resolve the next conflict, use the
" :GitNextConflict command. If there are no more conflicts, vim will exit, and
" you can git commit the resolved files.
Plug 'christoomey/vim-conflicted'


" }}}

" vim-gitgutter - show git diff in the gutter {{{
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" set update time - gitgutter recommends 100
set updatetime=100

" both of these work with repeat.vim
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Preview a hunks changes
nmap <Leader>hv <Plug>(GitGutterPreviewHunk)

" text objects that operate on hunks
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" have gitgutter ignore whitespace
let g:gitgutter_diff_args = '-w'

" Set the maximum number of signs to show in a buffer.
let g:gitgutter_max_signs = 2500

"symbols
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = "✚"
let g:gitgutter_sign_modified = "➜"
let g:gitgutter_sign_removed = "✖"
let g:gitgutter_sign_modified_removed = "✖"

" Refresh GitGutter signs after fugitive commit.
" https://github.com/airblade/vim-gitgutter/issues/502
autocmd BufWritePost,WinEnter * GitGutter
" }}}

" flog {{{
" https://github.com/rbong/vim-flog
" https://medium.com/@r.l.bongers/announcing-flog-a-new-git-branch-viewer-for-vim-from-the-former-maintainer-of-gitv-e9db68977810
" Flog is a lightweight and powerful git branch viewer that integrates with
" fugitive.  New and improved gitv.
" NOTE: Sat Mar 9, 2019 3:08:19pm - Comparing with gv.vim
"
" Flog keeps an open API in order to allow you to customize it to suit your git
" workflow.
"
" The best way to discover how to use the API is by reading it:
" https://github.com/rbong/vim-flog/blob/master/autoload/flog.vim
"
" Example: to add a diff command to Flog, add the following to your |.vimrc|.
" >
"   function! Flogdiff(mods) abort
"     let l:path = fnameescape(flog#get_state().path[0])
"     let l:commit = flog#get_commit_data(line('.')).short_commit_hash
"     call flog#preview(a:mods . ' split ' . l:path . ' | Gvdiff ' . l:commit)
"   endfunction
"
"   augroup flog
"     autocmd FileType floggraph command! -buffer -nargs=0 Flogdiff call Flogdiff('<mods>')
"   augroup END
" <
"
" By running ":Flogdiff" in the Flog graph window, you can now see a diff of the
" file passed in with the "-path=" option against the commit under the cursor.
"
Plug 'rbong/vim-flog'
" }}}

" git-messenger {{{
" https://github.com/rhysd/git-messenger.vim
" Plugin to reveal the commit messages under the cursor.
" The popup window will be automatically closed when you move the cursor so you don't need to close it manually.

" Running this command while a popup window is open, it moves the cursor into
" the window. This behavior is useful when the commit message is too long and
" window cannot show the whole content. By moving the cursor into the popup
" window, you can see the rest of contents by scrolling it. You can also see the
" older commits.
"
" Following mappings are defined within popup window - press <leader>gm again
" to get into the popup window.
"
" Mapping   	Description
" ==========================
"    q      	Close the popup window
"    o      	older. Back to older commit at the line
"    O      	Opposite to o. Forward to newer commit at the line
"    d      	Toggle diff hunks only related to current file in the commit
"    D      	Toggle all diff hunks in the commit
"    ?      	Show mappings help
Plug 'rhysd/git-messenger.vim'
nmap <leader>gm <Plug>(git-messenger)
" }}}

" vim-twiggy {{{
" https://github.com/sodapopcan/vim-twiggy
" Git branch management for Vim - similar to Merginal
" Invoke Twiggy with :Twiggy
Plug 'sodapopcan/vim-twiggy'

function! s:changebranch(branch)
    execute 'Git checkout' . a:branch
    call feedkeys("i")
endfunction

command! -bang Gbranch call fzf#run({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ',
            \ 'sink': function('s:changebranch')
            \ })
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

" Terminal Mappings {{{

" Switch back to Normal mode.
tnoremap <Esc> <C-\><C-n>
" }}}

" }}}

" Tmux: {{{

" vim-tmux-navigator {{{
" https://github.com/christoomey/vim-tmux-navigator
" Allows you, with similar config in tmux.conf, to move between vim splits and
" tmux panes seamlessly.
"
" ** This sets the following Window split navigation: **
"   nnoremap <C-J> <C-W><C-J>
"   nnoremap <C-K> <C-W><C-K>
"   nnoremap <C-L> <C-W><C-L>
"   nnoremap <C-H> <C-W><C-H>
Plug 'christoomey/vim-tmux-navigator'
" }}}
" }}}

" Appearances: {{{

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

" molokai
" https://github.com/tomasr/molokai
" A modified version of molokai for Vim.
Plug 'tomasr/molokai'

" challenger_deep
" https://github.com/challenger-deep-theme/vim
Plug 'challenger-deep-theme/vim'

" }}}

" Statuslines: {{{
" There are a number of different options: powerline, airline, lightline, etc.
" 1. lightline - https://github.com/itchyny/lightline.vim
"   - Mon Jun 25 4:57:32pm 2018
"     Appears to be faster(?) in normal operation - startup is not faster.
"     A LOT less information on the statusline that you then have to configure
"     yourself.
"   - More plugins are adding lightline support.
"     let g:lightline = { 'colorscheme': 'challenger_deep'}
" 2. powerline - much too much and slow.
" 3. airline - is a good middle ground for me.

" vim-airline {{{
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/paranoida/vim-airlineish'

let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep = ' '
" enable integration with ale
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1
" always show tabs
let g:airline#extensions#tabline#show_tabs = 1

let g:airline#extensions#branch#empty_message = 'No Source Control'
let g:airline#extensions#branch#displayed_head_limit = 15
" hides the fugitive://**// part of the buffer names
let g:airline#extensions#fugitiveline#enabled = 1

let g:airline#extensions#ale#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'LocationList'

" need to enable this for vim-devicons
let g:airline_powerline_fonts = 1
" }}}

" tmuxline.vim {{{
" https://github.com/edkolev/tmuxline.vim
" Simple tmux statusline generator with support for powerline symbols and
" statusline / airline / lightline integration.
" NOTE:
"   Once this is installed, generate the ~/.tmux-status.conf file with
"     :TmuxlineSnapshot ~/.tmux-status.conf in Neovim.
"   Then, add the following to tmux.conf
"     # Enable tmuxline when no Neovim.
"     source-file ~/.tmux-status.conf
"
"   ** The TmuxlineSnapshot command must be executed after |tmuxline| has set
"   tmux's statusline, i.e. after executing |:Tmuxline|
Plug 'edkolev/tmuxline.vim'
" for tmuxline + vim-airline integration
let g:airline#extensions#tmuxline#enabled = 1
" start tmuxline even without vim running
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
" }}}
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
" }}}
Plug 'ryanoasis/vim-devicons'

" }}}

" Conclude plugin initialization.
call plug#end()

" This is supposed to be enabled by default but my Python syntax highlighting
" looks like garbage if I remove this line.
syntax enable

" Plugin Configuration: {{{

" vim-obsession & vim-prosession
let g:prosession_dir='~/tmp/neovimrc/sessions'
let g:prosession_on_startup = 1

" ultisnips
" expand via tab.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" tagbar {{{
" In the CloseWindow() function there is a call to honor the defualt
" equalalways setting.  As a result, when closing/toggling Tagbar, any window
" sizing gets equalized
set noequalalways

let g:tagbar_sort = 0
let g:tagbar_left = 0
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

" Tagbar configuration for Rust.
let g:tagbar_type_rust = {
    \ 'ctagstype': 'rust',
    \ 'kinds': [
        \ 'n:modules',
        \ 's:structs',
        \ 'i:traits',
        \ 'c:impls',
        \ 'f:functions',
        \ 'g:enums',
        \ 't:typedefs',
        \ 'v:variables',
        \ 'M:macros',
        \ 'm:fields',
        \ 'e:variants',
        \ 'F:methods',
    \ ]}

nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>to :TagbarOpen<CR>
" }}}

" rainbow parentheses
let g:rainbow_active = 1

" vim-better-whitespace
autocmd FileType python,rust,clojure,vim,go autocmd BufEnter <buffer> EnableStripWhitespaceOnSave

" vim-illuminate
" make the illumination stand out a bit more.
hi link illuminatedWord Visual
" toggle word illumination.
let g:Illuminate_highlightUnderCursor = 0
let g:Illuminate_ftwhitelist = ['vim', 'sh', 'python', 'go', 'clojure', 'rust']
nnoremap <leader>it :IlluminationToggle<cr>

" Toggle location list
let g:lt_location_list_toggle_map = '<leader>cl'
let g:lt_quickfix_list_toggle_map = '<leader>cq'
let g:lt_height = 15

" undotree
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 15
nmap <leader>ut :UndoTreeToggle<cr>

" deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" vim-devicons {{{
" loading the plugin
let g:webdevicons_enable = 1
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
if has('macunix')
    let g:WebDevIconsOS = 'Darwin'
endif
" }}}

" nvim-lspconfig
" https://github.com/neovim/nvim-lspconfig
" lua << EOF
" require'lspconfig'.pyright.setup{}
" EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

" vim-easymotion
let g:EasyMotion_do_mapping = 0
nmap gs <Plug>(easymotion-overwin-f2)

" }}}

" Appearances Configuration: {{{

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Support for true color terminal.  This changes cterm colors to gui colors.
" Used to be a env variable
if (has("termguicolors"))
    set termguicolors
endif

" NOTE: This has to be after the `plug#end & syntax enable` above.
colorscheme molokai
let g:airline_theme='airlineish'

" comments should always be in italics
highlight Comment cterm=italic

" Change the GitGutter colors to something we want
" green
highlight GitGutterAdd guifg=#95ffa4 ctermfg=120
" red
highlight GitGutterDelete guifg=#ff8080 ctermfg=204
" yellow
highlight GitGutterChange guifg=#ffe9aa ctermfg=228
" red
highlight GitGutterChangeDelete guifg=#ff8080 ctermfg=204
" }}}

" Special Use Case Mappings: {{{

" I use this to better see json blobs on a single line.
" 1. Goto the interesting line.
" 2. Search forward to the beginning bracket/brace
" 3. visually select to the closing bracket/brace.
" 4. Press _a  and the json will be fomatted on multiple lines for you.
" Because : Ex cmds are line oriented, the normal pipe to an external command
" will not work.
nnoremap _a <Esc>`>a<CR><Esc>`<i<CR><Esc>!!jq<CR>

" }}}

" General Mappings: {{{

" Disable some bindings that I find annoying & potentially dangerous if hit
" accidentally.
" ZZ - save and close Vim
" ZQ - close Vim
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" A test to see if i could map the MacOSX Command key
" Friday July 6 2018 - Is working in Vimr
" Saturday December 29, 2018 - Won't work in iTerm2
" Thu Feb 20 2020 13:55:08 - The Command key (Super key) still not seen.
" nnoremap <D-l> :echo "testing"<cr>

" Edit Neovim configuration file.
nnoremap <silent> <leader>ec :e $MYVIMRC<cr>

" toggle between line numbers, relative line numbers and no numbers.
nnoremap <silent> <leader>nn :exec &nu==&rnu? "se nu!" : "se rnu!"<cr>

" Quit the current window. If we are the last window, then exit Neovim.
nnoremap <leader>q <C-w>c<cr>
" Really, I want to quit Neovim.
nnoremap <leader><leader>q :qa<cr>

" Close the Help window from afar.
nnoremap <leader>hq :helpclose<cr>

" quick save
nnoremap <leader>w :w!<cr>

" Make D behave
nnoremap D d$
" Yank to the end of the line.
nnoremap Y y$
" U is a better redo
nnoremap U <C-r>

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v <C-w>=
" ss to generate new horizontal split
nnoremap <silent> ss <C-w>s <C-w>=

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

" Some mappings for next/previous buffers.
nmap gb :bnext<cr>
nmap gB :bprev<cr>

" Omni completion remap
inoremap <C-l> <C-x><C-l>
" Delete the previous word.
inoremap <C-b> <C-o>diw
" Delete the previous character, like all the shells do.
inoremap <C-d> <C-o>x

" Quit vimdiff using q but also don't mess with macro.
nnoremap <expr> q &diff ? ":diffoff!\<bar>only\<cr>" : "q"
" Use du instead of the more verbose :diffupdate
nnoremap <expr> du &diff ? ":diffupdate!<cr>" : echo "Not in diff"

" Help specific bindings.
" Check out ftplugins/help.vim

" Use Q to play macro normally and over visual selections.
xnoremap Q :'<,'>:normal @q<CR>

nnoremap <leader>= gqq<cr>

" Equalize the vertical, horizontal splits.  Equalize closing a window.
nnoremap <C-w>v <C-w>v <C-w>=
nnoremap <C-w>s <C-w>s <C-w>=
nnoremap <C-w>c <C-w>c <C-w>=

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" }}}

" Because, for some reason, this doesn't work until after neobundle#end or
" plug#end
call arpeggio#load()
Arpeggioinoremap jk <Esc>:
Arpeggionnoremap jk :
Arpeggiocnoremap jk <Esc>

" Miscellaneous Functions: {{{

" Clean up At2 response output that is in JSON but is too messy for json.tool
" to handle directly.
function! At2Json()
	V:s/u'/"/
	V:s/'/"/
	:%!python -m json.tool
endfunction

" }}}

" Appbreviations: {{{
" NOTE: You can make filetype/bufferlocal abbreviations by adding the
"       following to a ftplugin/<filetype>.vim file:
"   	  iab <buffer> ebx erick.bodine
iab sb " {{{
iab eb " }}}
iab ydate <c-r>=strftime("%a %b %d %Y %T")<cr>
" }}}

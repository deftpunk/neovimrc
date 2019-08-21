nnoremap <buffer> <cr> <C-]>
nnoremap <buffer> q :helpclose<cr>

" Cribbed from https://vim.fandom.com/wiki/Learn_to_use_help
" Press o to find the next option, or O to find the previous option.
" Press s to find the next subject, or S to find the previous subject.
nnoremap <buffer> o /'\l\{2,\}'<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

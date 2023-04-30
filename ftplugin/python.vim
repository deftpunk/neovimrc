setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal formatoptions=croqjl
setlocal textwidth=79
setlocal cindent
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" Go to the start of all of the import statements.
function! PythonImportBeginning()
python << EOF
import re
import vim
im_re = re.compile('^import')
cb = vim.current.buffer
cw = vim.current.window
idx = 1
for line in cb:
    if im_re.search(line):
        cw.cursor = (idx, 0)
        break
    idx += 1
EOF
endfunction

" Go to the main() definition.
function! PythonDefMain()
python << EOF
import re
import vim
im_re = re.compile('^def main\(')
cb = vim.current.buffer
cw = vim.current.window
idx = 1
for line in cb:
    if im_re.search(line):
        cw.cursor = (idx, 0)
        break
    idx += 1
EOF
endfunction

"Go to the optparse.OptionParse definition.
function! PythonOptionParser()
python << EOF
import re
import vim
im_re = re.compile('ArgumentParser\(')
cb = vim.current.buffer
cw = vim.current.window
idx = 1
for line in cb:
    if im_re.search(line):
        cw.cursor = (idx, 0)
        break
    idx += 1
EOF
endfunction

" <buffer> = buffer-local, won't apply in other buffers, filetype specific.
nnoremap <buffer> <silent> <leader>ii :call PythonImportBeginning()<cr>
nnoremap <buffer> <silent> <leader>im :call PythonDefMain()<cr>
nnoremap <buffer> <silent> <leader>io :call PythonOptionParser()<cr>

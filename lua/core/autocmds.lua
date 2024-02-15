-- autocommands
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Disable line length (color column) for some filetypes
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  group = 'setLineLength',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
  command = 'setlocal cc=0'
})

-- Set indentation to 2 spaces on some filetypes
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- windows to close with "q"
autocmd("FileType", {
  pattern = { "help", "startuptime", "qf", "lspinfo" }, 
  command = [[nnoremap <buffer><silent> q :close<CR>]] 
})
autocmd("FileType", {
  pattern = "man", 
  command = [[nnoremap <buffer><silent> q :quit<CR>]] 
})

-- show cursor line only in active window
augroup("CursorLine", { clear = true })
autocmd({ "InsertLeave", "WinEnter" }, { 
  group = cursorGrp,
  pattern = "*", 
  command = "set cursorline" 
})
autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorGrp,
  pattern = "*", 
  command = "set nocursorline" 
})

-- Terminal settings
-- Turn off line numbering
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

-- Enter insert mode when switching to terminal
autocmd({'TermOpen', 'TermEnter'}, {
  pattern = '',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
-- FIX: This is not working as expected when Ctrl-d in the shell.
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- Remove trailing whitespace.
autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      pcall(function() vim.cmd [[%s/\s\+$//e]] end)
      vim.fn.setpos(".", save_cursor)
    end,
})

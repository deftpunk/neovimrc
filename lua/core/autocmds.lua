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

-- Save the lasplace in a buffer.
-- https://www.reddit.com/r/neovim/comments/1052d98/comment/j39bgco/?utm_source=share&utm_medium=web2x&context=3
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
augroup('lastplace', { clear = true })
autocmd("BufReadPost", {
    group = lastplace,
    pattern = { "*" },
    desc = "remember last cursor place",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
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

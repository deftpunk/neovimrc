-- vim: nu fdm=marker

local map = vim.keymap.set

if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1
  map('v', '<D-s>', ':w<CR>', { noremap = true, silent = true, desc = "Save in Neovide on Mac" })
  map('v', '<D-c>', '"+y', { noremap = true, silent = true, desc = "Copy in Neovide on Mac" })
end

-- Make Pste work with the clipboard on Mac.
-- https://github.com/neovide/neovide/discussions#issuecomment-1972013043
map({'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
    '<D-v>',
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
)

-- Plugin Keymaps {{{

-- TodoTrouble mapping is global in your current directory.
-- map('n', 'gr', '<cmd>TodoTrouble<cr>', { desc = "Open Todo list in Trouble." })

-- argwrapping with trevJ
map('n', 'gw', "<cmd>lua require('trevj').format_at_cursor()<cr>.", { desc = "Wrap arguments." })

-- Sanely delete the current buffer.
map('n', "<leader>k", "<cmd>:lua require('bufdelete').bufdelete(0, true)<cr>", { desc = "Kill the current buffer." })

map("n", "<leader>-", "<cmd>:lua require('nvim-window').pick()<cr>", { desc = "Switch between windows." })

-- Neotest
map("n", "<leader>tc", "<cmd>:lua require('neotest').run.run(vim.fn.expand('%'))<cr>")
map("n", "<leader>tr", "<cmd>:lua require('neotest').run.run()<cr>")

-- Neotree
map('n', '<leader>tn', '<cmd>Neotree filesystem reveal toggle<cr>')
map('n', '<leader>tg', '<cmd>Neotree git_status toggle position=float<cr>')

-- ToggleTerm
map('n', '<leader>tt', '<cmd>exe v:count1 . "ToggleTerm size=25 direction=horizontal"<CR>', { silent = true, desc = "Toggle a Terminal" })

-- Using ufo provider need remap `zR` and `zM`.
map('n', 'zR', require('ufo').openAllFolds, { desc = "nvim-ufo: Open all folds."})
map('n', 'zM', require('ufo').closeAllFolds, { desc = "nvim-ufo: Close all folds."})
map('n', 'zp', function()
local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end,
{ desc = "Peek under fold"})

-- Sort alphanumerically by delimiter.
map("n", 'go', "<cmd>Sort<CR>", { silent = true, desc = "Sort alphanumerically." })
map("v", 'go', "<Esc><cmd>Sort<CR>", { silent = true, desc = "Sort alphanumerically." })

-- which-key & help commands.
map('n', '<leader>hk', '<cmd>WhichKey<cr>', { desc = "Show all keybindings." })
map('n', '<leader>hl', '<cmd>WhichKey <leader><cr>', { desc = "Show all leader keybindings." })
map('n', '<leader>hq', '<cmd>helpclose<cr>', { desc = "Close the help window." })

map("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

map("n", "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- Lint current buffer.
map("n", "<leader>ll", "<cmd>:lua require('lint').try_lint()<cr>", { desc = "Trigger linting for current file" })

-- Comment and copy.
map("n", "<leader>cc", "yy<Plug>(comment_toggle_linewise_current)p")
map("x", "<leader>cc", "ygv<Plug>(comment_toggle_linewise_visual)`>p")

-- dial.nvim bindings.
map("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end)
map("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end)
map("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end)
map("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end)
map("v", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end)
map("v", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end)
map("v", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end)
map("v", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end)

-- }}}

-- Leader Keymaps {{{

-- Go to tab by number
map('n','<leader>1','1gt')
map('n','<leader>2','2gt')
map('n','<leader>3','3gt')
map('n','<leader>4','4gt')
map('n','<leader>5','5gt')
map('n','<leader>6','6gt')
map('n','<leader>7','7gt')
map('n','<leader>8','8gt')
map('n','<leader>9','9gt')
map('n','<leader>0',':tablast<cr>')

-- Write the file.
map('n', '<leader>w', ':w<cr>', { desc = "Save the current buffer." })

-- Recenter
map('n', '<leader><leader>l', 'zz')
map('n', '<D-l>', 'zz')

-- Source the lua file that we are in.
map('n','<leader><leader>x', '<cmd>source %<cr>')
-- Run the current line of lua
map('n','<leader>x', ':.lua<cr>')
-- Run some lua on the cmdline.
map('v','<leader>x', ':lua<cr>')

-- Open another instance of Neovide from w/in Neovide.
-- Fri Sep 27 2024 09:57:44 - This doesn't work as well as hoped.  It opens a
-- 2nd+ Neovide but you can only access/use the successive ones opened??
-- if vim.g.neovide and vim.fn.has('macunix') then
--     vim.keymap.set("n", "<D-n>", ":silent exec '!/opt/homebrew/bin/neovide'<cr>")
-- end

-- The fill-paragraph equivalent.
map('n', '<leader=', 'gqq')

-- Toggle search highlight.
map('n', '<leader>th',
	[[ (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n" <BAR> redraw<CR>]],
	{ silent = true, expr = true, desc = "Toggle search highlight." })
-- }}}

-- Normal Mode Maps {{{

-- Disable some bindings that I find annoying & potentially dangerous if hit accidentally.
-- ZZ - save and close Vim
-- ZQ - close Vim
map('n', 'ZZ', '<Nop>')
map('n', 'ZQ', '<Nop>')

-- Some OG 'g' bindings
-- next/previous buffers.
map('n', 'gb', ':bnext<cr>', { desc = "Next Buffer." })
map('n', 'gB', ':bprev<cr>', { desc = "Previous Buffer." })

map('n', 'D', 'd$', { desc = "Delete to end of line + newline" })
map('n', 'Y', 'y$', { desc = "Yank to end of line + newline" })
map('n', 'U', '<C-r>', { desc = "Undo." })

map('n', 'vv', '<C-w>v <C-w>=', { desc = "Vertical Split" })
map('n', 'ss', '<C-w>s <C-w>=', { desc = "Horizontal Split" })

-- Quickly move the adjacent windows
map('n', '<c-h>', '<c-w>h', { desc = "Go to the left window" })
map('n', '<c-j>', '<c-w>j', { desc = "Go to the up window" })
map('n', '<c-k>', '<c-w>k', { desc = "Go to the bottom window" })
map('n', '<c-l>', '<c-w>l', { desc = "Go to the right window" })

-- }}}

-- Command Mode Keymaps {{{

map('c', '<C-a>', '<home>')
map('c', '<C-e>', '<end>')

-- }}}

-- Insert Mode Maps {{{

-- Delete the previous word.
map('i', '<C-b>', '<C-o>diw', { desc = "Delete the previous character." })
-- Delete the next character, like all the shells do.
map('i', '<C-d>', '<C-o>x', { desc = "Delete the next character." })

-- }}}

-- Terminal Maps {{{
map('t', '<Esc>', '<C-\\><C-n>')

-- }}}

-- Arpeggio
-- Mapped here because of what arpeggio#load() does, which I am not really sure
-- about but this works.
vim.cmd[[
call arpeggio#load()
Arpeggioinoremap jk <Esc>:
Arpeggionnoremap jk :
Arpeggiocnoremap jk <Esc>
]]

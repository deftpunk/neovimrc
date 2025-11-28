vim.cmd[[
  setlocal wrap
  ]]

-- Keymaps
local map = vim.keymap.set

map('n', '<Tab>', 'za', { silent = true, desc = "Use Tab to toggle header folds." })

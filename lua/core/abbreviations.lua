local cnoreabbrev = vim.cmd.cnoreabbrev

-- Some command abbreviations.
cnoreabbrev("qw", "wq")
cnoreabbrev("W", "w")
cnoreabbrev("Wq", "wq")
cnoreabbrev("WQ", "wq")
cnoreabbrev("Qa", "qa")
cnoreabbrev("Bd", "bd")
cnoreabbrev("bD", "bd")
cnoreabbrev("bD", "bd")
cnoreabbrev("Q", "q")

vim.cmd('iab ydate <c-r>=strftime("%a %b %d %Y %T")<cr>')

-- lazy.nvim {{{
-- https://github.com/folke/lazy.nvim
-- The Lazy Package Manager.
-- :Lazy check [plugins] - Check for updates and show the log (git fetch).
-- :Lazy clean - Clean plugins that are no longer needed. :Lazy install [plugins] - Install missing plugins.
-- :Lazy update [plugins] - Update plugins.
-- :Lazy log - Show recent updates.
-- :Lazy profile - plugin bootup profiler
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- }}}

require("lazy").setup("plugins", {
    change_detection = {
      notify = false,
    },
})

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

print "starting .."
-- add binaries installed by mason.nvim to path
--vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath "data" .. "/mason/bin"

require "options"

require "mappings"

require("lazy").setup("plugins")

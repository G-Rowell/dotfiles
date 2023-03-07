-- autocmds
local autocmd = vim.api.nvim_create_autocmd
local api = vim.api

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- autocmd("InsertEnter",{
--    pattern = "*",
--    command = "set norelativenumber",
-- })
--
-- autocmd("InsertLeave",{
--    pattern = "*",
--    command = "set relativenumber",
-- })

-- Auto resize panes
autocmd("VimResized", {
   pattern = "*",
   command = "tabdo wincmd =",
})

autocmd('TextYankPost', {
   group    = 'bufcheck',
   pattern  = '*',
   callback = function() 
      vim.highlight.on_yank{timeout=500} 
   end 
})

-- dont list quickfix buffers
autocmd("FileType", {
   pattern = "qf",
   callback = function()
      vim.opt_local.buflisted = false
   end,
})

autocmd("BufUnload", {
   buffer = 0,
   callback = function()
      vim.opt.laststatus = 3
   end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
   pattern = "*",
   command = "set fo-=c fo-=r fo-=o",
})

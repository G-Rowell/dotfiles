--vim.defer_fn(function()
--  pcall(require, "impatient")
--end, 0)

-- require "core"
-- require "core.options"

print "starting .."
-- add binaries installed by mason.nvim to path
--vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath "data" .. "/mason/bin"

require "options"

require "mappings"

require "plugins"

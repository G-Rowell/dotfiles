local M = {}
local api = vim.api

local merge_tb = vim.tbl_deep_extend

M.map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.close_buffer = function(bufnr)
  if vim.bo.buftype == "terminal" then
    vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
  else
    bufnr = bufnr or api.nvim_get_current_buf()
    vim.cmd("update")                         -- Save buffer (if edited)
    vim.cmd("bnext")            -- Go to a new screen
    vim.cmd("silent! confirm bd" .. bufnr)    -- Close!
  end
end

return M

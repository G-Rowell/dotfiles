-- n, v, i, t = mode names

local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local map = require("utils").map

map("n", ",<Space>", ":nohlsearch<CR>", { silent = true })

-- INSERT MODE
-- navigate within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

-- NORMAL MODE
map("n", "<ESC>", "<cmd> noh <CR>")

-- switch between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Copy all
map("n", "<C-c>", "<cmd> %y+ <CR>")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
--
map("v", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("v", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

--    -- close buffer + hide terminal buffer
--    ["<leader>x"] = {
--      function()
--        require("utils").close_buffer()
--      end,
--      "close buffer",
--    },
--  },
--
--  t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },
--
   -- Don't copy the replaced text after pasting in visual mode
--    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
--    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
-- ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
--map("p", '<cmd>p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })
--  },
--}


-- Bufferline
map("n", "<Tab>", "<CMD> bnext <CR>")
map("n", "<S-Tab>", "<CMD> bprev <CR>")
-- pick buffers via numbers
-- map("n", "<Bslash>", "<cmd>LualineBuffersJump NUM <CR>")

-- map("n", "<S-x>", "<CMD> update | let x=bufnr() | BufferLineCycleNext | bd x <CR>")
map("n", "<S-x>", '<CMD> lua require("utils").close_buffer() <CR>')
--//  nmap <Space>q :bp <BAR> bd #<CR> " Close the current buffer tab
-- Comment
-- toggle comment in both modes
map("n", "<C-k>", "<C-w>k")
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")

map("v", "<leader>/",
"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

--M.lspconfig = {
--  plugin = true,
--
--  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
--
--  n = {
--    ["gD"] = {
--      function()
--        vim.lsp.buf.declaration()
--      end,
--      "lsp declaration",
--    },
--
--    ["gd"] = {
--      function()
--        vim.lsp.buf.definition()
--      end,
--      "lsp definition",
--    },
--
--    ["K"] = {
--      function()
--        vim.lsp.buf.hover()
--      end,
--      "lsp hover",
--    },
--
--    ["gi"] = {
--      function()
--        vim.lsp.buf.implementation()
--      end,
--      "lsp implementation",
--    },
--
--    ["<leader>ls"] = {
--      function()
--        vim.lsp.buf.signature_help()
--      end,
--      "lsp signature_help",
--    },
--
--    ["<leader>D"] = {
--      function()
--        vim.lsp.buf.type_definition()
--      end,
--      "lsp definition type",
--    },
--
--    ["<leader>ca"] = {
--      function()
--        vim.lsp.buf.code_action()
--      end,
--      "lsp code_action",
--    },
--
--    ["gr"] = {
--      function()
--        vim.lsp.buf.references()
--      end,
--      "lsp references",
--    },
--
--    ["<leader>f"] = {
--      function()
--        vim.diagnostic.open_float()
--      end,
--      "floating diagnostic",
--    },
--
--    ["[d"] = {
--      function()
--        vim.diagnostic.goto_prev()
--      end,
--      "goto prev",
--    },
--
--    ["d]"] = {
--      function()
--        vim.diagnostic.goto_next()
--      end,
--      "goto_next",
--    },
--
--    ["<leader>q"] = {
--      function()
--        vim.diagnostic.setloclist()
--      end,
--      "diagnostic setloclist",
--    },
--
--    ["<leader>fm"] = {
--      function()
--        vim.lsp.buf.formatting {}
--      end,
--      "lsp formatting",
--    },
--
--    ["<leader>wa"] = {
--      function()
--        vim.lsp.buf.add_workspace_folder()
--      end,
--      "add workspace folder",
--    },
--
--    ["<leader>wr"] = {
--      function()
--        vim.lsp.buf.remove_workspace_folder()
--      end,
--      "remove workspace folder",
--    },
--
--    ["<leader>wl"] = {
--      function()
--        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--      end,
--      "list workspace folders",
--    },
--  },
--}

-- NvimTree

-- toggle
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")


-- Telescope
-- find
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>tk", "<cmd> Telescope keymaps <CR>")

-- git
map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")

return {

--------------------------------------------------------------------------------
-- Base plugins
--------------------------------------------------------------------------------

  { "nvim-lua/plenary.nvim" },

  {
    "williamboman/mason.nvim",
    config = function()
      require "plugins.configs.mason"
    end,
  },

--------------------------------------------------------------------------------
-- Functionality plugins
--------------------------------------------------------------------------------

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup{
        options = {
          theme = "catppuccin",
        },
        extensions = {
          "nvim-tree"
        },
        tabline = {
          lualine_a = { {'buffers',
            max_length = vim.o.columns * 9 / 10
          }},
        }
      }
    end
  },

  -- file picker
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    lazy = false,
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = true,
        view = {
          relativenumber = true,
          width = 45,
        },
        update_focused_file = {
          enable = true,
        },
        renderer = {
          highlight_git = true,
        },
        filters = {
          exclude = {
            ".env.*",     -- show .env files, even when ignored by a .gitignore
          },
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "   ",
          file_ignore_patterns = { "node_modules" },
          path_display = { "truncate" },
          set_env = { COLORTERM = "truecolor", },
          mappings = {
            n = { ["q"] = require("telescope.actions").close },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = "catppuccin",
    config = function()
      require("nvim-treesitter.configs").setup{
        indent = { enable = true },
        ensure_installed = {
          "lua",
          "python",
          "comment",
          "javascript",
          "typescript"
        },
        highlight = {
          enable = true,
          use_languagetree = true,
        },
      }

    end,
  },

  -- git in the sign coloumn
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup{
        signs = {
          add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
          change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
          delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
          topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
          changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        },
      }
    end,
  },

--------------------------------------------------------------------------------
-- Utility plugins
--------------------------------------------------------------------------------

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup{
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      }
      local cmp = require("cmp")
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  { "numToStr/Comment.nvim" },

  { "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts  = {
    },
  },

  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },

  { "folke/todo-comments.nvim" },

--------------------------------------------------------------------------------
-- Theme / asethetic plugins
--------------------------------------------------------------------------------

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme catppuccin]]
    end,
  },


  { "nvim-tree/nvim-web-devicons" },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
       exclude = {
         filetypes = {
           "help",
           "terminal",
           "packer",
           "lspinfo",
           "TelescopePrompt",
           "TelescopeResults",
           "mason",
           "",
         },
         buftypes = {
           "terminal",
         },
      },
    },
  },

--------------------------------------------------------------------------------
-- LSP (Language server protocol) plugins
--------------------------------------------------------------------------------

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").setup{
        history = true,
        updateevents = "TextChanged,TextChangedI",
      }

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },

  { "saadparwaiz1/cmp_luasnip" },

  { "hrsh7th/cmp-nvim-lua" },

  { "hrsh7th/cmp-nvim-lsp" },

  { "hrsh7th/cmp-buffer" },

  { "hrsh7th/cmp-path" },

}

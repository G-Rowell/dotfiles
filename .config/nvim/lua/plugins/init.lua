return {

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme catppuccin]]
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "v2.*", 
    config = function()
      require("bufferline").setup()
    end,
    dependencies = "nvim-tree/nvim-web-devicons"
  },

  {
    "tjdevries/express_line.nvim",
    config = function()
      require("el").setup{}
    end
  },

  {
    "nvim-tree/nvim-web-devicons",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup{
        indentLine_enabled = 0,
        filetype_exclude = {
          "help",
          "terminal",
          "packer",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "",
        },
        buftype_exclude = {
          "terminal"
        },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = true,
      }
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

  -- git stuff
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

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    config = function()
      require "plugins.configs.mason"
    end,
  },

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

  {
    "saadparwaiz1/cmp_luasnip",
  },

  {
    "hrsh7th/cmp-nvim-lua",
  },

  {
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    "hrsh7th/cmp-buffer",
  },

  {
    "hrsh7th/cmp-path",
  },

  -- misc plugins
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

  {
    "numToStr/Comment.nvim",
    -- keys = { "gc", "gb" },
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
  },

  {
    "folke/which-key.nvim",
    -- keys = "<leader>",
    config = function()
      require "plugins.configs.whichkey"
    end,
  },


  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "folke/todo-comments.nvim",
  },
}

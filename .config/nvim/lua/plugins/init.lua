return {

   {
      "nvim-lua/plenary.nvim",
   },

   {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
         vim.cmd [[colorscheme catppuccin]]
      end,
   },

   {
      'akinsho/bufferline.nvim',
      version = 'v2.*', 
      -- config = function()
      --    require("bufferline").setup()
      -- end,
      dependencies = 'kyazdani42/nvim-web-devicons'
   },

   {
      "tjdevries/express_line.nvim",
      config = function()
         require("plugins.configs.express_line")
      end
   },

   {
      "kyazdani42/nvim-web-devicons",
      config = function()
         require("plugins.configs.others").devicons()
      end,
   },

   {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
         require("plugins.configs.others").blankline()
      end,
   },

   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      dependencies = "catppuccin",
      config = function()
         require "plugins.configs.treesitter"
      end,
   },

   -- git stuff
   {
      "lewis6991/gitsigns.nvim",
      config = function()
         require("plugins.configs.others").gitsigns()
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
         require("plugins.configs.others").luasnip()
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
         require("plugins.configs.others").autopairs()
      end,
   },

   {
      "numToStr/Comment.nvim",
      -- keys = { "gc", "gb" },
      config = function()
         require("plugins.configs.others").comment()
      end,
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

   -- Only load whichkey after all the gui
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

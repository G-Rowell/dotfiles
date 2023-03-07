local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
   print "Cloning packer .."
   vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

   -- install plugins + compile their configs
   vim.cmd "packadd packer.nvim"
   require "plugins"
   vim.cmd "PackerSync"
end

return require('packer').startup(function(use)

   -- Speed up deffered plugins
   use {
      "lewis6991/impatient.nvim",
   }

   use {
      "nvim-lua/plenary.nvim",
   }

   use {
      "wbthomason/packer.nvim"
   }

   use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
         require("catppuccin").setup()
         vim.cmd [[colorscheme catppuccin]]
      end
   }

   use {
      'akinsho/bufferline.nvim',
      tag = "v2.*", 
      config = function()
         require("bufferline").setup{
         }      
      end,
      requires = 'kyazdani42/nvim-web-devicons'
   }

   use {
      "tjdevries/express_line.nvim",
      config = function()
         require("plugins.configs.express_line")
      end
   }

   use {
      "kyazdani42/nvim-web-devicons",
      config = function()
         require("plugins.configs.others").devicons()
      end,
   }

   use {
      "lukas-reineke/indent-blankline.nvim",
      opt = true,
      config = function()
         require("plugins.configs.others").blankline()
      end,
   }

   use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = "catppuccin",
      config = function()
         require "plugins.configs.treesitter"
      end,
   }

   -- git stuff
   use {
      "lewis6991/gitsigns.nvim",
      setup = function()
         require("plugins.configs.others").gitsigns()
      end,
      config = function()
         require("plugins.configs.others").gitsigns()
      end,
   }

   -- lsp stuff
   use {
      "williamboman/mason.nvim",
      config = function()
         require "plugins.configs.mason"
      end,
   }

   use {
      "neovim/nvim-lspconfig",
      opt = true,
      config = function()
         require "plugins.configs.lspconfig"
      end,
   }

   -- load luasnips + cmp related in insert mode only
   use {
      "rafamadriz/friendly-snippets",
      module = { "cmp", "cmp_nvim_lsp" },
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "plugins.configs.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.others").luasnip()
      end,
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   }

   -- misc plugins
   use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.others").autopairs()
      end,
   }

   use {
      "numToStr/Comment.nvim",
      module = "Comment",
      keys = { "gc", "gb" },
      config = function()
         require("plugins.configs.others").comment()
      end,
   }

   -- file managing , picker etc
   use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require "plugins.configs.nvimtree"
      end,
   }

   use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = function()
         require "plugins.configs.telescope"
      end,
   }

   -- Only load whichkey after all the gui
   use {
      "folke/which-key.nvim",
      module = "which-key",
      keys = "<leader>",
      config = function()
         require "plugins.configs.whichkey"
      end,
   }


   use {
      "max397574/better-escape.nvim",
      config = function()
         require("better_escape").setup()
      end,
   }

   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
   if packer_bootstrap then
      require('packer').sync()
   end
end)

local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local options = {
  indent = { enable = true },
  ensure_installed = {
    "lua",
    "python"
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
}

treesitter.setup(options)

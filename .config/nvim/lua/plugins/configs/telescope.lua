local present, telescope = pcall(require, "telescope")

if not present then
  return
end

vim.g.theme_switcher_loaded = true

local options = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules" },
    path_display = { "truncate" },
    set_env = { ["COLORTERM"] = "truecolor" },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
}

telescope.setup(options)

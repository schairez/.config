
-- require('telescope').load_extension('fzy_native')


-- local actions = require('telescope.actions')

--require('telescope').load_extension('media_files')


local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "$HOME/.config/nvim",
    file_ignore_patterns = {"lua%-language%-server/.*", "autoload/.*"}
  })
end

return M


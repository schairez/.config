vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1
}
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_window_picker_exclude = {
  filetype = {
    "packer",
    "qf",
    "Trouble"
  }
}

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★"
  },
  lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    },
  folder = {
    default = "",
    open = ""
  }
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {
  noremap = true,
  silent = true
})

vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {
  noremap = true,
  silent = true
})
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = true,
  open_on_tab         = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  --[[
  diagnostics = {
    enable = true,
  },
  --]]
  auto_close          = false,
  hijack_cursor       = true,
  update_cwd          = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = { 'fzf', 'help', 'git' }
  },
  ignore_ft_on_setup = { 'git', 'man', 'help' },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = { '.git', 'node_modules', 'dist' }
  },
  view = {
    width = 35,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { mode = "n", key = "<C-t>", cb = "<cmd>lua require'telescope.builtin'.live_grep()<cr>" }
      }
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
}
---
---
--------------------
--[[

local g = vim.g
g.nvim_tree_side = "left"
g.nvim_tree_width = 25
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
--g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ]
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_hijack_netrw = 1
g.nvim_tree_group_empty = 1
g.nvim_tree.diagnostics.enable = true
--g.nvim_tree_lsp_diagnostics = 1
g.nvim_tree_disable_window_picker = 1
g.nvim_tree_git_hl = 0
g.nvim_tree_root_folder_modifier = ":~"
g.nvim_tree_tab_open = 0
g.nvim_tree_allow_resize = 0

g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1
}

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    },
    git = {
    unstaged = '✹',
  },
}

require('nvim-tree').setup({
  disable_netrw = false,
  lsp_diagnostics = true,
  update_focused_file = {
    enable = true,
  },
  view = {
    auto_resize = true,
    mappings = {
      list = {
        { key = {'s'}, cb = ':lua require"nvim-tree".on_keypress("vsplit")<CR>' },
        { key = {'C'}, cb = ':lua require"nvim-tree".on_keypress("cd")<CR>'},
        { key = {'X'}, cb = ':lua require"nvim-tree".on_keypress("system_open")<CR>'},
      }
    }
  }
})
--]]

--[[

let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_lsp_diagnostics = 1

--]]


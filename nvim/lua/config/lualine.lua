

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {

    -- A component must be a table, not sequential args
    lualine_a = {{'mode'}},
    lualine_b = {
      {
        'filetype',
        colored = true
      },
    },
    lualine_c = {
      {
        'filename',
        path = 0,
      },
      {
        'diagnostics',
        sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
        color_error = '#ff0000',
        color_warn = '#dff705',
        color_info = '#16f70a',
        color_hint = '#05d8f0',
      },
    },
    lualine_x = {
      {
         'diff',
         colored = true,
         color_added = '#16f70a',
         color_modified = '#dff705',
         color_removed = '#ff0000',
         symbols = {added = ' 🞧 ', modified = ' ~ ', removed = ' ⊖ '}
      },
    },
    lualine_y = { 'branch' },
    lualine_z = {'location'}
  },


  inactive_sections = {
    lualine_a = {
        {
            'filetype',
            colored = true
        },
        {
            'filename',
            path = 0,
        },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_y = {},
    lualine_z = {}
  },

  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
  },
}



local function clock()
  return " " .. os.date("%H:%M")
end

local function lsp_progress(self, is_active)
  if not is_active then
    return ""
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    theme = "tokyonight",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    -- section_separators = { "", "" },
    -- component_separators = { "", "" },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { { "diagnostics", sources = { "nvim_diagnostic" } }, "filename" },
    lualine_x = { "filetype", lsp_progress },
    lualine_y = { "progress" },
    lualine_z = { clock },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" },
}

-- try to load matching lualine theme

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    config.options.theme = name
  end
  require("lualine").setup(config)
end

M.load()

-- vim.api.nvim_exec([[
--   autocmd ColorScheme * lua require("config.lualine").load();
-- ]], false)

return M





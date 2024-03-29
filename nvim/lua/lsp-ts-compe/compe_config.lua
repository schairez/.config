local M = {}

vim.o.completeopt = "menuone,noselect,noinsert"

require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 60;
  max_kind_width = 70;
  max_menu_width = 100;
  documentation = {
    border = "rounded", -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 100,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };


  source = {
    path = true;
    buffer = true;
    snippets_nvim = true;
    ultisnips = true;
    nvim_diagnostic = true;
    nvim_lua = true;
    calc = false;
    vsnip = false;
    spell = false;
    tags = false;
  };
}
vim.cmd [[
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
highlight link CompeDocumentation NormalFloat
]]

return M

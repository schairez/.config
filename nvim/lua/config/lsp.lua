
local nvim_lsp = require('lspconfig')

local on_attach = require'completion'.on_attach


local servers = {'gopls', 'jsonls', 'pyright', 'rust_analyzer', 'tsserver'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
   }
end 



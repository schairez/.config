
local nvim_lsp = require('lspconfig')
local on_attach = function(_, bufnr)
  require('completion').on_attach()
end 


local servers = {'gopls', 'jsonls', 'pyls_ms', 'rust_analyzer', 'tsserver'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
   }
end 



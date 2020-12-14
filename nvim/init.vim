
"Plugins
call plug#begin('~/.config/nvim/plugged')
"Color schemes 
Plug 'arcticicestudio/nord-vim'
"Plug 'lifepillar/gruvbox8'

"Tools 
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-markdown'


Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'honza/vim-snippets'
Plug '9mm/vim-closer' 

call plug#end()

command! Format execute 'lua vim.lsp.buf.formatting()'

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('diagnostic').on_attach()
    require('completion').on_attach()
  end 
  -- local servers = {'gopls', 'jsonls', 'pyls_ms', 'vimls', 'sumneko_lua', 'tsserver'}
  local servers = {'gopls', 'jsonls', 'pyls_ms'}
  for _, lsp in ipairs(servers) do
   nvim_lsp[lsp].setup {
     on_attach = on_attach,
   }
 end 
EOF

colorscheme nord 


"vim settings
set encoding=UTF-8
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

inoremap jk <ESC>










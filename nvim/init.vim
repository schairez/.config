"Sergii's vim config

"Plugins
call plug#begin('~/.config/nvim/plugged')

"Color schemes 
Plug 'arcticicestudio/nord-vim'
"Plug 'lifepillar/gruvbox8'

"Tools 
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-markdown'
"Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'honza/vim-snippets'
Plug '9mm/vim-closer' 

" telescope 
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Plug '/home/theprimeagen/personal/telescope.nvim'

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
call plug#end()

set termguicolors

colorscheme nord 


  "local servers = {'gopls', 'jsonls', 'pyls_ms', 'vimls', 'sumneko_lua', 'tsserver'}

lua require('lua_config')
lua require('config.lsp')

command! Format execute 'lua vim.lsp.buf.formatting()'

" 
" :lua << EOF
"   local nvim_lsp = require('lspconfig')
"   local on_attach = function(_, bufnr)
"     require('completion').on_attach()
"   end 
"   local servers = {'gopls', 'jsonls', 'pyls_ms'}
"   for _, lsp in ipairs(servers) do
"    nvim_lsp[lsp].setup {
"      on_attach = on_attach,
"    }
"  end 
" EOF
" 

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab 



"vim settings
let mapleader="\<Space>"
set nowrap
set encoding=UTF-8
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=a
set updatetime=300
set clipboard=unnamed       " copy+paste across vim instances in mac 
set hlsearch                " highlight search results
set ts=2 sts=2 sw=2 
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

inoremap jk <ESC>

set cursorline
set showcmd 
set number relativenumber 

" Telescope shortcuts 
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


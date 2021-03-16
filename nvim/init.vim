"Sergii's vim config

"Plugins
call plug#begin('~/.config/nvim/plugged')

"Color schemes 
Plug 'christianchiarulli/nvcode-color-schemes.vim'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/playground'

"Plug 'arcticicestudio/nord-vim'
"Plug 'lifepillar/gruvbox8'



"Tools 
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-markdown'
"Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

Plug 'honza/vim-snippets'
Plug '9mm/vim-closer' 

Plug 'kyazdani42/nvim-web-devicons'

" telescope 
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'
" unfortunately below only supported on linux
" Plug 'nvim-telescope/telescope-media-files.nvim'


"Plug '/home/theprimeagen/personal/telescope.nvim'

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
call plug#end()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

set termguicolors

"colorscheme nord 


  "local servers = {'gopls', 'jsonls', 'pyls_ms', 'vimls', 'sumneko_lua', 'tsserver'}

"lua require('config.telescope')
lua require('config.lsp')
lua require('lua_config')

command! Format execute 'lua vim.lsp.buf.formatting()'


" configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

syntax on
"aurora
"gruvbox
colorscheme aurora


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif


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
set nu
set nohlsearch
set hidden 
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile 

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"lsp settings
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c


" Telescope shortcuts 
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>vrc :lua require('lua_config').search_dotfiles()<CR>



"Sergii's vim config

"Plugins
call plug#begin(stdpath('data') . '/plugged')

"Color schemes
Plug 'christianchiarulli/nvcode-color-schemes.vim'
"Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" colorizer
Plug 'norcalli/nvim-colorizer.lua'

"Plug 'nvim-treesitter/playground'

"dashboard
Plug 'glepnir/dashboard-nvim'

Plug 'tjdevries/cyclist.vim'

"Tools 
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-markdown'
Plug 'ellisonleao/glow.nvim'
Plug 'vimwiki/vimwiki'
"Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'elixir-lang/vim-elixir'

"git signs
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-lua/lsp-status.nvim' " lsp info in statusline
Plug 'nanotee/sqls.nvim' " SQL lang server for neovim



Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
"Plug 'honza/vim-snippets'
Plug '9mm/vim-closer'

"lua line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'

" telescope 
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'fhill2/telescope-ultisnips.nvim'

Plug 'christoomey/vim-tmux-navigator'

" unfortunately below only supported on linux
" Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"toggleterm
Plug 'akinsho/toggleterm.nvim'

call plug#end()


" Example config in VimScript
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }
"lua vim.g.tokyonight_style == "day"

colorscheme tokyonight



lua require("util")




"lua syntax highlighting in vim files
let g:vimsyn_embed = 'l'
"lua require('config.telescope-cfg')


" lua << EOF 
" require('bufferline').setup{
" options = {
 "   numbers = "none", 
 "   }
"}
"EOF

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
lua require'nvim-web-devicons'.setup {default = true}
lua require'nvim-web-devicons'.get_icons()


lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

EOF

let g:python_host_prog = $HOME . "/pyenv/shims/python"
let g:python3_host_prog =  $HOME . "/pyenv/versions/neovim3/bin/python"

let g:glow_binary_path = $HOME . "/bin"


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif


lua require'colorizer'.setup()

"set termguicolors
"color nord
"let g:nord_contrast = v:true
"let g:nord_borders = v:false
"let g:nord_disable_background = v:true
"let g:nord_italic = v:false



lua require('lsp-ts-compe.compe_config')
lua require('lsp-ts-compe.lsp-starter')
lua require('lsp-ts-compe.tree-sitter-cfg')





lua << EOF

local actions = require('telescope.actions')
-- Global remapping
------------------------------
-- '--color=never',
--require('telescope').load_extension('media_files')
require('telescope').setup {
    extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  },
    defaults = {
        vimgrep_arguments = {
          'rg',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case'
        },
        --prompt_position = "top",
        prompt_prefix = " >",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top", 
            preview_width = 0.55,
            results_width = 0.8,
            --mirror = false,
          },
          vertical = {
            mirror = false, 
            --width = 0.5
          }, 
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120
        },
        --layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = {
        'shorten',
        'absolute',
        },
        winblend = 0,
        -- preview_cutoff = 120,
        --results_height = 1,
        --results_width = 0.8,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
                -- ["<esc>"] = actions.close,
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    },
}




require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
    autotag = {
        enable = true,
    },
}


EOF


"nvim-tree shortcuts

lua require('config.nvim-tree')
lua require('config.bufferline')
lua require('config.lualine')
" lua require('config.treesitter')

lua require('gitsigns').setup()






command! Format execute 'lua vim.lsp.buf.formatting()'

let g:nord_cursor_line_number_background = 1
let g:nord_bold_vertical_split_line = 1
let g:nord_uniform_diff_background = 1
let g:nord_italic_comments = 1
let g:nord_italic = 1
let g:nord_underline = 1



set bg=dark

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

syntax on


set colorcolumn=80,100


autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab 

set errorformat^=%f\|%l\ col\ %c\|%m
"TODO: figure out why listchars not working 
"
"set listchars=tab:▸\ ,eol:↲,trail:·

set list listchars=tab:▸\ ,eol:↲,trail:·
"
" lua vim.opt.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

"vim settings
let mapleader="\<Space>"
set lazyredraw
set nowrap
set encoding=UTF-8
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=a
set updatetime=300
set clipboard+=unnamedplus  " copy+paste across vim instances in mac 
set hlsearch                " highlight search results
set ts=2 sts=2 sw=2
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
syntax enable
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


"bottom terminal
command Bterm bo 10sp +term
"command Bterm botright terminal
nmap <leader>tt :Bterm<CR>

"nnoremap <silent> <c-t> <cmd>Bterm<CR>

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Use ctrl-[hjkl] to select the active split!
" from:
" <https://stackoverflow.com/questions/6053301/easier-way-to-navigate-between-vim-split-panes#6053341>

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>



" prev version
" note to close all splits but this one do :only or :on
"
" alternatively, do <C-w>o
"nnoremap gh <C-W><C-H>
"nnoremap gj <C-W><C-J>
"nnoremap gk <C-W><C-K>
"nnoremap gl <C-W><C-L>











" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes




augroup java
  au!
  au FileType java setlocal sts=4
  au FileType java setlocal sw=4
  au FileType java setlocal ts=4
augroup END

" Go specific mapping
augroup go
  au!
  au filetype go nmap <leader>t :w<CR>:GoTestFunc<CR>
  au filetype go nmap <leader>T :w<CR>:GoTest<CR>
  au filetype go nmap <leader>r :w<CR>:GoRun<CR>
  au filetype go nmap <leader>b :GoDebugBreakpoint<CR>
  au filetype go nmap <leader>d :GoDebugStart<CR>
  au filetype go nmap <leader>s :GoDebugStop<CR>
  au filetype go nmap <leader>n :GoDebugNext<CR>
  au filetype go nmap <leader>c :GoDebugContinue<CR>
  au filetype go nmap <leader>i <Plug>(go-info)
augroup END

augroup javascript
  au!
  au filetype javascript nmap <leader>r :w<CR>:!node %<CR>
  au filetype typescriptreact nmap <leader>t :w<CR>:split term://jest %<CR>G
  au filetype javascriptreact nmap <leader>t :w<CR>:split term://jest %<CR>G
  au filetype typescript nmap <leader>t :w<CR>:split term://jest %<CR>G  au filetype javascript nmap
augroup END


"format json with jq
au filetype json nmap <leader>f :%!jq '.' %<CR>

"format HCL files; requires hclfmt
au filetype hcl nmap <leader>f :%!hclfmt %<CR>






" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>


" Show diagnostic popup on cursor hold
"   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.open_float()<CR>', opts)

"autocmd CursorHold * lua vim.lsp.diagnostic.open_float()

" Goto previous/next diagnostic warning/error
"nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Go 

noremap gd :GoDef<CR>
noremap gr :GoRun<CR>
noremap gf :GoFmt<CR>
noremap gl :GoLint<CR>
noremap gm :GoMetaLinter<CR>

"lsp settings
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"set completeopt=menuone,noselect
set completeopt=menuone,noinsert,noselect


" Avoid showing message extra message when using completion
set shortmess+=c


"nvim tree
"nnoremap <C-n> :NvimTreeToggle<CR>
"nnoremap <leader>r :NvimTreeRefresh<CR>
"nnoremap <leader>n :NvimTreeFindFile<CR>

" Telescope shortcuts 
"lua require('telescope').load_extension('fzf')
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>vrc :lua require('lua_config').search_dotfiles()<CR>

"buffferline
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>


"dashboard 

let g:dashboard_default_executive ='telescope'
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
" nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>ct :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fg :DashboardFindWord<CR>
nnoremap <silent> <Leader>fm :DashboardJumpMark<CR>
nnoremap <silent> <Leader>nf :DashboardNewFile<CR>
let g:dashboard_custom_shortcut={
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'new_file'           : 'SPC n f',
\ 'change_colorscheme' : 'SPC c t',
\ 'find_word'          : 'SPC f g',
\ 'book_marks'         : 'SPC f m',
\ }
let s:header = [
\'            __                    ',
\'           / /\                   ',
\'         / /   \                  ',
\'        / /    \__________        ',
\'       / /      \        /\       ',
\'      /_/        \      / /       ',
\'   ___\ \      ___\____/_/_       ',
\'  /____\ \    /___________/\      ',
\'  \     \ \   \           \ \     ',
\'   \     \ \   \____       \ \    ',
\'    \     \ \  /   /\       \ \   ',
\'     \   / \_\/   / /        \ \  ',
\'      \ /        / /__________\/  ',
\'       /        / /     /         ',
\'      /        / /     /          ',
\'     /________/ /\    /           ',
\'     \________\/\ \  /            ',
\'                 \_\/ @sergii     ',
\ '                                 ',
\ ]




let s:footer = []
let g:dashboard_custom_header = s:header
let g:dashboard_custom_footer = s:footer


" spotify-tui
" open a shell in a new split (= default behavior)
"nmap <C-Return> :call TermOpen()<CR>
"nmap <Leader>T :call TermOpen('spt, 'm')<CR>


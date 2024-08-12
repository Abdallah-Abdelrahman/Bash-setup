set tabstop=8 shiftwidth=8
set autoindent
set smartindent
set cindent
syntax enable
set number
"set relativenumber
set encoding=UTF-8
set guifont=CascadiaCode\ 14
set clipboard+=unnamedplus
set ignorecase
" change line ending in dos
set ff=unix

" Update indentation for html and css
autocmd Filetype html,css,sql setlocal tabstop=4 shiftwidth=4 expandtab
" Update indentation for puppet
autocmd Filetype puppet setlocal tabstop=2 shiftwidth=2 expandtab
" Update indentation for js, jsx, tsx
autocmd Filetype javascript,javascriptreact,typescriptreact,typescript setlocal tabstop=2 shiftwidth=2 expandtab

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

" set leader key to space
" let mapleader = " "

" key binding for flodmethod=indent
nnoremap <leader>fm :set foldmethod=indent<CR>

" toggle buffers
nnoremap <leader>bb :b#<CR>

" Mapping file explorer key bindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>r :NERDTreeRefreshRoot<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:webdevicons_enable_nerdtree = 1

" theme for neovim
colorscheme tokyonight-night

" No highlight bindings
nnoremap <silent> <Leader><Space> :noh<CR>

" Exit NERDTree if it's the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Powerline symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'
let g:airline_theme='hybrid'

" For automatic formatting on save `.js` using eslint
autocmd bufwritepost *.js,*.tsx,*.jsx silent !eslint % --fix
" autocmd bufwritepost *.js silent !semistandard % --fix
" set autoread

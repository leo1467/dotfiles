" Vim C/C++ 開發專用 vimrc

"============================
" 基礎設定
"============================
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set fileencodings=utf-8,big5,gb2312,gbk,euc-jp,euc-kr,iso8859-1
set fileformats=unix

"============================
" 顯示與介面
"============================
"set number
"set relativenumber
set showcmd
set cursorline
set wrap
set nohlsearch
set incsearch
"set termguicolors
set background=dark

"============================
" 縮排與格式
"============================
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set cindent

"============================
" 摺疊設定
"============================
set foldmethod=syntax
set foldlevel=99

"============================
" 顏色主題
"============================
"colorscheme default

"============================
" 快捷鍵設定
"============================
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprev<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F5> :w\|!g++ % -o %< && ./%<<CR>

"============================
" 自動格式化
"============================
if executable('clang-format')
    autocmd BufWritePre *.c,*.cc,*.cpp,*.h,*.hpp silent! execute ':%!clang-format'
endif

"============================
" Plugin 管理 (vim-plug)
"============================
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'

call plug#end()

"============================
" coc.nvim 設定 (for C/C++)
"============================
let g:coc_global_extensions = ['coc-clangd']

"============================
" 自動啟動 Tagbar, NERDTree（可選）
"============================
" autocmd VimEnter * NERDTree
" autocmd VimEnter * TagbarOpen


let mapleader=","
" Coc.nvim 快捷鍵設定
nnoremap <leader>a :call CocActionAsync('codeAction')<CR>
"nnoremap <leader>r :CocCommand editor.action.rename<CR>
nnoremap <leader>f :call CocActionAsync('format')<CR>
nnoremap <leader>d :call CocActionAsync('jumpDefinition')<CR>
nnoremap <leader>e :CocList diagnostics<CR>
nnoremap <silent> <leader>s :CocList symbols<CR>

" 使用 coc.nvim 的跳轉功能
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 回到跳轉前的位置
nmap <silent> <C-o> <C-o>

" （進階）定義開新分頁
nmap <silent> gD :call CocActionAsync('jumpDefinition', 'tabedit')<CR>

" （進階）定義開 split
nmap <silent> gs :call CocActionAsync('jumpDefinition', 'split')<CR>


" 不顯示 Diagnostic VirtualText，只用浮動視窗提示
let g:coc_diagnostic_virtual_text = 0

" 讓 Inlay Hint 幾乎消失
highlight CocInlayHint guifg=#444444 ctermfg=8


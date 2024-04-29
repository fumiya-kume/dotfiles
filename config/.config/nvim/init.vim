set number
set expandtab
set smartindent
set shiftwidth=1
set autochdir
set autoread
set encoding=utf-8
set fileencoding=utf-8
set wildmode=longest,full
set clipboard+=unnamed,unnamedplus
set syntax=enable
filetype on
" 検索した文字のハイライト
set hls
let mapleader = "\<Space>"

if &shell =~# 'fish$'
    set shell=zsh
endif

" インラインブロックを中括弧付きのブロックに展開
nnoremap <C-j> ^/(<CR>%a{<CR><Esc>o}<Esc>

"挿入モード終了時にIMEをオフ
inoremap <silent> <Esc> <Esc>:call system('fcitx-remote -c')<CR>
filetype plugin indent on
autocmd BufReadPost *.kt setlocal filetype=kotlin

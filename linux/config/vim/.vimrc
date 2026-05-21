" mapleader
let g:mapleader = " "

" set colorscheme
set termguicolors
colorscheme desert

" sets
"set number
set relativenumber
set nu

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smartindent
set nowrap

set nohlsearch
set incsearch
set scrolloff=8
set sidescrolloff=2
set signcolumn="yes"
set splitbelow

set timeout
set timeoutlen=1000
set timeout
set timeoutlen=250
set colorcolumn="80"

set mouse=a

" remaps

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

tmap <Esc> <C-\><C-n>
tmap <C-w> <C-\><C-n><C-w>

nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap <C-j> <cmd>cnext<CR>
nnoremap <C-k> <cmd>cprev<CR>

nnoremap <leader>j <cmd>lnext<CR>
nnoremap <leader>k <cmd>lprev<CR>

nnoremap <C-c> <Esc>
nnoremap <leader>pv <cmd>Ex<cr>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <leader>c "+c
nnoremap <leader>d "_d
nnoremap <leader>p "_p
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y

nnoremap <leader>e <C-^>

nnoremap <leader><leader> <cmd>so %<CR>
nnoremap <leader>xx <cmd>!chmod +x %<CR>

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

nnoremap Q <nop>

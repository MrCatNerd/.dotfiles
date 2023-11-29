" mapleader
let g:mapleader = " "

" set colorscheme
colorscheme elflord

" sets
" set number
set relativenumber
set nu
set notermguicolors

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

"remaps

nmap <C-c> <Esc>
nmap <leader>pv <cmd>Ex<cr>
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap <leader>p "_dP
nmap <leader>y "+y
nmap <leader>Y "+Y
nmap <leader>c "+c
nmap <leader>d "_d
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nmap <C-j> <cmd>cnext<CR>
nmap <C-k> <cmd>cprev<CR>
nmap <leader>j <cmd>lnext<CR>
nmap <leader>k <cmd>lprev<CR>
vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

tmap <Esc> <C-\><C-n>
tmap <C-w> <C-\><C-n><C-w>

nnoremap <leader>e <C-^>
nnoremap <leader><leader> <cmd>so %<CR>
nnoremap <leader>xx <cmd>!chmod +x %<CR>
nnoremap <C-f> <cmd>silent !tmux neww tmux-sessionizer<CR>
nnoremap Q <nop>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z


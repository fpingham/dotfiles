set background=dark

set nocompatible
filetype off

let g:pymode_python = 'python3'

set mouse=a
set t_Co=256
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set foldcolumn=3

" Map leader to space bar
let mapleader = "\<Space>"

" Line numbering
set nu

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" The bundles you install will be listed here
Plugin 'tmhedberg/SimpylFold'

Plugin 'Konfekt/FastFold'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-surround'

" For indent lines
Plugin 'thaerkh/vim-indentguides'

" For auto completion
Plugin 'Valloric/YouCompleteMe'

" For prettier
Plugin 'w0rp/ale'

" JSBeautify
Plugin 'maksimr/vim-jsbeautify'

" Zenburn color scheme
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'

" Vim-tmux navigator
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()            " required
filetype plugin indent on

" Choose colorscheme
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Python syntax highlighting
let python_highlight_all=1
syntax on
set encoding=utf-8

" Hide .pyc files in NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set backupdir=~/vimfiles/tmp,.
set directory=~/vimfiles/tmp,.

set pastetoggle=<F9>
set expandtab

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=119 expandtab autoindent fileformat=unix
setlocal foldmethod=expr

map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>>>

au BufNewFile,BufRead *.js,*.html,*.css: set tabstop=2 softtabstop=2 shiftwidth=2
 set list
 set listchars=tab:>-

map <Leader>vs :source $HOME/.vimrc<CR>
map <Leader>vd :PluginInstall<CR>

map g] :stj<CR>
map <Leader>= <C-W>=
map <Leader><CR> <C-W>_
map <Leader><Up> <C-W><Up><C-W>_
map <Leader><Down> <C-W><Down><C-W>_
map <Leader>1 99<C-W><Up><C-W>_
map <Leader>2 99<C-W><Up>1<C-W>j<C-W>_
map <Leader>3 99<C-W><Up>2<C-W>j<C-W>_
map <Leader>4 99<C-W><Up>3<C-W>j<C-W>_
map <Leader>5 99<C-W><Up>4<C-W>j<C-W>_
map <Leader>p Oimport pdb; pdb.set_trace()^[

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-]> g<C-]>

" Save file in normal and insert mode
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>gi
nnoremap zzz :wq<cr>
inoremap zzz <Esc>:wq<cr>gi

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Insert two parentheses if the opening one is inserted
:inoremap { {}<Esc>i
:inoremap ( ()<Esc>i
:inoremap [ []<Esc>i
:inoremap < <><Esc>i

"python with virtualenv support for 'YouCompleteMe' packageipyE << EOF
py3 << EOF
import sys
import os
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

let g:SimpylFold_docstring_preview=1

" Run eslint from VIM
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python' : ['autopep8', 'remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['eslint'],
\ 'html': ['tidy', 'prettier'],
\ 'css' : ['prettier'],
\ }

" ALE options
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
nnoremap <leader>d :ALEFix<CR>

" YouCompleteMe options
let g:ycm_global_ycm_extra_conf = ".vim/bundle/YouCompleteMe/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = {
	\   'python': [ 're!(import\s+|from\s+(\w+\s+(import\s+(\w+,\s+)*)?)?)' ]
	\ }

".vimrc
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

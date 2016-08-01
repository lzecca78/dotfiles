#!/bin/bash

apt-get install -y git
cd ~
#### make a backup

mv ~/.vim ~/vim_`date +%y%m%d%H%M%S`
mkdir .vim

cd ~
ln -s ~/.vim/vimrc .vimrc


#install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


cat > ~/.vim/vimrc <<END

call plug#begin('~/.vim/plugged')

function!  SolarizedCustomization()
"solarized modification
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
endfunction

function! CtrlpCustomization()
set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_custom_ignore = '\.git$\|\.tmp$\|\.work$'
endfunction

function! TabularCustomization()
set AddTabularPattern block /=>
endfunction


Plug 'http://github.com/tpope/vim-fugitive.git'
Plug 'http://github.com/airblade/vim-gitgutter.git'
Plug 'http://github.com/altercation/vim-colors-solarized.git', { 'do': function('SolarizedCustomization') }
Plug 'http://github.com/airblade/vim-gitgutter.git'
Plug 'http://github.com/tpope/vim-endwise.git'
Plug 'http://github.com/kana/vim-textobj-user'
Plug 'http://github.com/nelstrom/vim-textobj-rubyblock'
Plug 'http://github.com/ervandew/supertab.git'
Plug 'http://github.com/kien/ctrlp.vim.git', { 'do': function('CtrlpCustomization') }
Plug 'http://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tfnico/vim-gradle.git'
Plug 'http://github.com/vim-airline/vim-airline'
Plug 'http://github.com/vim-airline/vim-airline-themes'
Plug 'http://github.com/taku-o/vim-changed.git'
Plug 'http://github.com/rodjek/vim-puppet.git'
Plug 'http://github.com/derekwyatt/vim-scala.git'
Plug 'http://github.com/elzr/vim-json.git'
Plug 'http://github.com/jelera/vim-javascript-syntax.git'
Plug 'http://github.com/tpope/vim-commentary'
Plug 'http://github.com/gabrielelana/vim-markdown'
Plug 'http://github.com/markcornick/vim-vagrant.git'
Plug 'http://github.com/godlygeek/tabular.git', { 'do': function('TabularCustomization') }

call plug#end()



let g:syntastic_php_checkers=['php']

"Airline setup
let g:airline_powerline_fonts = 0
let g:airline_symbols = {}
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='bubblegum'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#tab_nr_type = 1

set autoindent
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set incsearch
set hlsearch
set ignorecase
set smartcase
set encoding=utf-8
set showcmd
set comments=sr:/*,mb:*,ex:*/
set wildmenu
set wildmode=longest,full
set wildignore=.svn,.git
set nocompatible
set laststatus=2
set lisp


"enable autoremove of trailing dots
set list listchars=tab:»·,trail:·
autocmd BufWrite * if ! &bin | :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"lists of commentstring for multiple language
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType php set commentstring=//\ %s
autocmd FileType apache set commentstring=#\ %s

"handle erb template syntax highlight
autocmd BufRead,BufNewFile *.erb set filetype=eruby.htm

"git commit wrap message
autocmd Filetype gitcommit setlocal spell textwidth=72

"remove conceal for vim-json plugin
let g:vim_json_syntax_conceal = 0

if !empty(glob("/usr/bin/python3"))
let g:syntastic_python_python_exec = '/usr/bin/python3'
endif


END

#vim -c ':helptags ~/.vim/plugged/ctrlp.vim/doc|q!'
#vim -c ':Helptags|q!'
vim </dev/tty +PlugInstall +PlugClean +qall

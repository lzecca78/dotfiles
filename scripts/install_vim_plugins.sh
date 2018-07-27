#!/bin/bash
#### check if vim 8 is installed, otherwise exit:
vim_version=`vim --version | head -n1 | awk '{print $5}'`

if [[ $vim_version =~ 8.* ]]
then
    echo "installed vim version is at least 8, we can proceed because is compatible with all plugins"
else
    echo "sorry, your vim version is not 8 (version = $vim_version), please add this ppa (sudo add-apt-repository ppa:jonathonf/vim

) and then upgrade your vim version before retry this script"
    exit 2
fi


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


"function!  SolarizedCustomization()
"set background=dark
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"colorscheme solarized8_low
"endfunction

function! CtrlpCustomization()
set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_custom_ignore = '\.git$\|\.tmp$\|\.work$'
endfunction

function! TabularCustomization()
set AddTabularPattern block /=>
endfunction


Plug 'http://github.com/drewtempelmeyer/palenight.vim'
Plug 'http://github.com/tpope/vim-fugitive.git'
"Plug 'http://github.com/lifepillar/vim-solarized8.git', { 'do': function('SolarizedCustomization') }
Plug 'http://github.com/airblade/vim-gitgutter.git', { 'do': function('GitGutterLineHighlightsEnable') }
Plug 'http://github.com/tpope/vim-endwise.git'
Plug 'http://github.com/kana/vim-textobj-user'
Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'fatih/molokai'
Plug 'http://github.com/jiangmiao/auto-pairs.git'
Plug 'http://github.com/tpope/vim-surround.git'
Plug 'https://github.com/ain/vim-capistrano'
Plug 'http://github.com/nelstrom/vim-textobj-rubyblock'
Plug 'http://github.com/ervandew/supertab.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git', { 'do': function('CtrlpCustomization') }
Plug 'https://github.com/w0rp/ale'
Plug 'https://github.com/hashivim/vim-terraform.git'
Plug 'https://github.com/juliosueiras/vim-terraform-completion'
Plug 'https://github.com/tfnico/vim-gradle.git'
Plug 'https://github.com/honza/dockerfile.vim'
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

"Terraform setup for auto 'terraform fmt'
let g:terraform_align=1


"set background=dark
"colorscheme palenight

"Go imports instead of gofmt
let g:go_fmt_command = "goimports"
"Go syntax highlights
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
let g:go_auto_sameids = 1
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

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
set t_RV=


"enable autoremove of trailing dots
set list listchars=tab:»·,trail:·
autocmd BufWrite * if ! &bin | :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"lists of commentstring for multiple language
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType php set commentstring=//\ %s
autocmd FileType apache set commentstring=#\ %s
autocmd FileType terraform setlocal commentstring=#%s


"handle erb template syntax highlight
autocmd BufRead,BufNewFile *.erb set filetype=eruby.htm

"handle eyaml template with yaml syntax"
autocmd BufNewFile,BufRead *.eyaml   set syntax=yaml

" Allow multiple paste
xnoremap p pgvy

"git commit wrap message
autocmd Filetype gitcommit setlocal spell textwidth=72

"remove conceal for vim-json plugin
let g:vim_json_syntax_conceal = 0

if !empty(glob("/usr/bin/python3"))
let g:syntastic_python_python_exec = '/usr/bin/python3'
endif


" associate Jenkinsfile to groovy syntax and filetype
au BufReadPost Jenkinsfile set syntax=groovy
au BufReadPost Jenkinsfile set filetype=groovy

"speedup Ctrl-P on git projects
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif


END

#vim -c ':helptags ~/.vim/plugged/ctrlp.vim/doc|q!'
#vim -c ':Helptags|q!'
vim </dev/tty +PlugInstall +PlugClean +qall

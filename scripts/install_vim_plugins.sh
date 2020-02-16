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
pip install yamllint
cd ~
#### make a backup

mv ~/.vim ~/vim_`date +%y%m%d%H%M%S`
mkdir .vim

cat > ~/.vim/coc-settings.json << EOF
{
  "yaml.completion": true,
  "yaml.validate": true,
  "yaml.format.enable": true,
  "yaml.schemas": {
    "kubernetes": ["/*.yaml", "/*.yml"]
  },

  "languageserver": {
    "golang": {
      "command": "gopls",
      "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
      "filetypes": ["go"]
    }
  }
}
EOF

cd ~
ln -s ~/.vim/vimrc .vimrc


#install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


cat > ~/.vim/vimrc <<END

call plug#begin('~/.vim/plugged')

" remap leader
let mapleader=','

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

Plug 'http://github.com/drewtempelmeyer/palenight.vim'
Plug 'http://github.com/tpope/vim-fugitive.git'
Plug 'http://github.com/airblade/vim-gitgutter.git'
Plug 'http://github.com/tpope/vim-endwise.git'
Plug 'http://github.com/kana/vim-textobj-user'
Plug 'http://github.com/nelstrom/vim-textobj-rubyblock'
Plug 'christianrondeau/vim-base64'
Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'https://github.com/jvirtanen/vim-hcl.git'
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'fatih/molokai'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'http://github.com/jiangmiao/auto-pairs.git'
Plug 'http://github.com/tpope/vim-surround.git'
Plug 'https://github.com/ain/vim-capistrano'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git', { 'do': function('CtrlpCustomization') }
Plug 'https://github.com/w0rp/ale'
Plug 'https://github.com/hashivim/vim-terraform.git'
Plug 'https://github.com/juliosueiras/vim-terraform-completion'
Plug 'https://github.com/tfnico/vim-gradle.git'
Plug 'ekalinin/Dockerfile.vim'
Plug 'http://github.com/vim-airline/vim-airline'
Plug 'http://github.com/vim-airline/vim-airline-themes'
Plug 'http://github.com/rodjek/vim-puppet.git'
Plug 'http://github.com/derekwyatt/vim-scala.git'
Plug 'http://github.com/elzr/vim-json.git'
Plug 'http://github.com/jelera/vim-javascript-syntax.git'
Plug 'http://github.com/tpope/vim-commentary'
Plug 'http://github.com/markcornick/vim-vagrant.git'
Plug 'http://github.com/godlygeek/tabular.git'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

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

" NerdTree Setup
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
let g:NERDTreeShowIgnoredStatus = 1

"Terraform setup for auto 'terraform fmt'
let g:terraform_align=1

"folding
set foldmethod=manual
set foldlevelstart=20

" fzf
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>h :History<CR>
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>L :Lines<CR>
nnoremap <Leader>C :Commands<CR>


"move between tab
nnoremap <C-H> :tabprevious<CR>
nnoremap <C-L> :tabnext<CR>

"prettier configuration
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

"set background=dark
"colorscheme palenight
set backspace=indent,eol,start


"Go imports instead of gofmt
let g:go_fmt_command = "goimports"
"Go syntax highlights
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_def_mode='godef'
let g:go_auto_sameids = 1
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

let g:coc_global_extensions = ['coc-yaml', 'coc-json']


" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, <C-g>u means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
""inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use [c and ]c to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: <leader>aap for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use :Format to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use :Fold to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use :OR for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout :h coc-status
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


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

"treat dash as keyword
set iskeyword+=-


"indentation for yaml file
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


"enable autoremove of trailing dots
set list listchars=tab:»·,trail:·
autocmd BufWrite * if ! &bin | :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"lists of commentstring for multiple language
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType php set commentstring=//\ %s
autocmd FileType apache set commentstring=#\ %s
autocmd FileType terraform setlocal commentstring=#%s

"set autoprettify
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.yml,*.html Prettier

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

" do not use arrows!!
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

nnoremap <Left> :echoe "Use h"<nop>
nnoremap <Right> :echoe "Use l"<nop>
nnoremap <Up> :echoe "Use k"<nop>
nnoremap <Down> :echoe "Use j"<nop>

END

#vim -c ':Helptags|q!'
vim </dev/tty +PlugInstall +PlugClean +qall

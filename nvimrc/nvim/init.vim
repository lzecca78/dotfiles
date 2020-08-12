"No compatibility to traditional vi
set nocompatible

"vim-plug
call plug#begin('~/.config/nvim/plugged')

function! CtrlpCustomization()
set runtimepath^=~/.config/nvim/plugged/ctrlp.vim
let g:ctrlp_custom_ignore = '\.git$\|\.tmp$\|\.work$'
endfunction

"Plugin list ------------------------------------------------------------------
"
"
"
"

"My plugins
"
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-fugitive.git'
Plug 'https://github.com/dhruvasagar/vim-zoom.git'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'kana/vim-textobj-user'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'christianrondeau/vim-base64'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'https://github.com/jvirtanen/vim-hcl.git'
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'fatih/molokai'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git', { 'do': function('CtrlpCustomization') }
Plug 'w0rp/ale'
Plug 'https://github.com/hashivim/vim-terraform.git'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'ekalinin/Dockerfile.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/rodjek/vim-puppet.git'
Plug 'derekwyatt/vim-scala.git'
Plug 'https://github.com/elzr/vim-json.git'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'tpope/vim-unimpaired'
Plug 'tsandall/vim-rego'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'https://github.com/markcornick/vim-vagrant.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"my plugins end



"End plugin list --------------------------------------------------------------
call plug#end()

"Syntax highlighting.
syntax on

"Softtab -- use spaces instead tabs.
set expandtab
set tabstop=4 shiftwidth=4 sts=4
set autoindent nosmartindent

filetype plugin on

" fzf
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>h :History<CR>
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>L :Lines<CR>
nnoremap <Leader>C :Commands<CR>

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'


"These languages have their own tab/indent settings.
au FileType gitcommit setl spell


"English spelling checker.
setlocal spelllang=en_us


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


" Ale Setup
let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 0
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

let g:ale_linters = {
\   'markdown':      ['writegood'],
\}

let g:ale_fixers = {
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\}


"prettier configuration
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

"==================== NerdTree ====================
"
"
"
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
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
set autochdir
let NERDTreeChDirMode=2
let g:NERDTreeShowIgnoredStatus = 1
au VimEnter *  NERDTreeFind | wincmd p
autocmd StdinReadPre * let s:std_in=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1

" Close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Terraform setup for auto 'terraform fmt'
let g:terraform_align=1

"folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

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


"set background=dark
"colorscheme palenight
set backspace=indent,eol,start

" vim-go
"Go imports instead of gofmt
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
"Go syntax highlights
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_def_mode='godef'
let g:go_auto_sameids = 1
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
au BufNewFile,BufRead Jenkinsfile setf groovy


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




" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


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


"quickly move beteen buffer
map <C-J> :bprevious<CR>
map <C-K> :bnext<CR>

" move between splits
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" do not use arrows!!
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

nnoremap <Left> :echoe "Use h"<nop>
nnoremap <Right> :echoe "Use l"<nop>
nnoremap <Up> :echoe "Use k"<nop>
nnoremap <Down> :echoe "Use j"<nop>

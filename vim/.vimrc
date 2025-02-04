" FileType On
filetype plugin indent on
syntax on

" Common configuration
set encoding=UTF-8
set nocompatible
set number
set foldenable
set splitbelow
set splitright
set listchars=tab:>>,trail:.,extends:>
set expandtab
set backspace=indent,eol,start
set ruler " show line number of cursor
set colorcolumn=120
let &winheight = &lines * 7 / 10

" Common file tab settings
set softtabstop=4
set tabstop=4
set ts=4
set shiftwidth=4
set expandtab
set autoindent

" Find settings
set incsearch   " show match cases when inputting
set hlsearch
set ignorecase  " Ignore case when searching

" Command line configuration
set wildmenu
set showcmd
set showmode
set showmatch
set cmdheight=1

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Bind >> << to tab moving
xnoremap < <gv
xnoremap > >gv

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Save cursor position when closing vim
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Autocomplete {} [] () etc...
function! QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
      " Inserting a quoted quotation mark into the string
      return a:char
  elseif line[col - 1] == a:char
      " Escaping out of the string
      return "\<Right>"
  else
      " Starting a string
      return a:char.a:char."\<Esc>i"
  endif
endfunction!

function! CloseBracket()
    let line = getline('.')
    if line =~# '^\s*\(struct\|class\|enum\) '
        return "{\<Enter>};\<Esc>O"
    elseif searchpair('(', '', ')', 'bmn', '', line('.'))
        " Probably inside a function call. Close it off.
        return "{\<Enter>});\<Esc>O"
    else
        return "{\<Enter>}\<Esc>O"
    endif
endfunction

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

" Python indent settings
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix

" Start vim-plug configuration now
call plug#begin("~/.vim/plugged")

" " Color settings
" colorscheme molokai
" set termguicolors
" let g:sublimemonokai_term_italic = 1
Plug 'dracula/vim', { 'as': 'dracula' }

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Nginx
Plug 'chr4/nginx.vim'

" Remove whitespace which at tail
Plug 'bronson/vim-trailing-whitespace'
map <leader><space> :FixWhitespace<cr>

" Commenter Plug
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1 " One space before when comment

" Jinja2
Plug 'glench/vim-jinja2-syntax'

" Md
Plug 'mzlogin/vim-markdown-toc'

" Emmet
Plug 'mattn/emmet-vim'

" Vagrant
Plug 'hashivim/vim-vagrant'

" Yaml
Plug 'chase/vim-ansible-yaml'
let g:ansible_options = {'ignore_blank_lines': 0}
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Icon
Plug 'ryanoasis/vim-devicons'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" Git Config
Plug 'tpope/vim-fugitive'

" COC Plug
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}

" new verion of COC CheckBackspace
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Flake8 vim plugin
Plug 'nvie/vim-flake8'
autocmd FileType python map   :call Flake8()
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:flake8_ignore="E501,W293,E306"
let g:flake8_max_line_length = 99
let g:syntastic_python_flake8_exec = '/usr/local/bin/python3'
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_python_flake8_args = ['-m', 'flake8']
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let python_highlight_all=1

" Nerdtree Settings
Plug 'scrooloose/nerdtree'
:map <F8> <ESC>:NERDTree %<CR>
nnoremap <F10> :exe ‘NERDTreeToggle’<CR>
let NERDTreeShowHidden=1
let NERDTreeDirArrows=0
let NERDTreeMapOpenSplit="s"
let NERDTreeMapOpenVSplit="v"
let NERDTreeWinSize=40
let NERDTreeIgnore = ['\.pyc$', '\.swp$', '\.swo$']

" https://github.com/junegunn/vim-plug/wiki/faq#whats-the-deal-with-git-in-the-url
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

" Automatically open a NERDTree if no files where specified
autocmd vimenter * if !argc() | NERDTree | endif

" Go settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-go Cheet Sheet
" :GoRun :GoBuild :GoInstall
"
" :GoDef          # goto definition of object under cursor
" gd              # also has the same effect
"
" Ctrl-O          # hop back to your source file/return to definition
"
" :GoDoc          # opens up a side window for quick documentationn
" K / Leader + d  # also has the same effect
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Set autoCommand for golang while started
augroup go
autocmd!
" Show by default 4 spaces for a tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
" :GoBuild and :GoTestCompile
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" :GoTest
autocmd FileType go nmap <leader>t <Plug>(go-test)
" :GoRun
autocmd FileType go nmap <leader>r <Plug>(go-run)
" :GoDoc
autocmd FileType go nmap <Leader>d <Plug>(go-doc)
" :GoCoverageToggle
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" :GoInfo
autocmd FileType go nmap <Leader>i <Plug>(go-info)
" :GoMetaLinter
autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
" :GoDef but opens in a vertical split
autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
" :GoDef but opens in a horizontal split
autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
" :GoAlternate  commands :A, :AV, :AS and :AT
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
  endif
endfunction

" Plug for JS
Plug 'marijnh/tern_for_vim'

" Plug for Vue
Plug 'posva/vim-vue'
au BufNewFile,BufRead *.html,*.js,*.vue set tabstop=2
au BufNewFile,BufRead *.html,*.js,*.vue set softtabstop=2
au BufNewFile,BufRead *.html,*.js,*.vue set shiftwidth=2
au BufNewFile,BufRead *.html,*.js,*.vue set expandtab
au BufNewFile,BufRead *.html,*.js,*.vue set autoindent
au BufNewFile,BufRead *.html,*.js,*.vue set fileformat=unix
autocmd FileType vue syntax sync fromstart

" Ctrl + P
Plug 'ctrlpvim/ctrlp.vim'
set runtimepath^=~/.vim/plugged/ctrlp.vim
set wildignore+=*.so,*.swp,*.swo,*.zip,*.jar
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'cra'

" All of your Plugs must be added before the following line
call plug#end()

colorscheme dracula
let g:airline_theme='tomorrow'


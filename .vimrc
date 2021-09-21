" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }

" .vimrc defaults {
set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
" }

" Install Plugins {
    " https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')

    " General {
    
        " Connect to ghost text chrome/ff extension to edit text in nvim
        Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

        " Change surrounding or make surrounds with cs or ys respectively
        Plug 'tpope/vim-surround'

        " Repeats surround.vim with '.' operator 
        Plug 'tpope/vim-repeat'

        " Common pairs of mappings ([b and ]b to move between buffers)
        Plug 'tpope/vim-unimpaired'

        " Swap windows with <leader>ww
        Plug 'wesQ3/vim-windowswap'

        " File explorer
        Plug 'scrooloose/nerdtree'

        " Better :mksession handling (Session.vim managing)
        " Plug 'tpope/vim-obsession'

        " Distraction free writing with :Goyo
        Plug 'junegunn/goyo.vim'

        " In GUI lists all plugin options and shorcuts
        " Plug 'Headlights'
    
        " Lightweight statusline enhancement
        Plug 'vim-airline/vim-airline'

        " Vertical lines to show vertical alignment
        Plug 'Yggdroot/indentLine'

    " }
    
    " Search {
        " Use :Ag as a replacement for grep 
        Plug 'rking/ag.vim'
        " Fuzzy finder intergration
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
    " }

    " Color scheme { 
        " Plug 'tomasr/molokai'
        
        " Color scheme (tailored for neovim)
        " Plug 'freeo/vim-kalisi'
        
        " Color scheme (24 bit for neovim)
        Plug 'morhetz/gruvbox'

        " Highlights characters to jump to in buffer
        " Plug 'Lokaltog/vim-easymotion'
    " }

    " SCM {
        " Mercurial integration
        " Plug 'ludovicchabant/vim-lawrencium'
        " Git integration
        Plug 'tpope/vim-fugitive'
    " }

    " Language {
        " Use gc to toggle areas to comment
        " Plug 'tomtom/tcomment_vim'
        Plug 'tpope/vim-commentary'

        " Use Conqueror of Completion for language server support with MS
        " extensions
        " Plug 'neoclide/coc.nvim', {'branch': 'release'}
        
        " Use builtin language server in neovim with helpful plugin
        Plug 'neovim/nvim-lsp'
        
        "" General language autocompletion
        "Plug 'shougo/deoplete.nvim'
        "" Add syntax files as a deoplete completion source
        "Plug 'shougo/neco-syntax'
        "" Python auto completion
        "" Plug 'davidhalter/jedi'
        "" Python auto completion with deoplete
        "Plug 'zchee/deoplete-jedi'
        "" Use python language server (pyls) instead ? XXX: TODO
        "
        "" Add rust as a deoplete completion source
        "Plug 'racer-rust/vim-racer'

        "" Display function signatures in the command line
        "Plug 'Shougo/echodoc.vim'

        " Use tab for smarter autocompletion
        " Plug 'SuperTab' " Works on windows
        Plug 'ervandew/supertab'
        
        " Write HTML easier <C-e>,
        " Plug 'rstacruz/sparkup', {'rtp': 'vim', 'for': 'html'}
        " Write HTML easier <C-y>,
        Plug 'mattn/emmet-vim'

        " Bioinformatics formats highlighting
        " This forces it's OWN colorscheme (wtf)
        " Plug 'bioSyntax/bioSyntax-vim'
    " }

    call plug#end()
" }

"  Plugin Settings and Bindings {
    " NERDTree {
    " close VIM if NERDTree is the only buffer left
    augroup nerdtree
        autocmd!
        autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    augroup END
    " toggle NERDTree
    nnoremap <silent> <F2> :NERDTreeToggle<CR>
    " }
    " Netrw {
    " let g:netrw_list_cmd=" ssh -q USEPORT HOSTNAME ls -Fa"
        let g:netrw_altv=1 " split right instead of left
    " }
    " Airline {
        " let g:airline#extensions#branch#enabled = 1
        " let g:airline#extensions#syntastic#enabled = 1
        " let g:airline#extensions#ycm#enabled = 1
        " let g:airline#extensions#ale#enabled = 1
        " TODO: Fix this to append only the cwd?
        " let g:airline_section_b = '%{getcwd()}'
    " }
    " FZF {
        " Redefine the Find command to use rg and options
        if executable('rg')
            command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
        endif
    " }
    " Conqueror of Code (Language Client) {
        "" A lot of these are recommendations for defaults / quick start
        "" Command line height - used to skip a lot of 'hit enter to continue'
        "set cmdheight=2

        "" Time to trigger CursorHold event (and save swap file)
        "set updatetime=300

        "" don't give |ins-completion-menu| messages.
        "set shortmess+=c

        "" always show signcolumns
        "set signcolumn=yes

        "" TODO: https://github.com/neoclide/coc.nvim
        "function! s:check_back_space() abort
        "let col = col('.') - 1
        "return !col || getline('.')[col - 1]  =~ '\s'
        "endfunction

        "" Map Tab to trigger autocompletion and cycle through options
        "inoremap <silent><expr> <TAB>
        "    \ pumvisible() ? "\<C-n>" :
        "    \ <SID>check_back_space() ? "\<TAB>" :
        "    \ coc#refresh()

        "" Confirm completion and format
        "inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
        "            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        "" Use `[g` and `]g` to navigate diagnostics
        "nmap <silent> [g <Plug>(coc-diagnostic-prev)
        "nmap <silent> ]g <Plug>(coc-diagnostic-next)
        
        "" Remap keys for gotos
        "nmap <silent> gd <Plug>(coc-definition)
        "nmap <silent> gy <Plug>(coc-type-definition)
        "nmap <silent> gi <Plug>(coc-implementation)
        "nmap <silent> gr <Plug>(coc-references)
        
        "" Use K to show documentation in preview window
        "nnoremap <silent> K :call <SID>show_documentation()<CR>
        
        "function! s:show_documentation()
        "  if (index(['vim','help'], &filetype) >= 0)
        "      execute 'h '.expand('<cword>')
        "   else
        "       call CocAction('doHover')
        "   endif
        "endfunction
        
        "" Highlight symbol under cursor on CursorHold
        "" autocmd CursorHold * silent call CocActionAsync('highlight')
        
        ""Remap for rename current word
        "nmap <leader>rn <Plug>(coc-rename)
        
        "" Remap for format selected region
        "xmap <leader>f  <Plug>(coc-format-selected)
        "nmap <leader>f  <Plug>(coc-format-selected)

        "" Create mappings for function text object, requires document symbols
        "" feature of languageserver.
        "xmap if <Plug>(coc-funcobj-i)
        "xmap af <Plug>(coc-funcobj-a)
        "omap if <Plug>(coc-funcobj-i)
        "omap af <Plug>(coc-funcobj-a)
        
        "" Use <C-d> for select selections ranges, needs server support, like:
        "" coc-tsserver, coc-python
        "nmap <silent> <C-d> <Plug>(coc-range-select)
        "xmap <silent> <C-d> <Plug>(coc-range-select)
    " }
    " Language Client {
        " let g:LanguageClient_serverCommands = {
        "     \ 'rust': ['rls'],
        "     \ 'python': ['pyls'],
        "     \ }
        " nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
        " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
        " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
        " nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
        " nnoremap <silent> <F3> :call LanguageClient_textDocument_references()<CR>
        " nnoremap <silent> gq :call LanguageClient_textDocument_formatting()<CR>
        " " set formatexpr=LanguageClient_textDocument_rangeFormatting()
    " }
    " Neovim LSP Plugin Settings {
lua << EOF
local nvim_lsp = require 'nvim_lsp'
nvim_lsp.rls.setup{}
nvim_lsp.pyls.setup{}
EOF

        " Not part of the plugin but from neovim itself
        nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
        " nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
        nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
        nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

        " Use LSP omni-completion in Python files.
        autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
        " Use LSP omni-completion in Rust files.
        autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
    " }
    " SuperTab {
    let g:SuperTabDefaultCompletionType = "context"
    " }
" }

" Map leader {
let mapleader = ","
" }

" Quick .vimrc updating {
    " Source the vimrc file after saving it
    if has("autocmd")
        " Prevent repeating autocommands
        augroup vimrc
            " Clear group before a re-source
            autocmd!
            exec "autocmd bufwritepost " . expand("<sfile>:t") . " source $MYVIMRC"
        augroup END
    endif

    " Map opening the .vimrc
    exec "nnoremap <leader>` :e " . expand("<sfile>:p") . "<CR>"
" }

" Vim UI {
    " This might overwrite valuable GUI settings
    " set t_Co=256                    " Set terminal colors to 256
    " let &t_ZH="\e[3m"
    " let &t_ZR="\e[23m"
    " set t_ZH=[3m
    " set t_ZR=[23m
    if &term =~ 'tmux'              " Tmux specific settings
        set ttymouse=xterm2
        set ttyfast
    endif
    "color molokai                  " load a colorscheme
    let g:gruvbox_italic=1          " if you're using urxvt or gnome-terminal you should try setting let g:gruvbox_italic=1 before colorscheme gruvbox to enforce displaying italics
    let g:gruvbox_contrast_dark="hard"
    color gruvbox                   " load a colorscheme

    set background=dark

    "set guifont=ProFontWindows:h9:cANSI
    set guifont=Source\ Code\ Pro\ Medium\ 10
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    " set cursorline                  " highlight current line

    hi CursorLine guibg=#ffffff     " highlight bg color of current line
    hi CursorColumn guibg=#333333   " highlight cursor
    hi TermCursor ctermfg=red       " TODO: Fixthis

    " Airline takes care of these settings
    " if has('cmdline_info')
    "     set ruler                   " show the ruler
    "     set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    "     set showcmd                 " show partial commands in status line and
    "                                 " selected characters/lines in visual mode
    " endif

    " This is not used if airline is installed
    "if has('statusline')
    "    set laststatus=2             " always show status line (this is default)
    "    " Use the commented line if fugitive isn't installed
    "    set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
    "    "set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
    "endif
    
    " Remove current mode display - should be shown in the status line anyway
    " (e.g. airline)
    set noshowmode
    
    " Remove GUI menus
    set guioptions-=T               " Remove Toolbar
    "set guioptions-=m              " Remove Menu
    set guioptions-=r               " Remove right hand scrollbar
    set guioptions-=R               " Remove right hand scrollbar
    set guioptions-=l               " Remove left hand scrollbar
    set guioptions-=L               " Remove left hand scrollbar when vertically split

    set backspace=indent,eol,start  " backspace for dummys
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set relativenumber              " Relative numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high 
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    "set whichwrap=b,s,h,l,<,>,[,]  " backspace and cursor keys wrap to
    set whichwrap=b,s,<,>,[,]       " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    "set gdefault                   " the /g flag on :s substitutions by default
    
" }

" General {
    filetype plugin indent on       " Automatically detect file types.
    syntax on                       " syntax highlighting
    set mouse=a                     " automatically enable mouse usage
    scriptencoding utf-8
    " set autowrite
    set autoread                    " Automatically read modified files outside of vim
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')

    " Views {
        " XXX: Typically, having 'options' set in viewoptions is a bad thing
        "set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
        " Redundant if views are not used (commented out below)
        " XXX: It seems no matter what, the 'lcd' setting is saved regardless
        " what option is set for views
        set viewoptions=folds,cursor,unix,slash " better unix / windows compatibility
        au BufWinLeave * silent! mkview   " make vim save view (state) (folds, cursor, etc)
        au BufWinEnter * silent! loadview " make vim load view (state) (folds, cursor, etc)
    " }

    " set virtualedit=onemore            " allow for cursor beyond last character
    set history=1000                     " Store a ton of history (default is 20)
    set hidden                           " buffers become hidden when navigating away and won't complain about modifications
    if executable('rg')
        set grepprg=rg\ --vimgrep        " set the grep program to use ripgrep instead
    endif
    
    " Setting up the directories {
        set backup                         " backups are nice ...
        " Moved to function at bottom of the file
        set backupdir=$HOME/vim/backup  " but not when they clog .
        set directory=$HOME/vim/swap    " Same for swap files
        set viewdir=$HOME/vim/views     " same but for view files
        
        "" Creating directories if they don't exist
        "silent execute '!mkdir -p $HOME/vim/backup'
        "silent execute '!mkdir -p $HOME/vim/swap'
        "silent execute '!mkdir -p $HOME/vim/views'
    " }
" }

" Formatting {
    set nowrap                         " do not wrap long lines
    set autoindent                     " indent at the same level of the previous line
    set shiftwidth=4                   " use indents of 4 spaces (used for >>, <<, autoindent, etc)
    set shiftround                     " always round to next shiftwidth when using >>, tab, etc
    set expandtab                      " Tabs are spaces
    set smarttab                       " Tabs are tabs after a leading tab
    set tabstop=4                      " an indentation every four columns (# of spaces counted for tab)
    set textwidth=79                   " Auto wrap when inserting after 80 columns (self-imposed)
    " set matchpairs+=<:>                " match, to be used with % 
    " set pastetoggle=<F12>              " pastetoggle (sane indentation on pastes), unnecessary in modern terminal emulators
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" }

" Key Mappings {

    " Easier moving in tabs and windows
    nnoremap <C-J> <C-W>j<C-W>_
    nnoremap <C-K> <C-W>k<C-W>_
    nnoremap <C-L> <C-W>l<C-W>_
    nnoremap <C-H> <C-W>h<C-W>_
    nnoremap <C-K> <C-W>k<C-W>_
    nnoremap <S-H> gT
    nnoremap <S-L> gt

    nnoremap <C-W>D :silent! exe "confirm bdelete"<cr>
    " nnoremap <leader>t :silent! exe "e " . tempname()<cr>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Shortcuts

    " Opening files and directories from current path
    nnoremap <leader>e :e <C-R>=expand("%:p:h")."/"<cr>
    nnoremap <leader>cd :cd <C-R>=expand("%:p:h")."/"<cr>

    " Center on next function after switching
    nnoremap ]] ]]zz
    nnoremap [[ [[zz

    " Keep cursor on '*'ed item
    nnoremap * *Nzz
    nnoremap # #Nzz

    " Remove highlighting with a backspace
    " nmap <BS> :nohl<CR> "use =oh from unimpaired instead

    " Diff between veritcally split windows
    nnoremap <leader>d :let @q = expand('%:p')<cr><C-w>c<C-w>p:vert diffsplit <C-r>q<cr>
    nnoremap <leader>D :diffoff!<cr>

    " Maximize current working window
    nnoremap <leader>m <C-w>_<C-w>\|

    " Search for selected word (default recursive in rg/ag)
    " Add shellescaping and word boundaries (like '*' but across files)
    " nnoremap <leader>g :silent execute "grep! " . shellescape('\b' . expand("<cWORD>") . '\b')<cr>:copen<cr>
    nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
    vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

    function! s:GrepOperator(type)
        let saved_unnamed_register = @@

        if a:type ==# 'v'
            normal! `<v`>y
        elseif a:type ==# 'char'
            normal! `[y`]
        else
            return
        endif

        silent execute "grep! " . shellescape('\b' . @@ . '\b')
        copen

        let @@ = saved_unnamed_register
    endfunction

    " Open temporary file
    function! s:OpenTemporaryBuffer()
        " prepending silent messes this up?
        execute "edit " . tempname()
        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal noswapfile
    endfunction
    nnoremap <leader>t :<c-u>call <SID>OpenTemporaryBuffer()<cr>
    " nnoremap <leader>t :silent! exe "e " . tempname()<cr>
" }

" Hex Editing {
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" }

" Neovim specific settings {
    if has("nvim")
        " TODO: Fix this
        augroup neovimrc
            " Remove all neovimrc autocmds (useful when resourcing)
            autocmd!
            " Remove line numbers from terminal buffers
            autocmd TermOpen * setlocal nonumber
            autocmd TermOpen * setlocal norelativenumber

            autocmd BufLeave * if &buftype ==# 'terminal' | checktime | endif
            
        augroup END
        
        set termguicolors
        set inccommand=nosplit

        if has("win32")
            set shell=powershell.exe
        endif
    endif 
" }

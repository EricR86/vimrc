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
    
        " Language server protocol framework support
        " Currently bugged
        " Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

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
        Plug 'ludovicchabant/vim-lawrencium'
        " Git integration
        Plug 'tpope/vim-fugitive'
    " }

    " Language {
        " Syntax checker plugin
        " Plug 'scrooloose/syntastic'

        " Asyncrhonous lint checking
        Plug 'w0rp/ale'

        " Use gc to toggle areas to comment
        " Plug 'tomtom/tcomment_vim'
        Plug 'tpope/vim-commentary'

        " Syntax and filetype plugins for most languages
        Plug 'sheerun/vim-polyglot'

        " General language autocompletion
        " Plug 'roxma/nvim-completion-manager'
        Plug 'shougo/deoplete.nvim'
        " Add syntax files as a deoplete completion source
        Plug 'shougo/neco-syntax'
        " Python auto completion
        Plug 'davidhalter/jedi'
        " Python auto completion with deoplete
        Plug 'zchee/deoplete-jedi'
        " Use python language server (pyls) instead ? NB: bugged right now

        " Display function signatures in the command line
        Plug 'Shougo/echodoc.vim'
        
        " Use tab for smarter autocompletion
        " Plug 'SuperTab' " Works on windows
        
        " Write HTML easier <C-e>,
        " Plug 'rstacruz/sparkup', {'rtp': 'vim', 'for': 'html'}
        " Write HTML easier <C-y>,
        Plug 'mattn/emmet-vim'
    " }

    call plug#end()
" }

" Plugin Settings and Bindings {
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
        let g:airline#extensions#branch#enabled = 1
        " let g:airline#extensions#syntastic#enabled = 1
        " let g:airline#extensions#ycm#enabled = 1
        let g:airline#extensions#ale#enabled = 1
        " TODO: Fix this to append only the cwd?
        let g:airline_section_b = '%{getcwd()}'
    " }
    " FZF {
        " Redefine the Find command to use rg and options
        if executable('rg')
            command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
        endif
    " }
    " Language Client {
        " let g:LanguageClient_autoStart = 1

        " let g:LanguageClient_serverCommands = {
        "     \ 'python': ['pyls'],
        "     \ }

        " Pause 2 seconds between textDocument_didChange events
        " let g:LanguageClient_changeThrottle = 2
        " let g:LanguageClient_diagnosticsList = "quickfix"
        " let g:LanguageClient_diagnosticsEnable = 1
        

        " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
        " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
        " nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
        " nnoremap <silent> <F3> :call LanguageClient_textDocument_references()<CR>
        " nnoremap <silent> gq :call LanguageClient_textDocument_formatting()<CR>
        " " set formatexpr=LanguageClient_textDocument_rangeFormatting()
    " }
    " Polyglot {
        let g:polyglot_disabled = ['python']
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

    " Stupid shift key fixes
    "cmap W w
    "cmap WQ wq
    "cmap wQ wq
    "cmap Q q
    "cmap Tabe tabE

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

    "Map for quick replacement
    " nmap ;; :%s//g<left><left>
    " nmap ;' :%s//gc<left><left><left>
    " vmap ;; :s//g<left><left>
    " vmap ;' :s//gc<left><left><left>

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
        " Use deoplete.
        let g:deoplete#enable_at_startup = 1
        " Use deoplete smartcase.
        let g:deoplete#enable_smart_case = 1
        " deoplete <BS>: close popup and delete backword char.
        inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

        " TODO: Fix this
        augroup neovimrc
            " Remove all neovimrc autocmds (useful when resourcing)
            autocmd!
            " Remove line numbers from terminal buffers
            autocmd TermOpen * setlocal nonumber
            autocmd TermOpen * setlocal norelativenumber

            " When leaving the terminal
            " autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
    "       \ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
    "       \ |let g:f=fnameescape(expand('%:p'))
    "       \ |noau bwipe
    "       \ |call rpcrequest(g:r, "nvim_command", "tabedit ".g:f)|qa|endif

            " function! s:SendCheckTimeToParent()
            "     " Use on BufLeave
            "     if !empty($NVIM_LISTEN_ADDRESS) && (&buftype ==# "terminal")
            "         let rpcsocket = sockconnect('pipe', $NVIM_LISTEN_ADDRESS, {'rpc':v:true})
            "         call rpcrequest(rpcsocket, 'nvim_command', 'checktime')
            "         call chanclose(rpcsocket, 'rpc')
            "     endif
            " endfunction

            " autocmd BufLeave * call <SID>SendCheckTimeToParent()
            autocmd BufLeave * if &buftype ==# 'terminal' | checktime | endif
            
        augroup END
        
        set termguicolors
        " set guicursor=a
        " set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
        "   \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
        "   \,sm:block-blinkwait175-blinkoff150-blinkon175
        " set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
        " au VimLeave * set guicursor=a:block-blinkon0
        set inccommand=nosplit

        if has("win32")
            set shell=powershell.exe
        endif
    endif 
" }

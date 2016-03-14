" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }

" .vimrc defaults {
set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" set diffexpr=MyDiff()
" function MyDiff()
"   let opt = '-a --binary '
"   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"   let arg1 = v:fname_in
"   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"   let arg2 = v:fname_new
"   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"   let arg3 = v:fname_out
"   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"   let eq = ''
"   if $VIMRUNTIME =~ ' '
"     if &sh =~ '\<cmd'
"       let cmd = '""' . $VIMRUNTIME . '\diff"'
"       let eq = '"'
"     else
"       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"     endif
"   else
"     let cmd = $VIMRUNTIME . '\diff'
"   endif
"   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
" endfunction
" }

" Install Plugins {
    " https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')

    " In GUI lists all plugin options and shorcuts
    "Plug 'Headlights'

    " Color scheme
    " Plug 'tomasr/molokai'
    
    " Color scheme (tailored for neovim)
    Plug 'freeo/vim-kalisi'

    " Another colorscheme
    " Plug 'altercation/vim-colors-solarized'
    
    " Syntax file for JQuery
    "Plug 'jQuery', {'for': 'js'}
    
    " Visualize undo tree for vim
    "Plug 'Gundo'
    
    " Change surrounding or make surrounds with cs or ys respectively
    Plug 'tpope/vim-surround'

    " Repeats surround.vim with '.' operator 
    Plug 'tpope/vim-repeat'

    " Highlights characters to jump to in buffer
    "Plug 'Lokaltog/vim-easymotion'

    " Statusline enhancement plugin
    " Plug 'powerline/powerline' "deprecated (and was never used)
    
    " Lightweight statusline enhancement
    Plug 'vim-airline/vim-airline'

    " Syntax checker plugin
    Plug 'scrooloose/syntastic'

    " Use gc to toggle areas to comment
    Plug 'tComment'

    " Smarter autocompletion for multiple languages
    " Requires clang installed and --clang-completer in install options
    " For various c style languages (including python)
    " Enable for all languages? Remove 'for' ? Slows start up
    Plug 'Valloric/YouCompleteMe', { 'do': './install.sh', 'for': ['python', 'c', 'cpp'] }
    autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif

    " Use tab for smarter autocompletion
    " Plug 'SuperTab' " Works on windows
    " Write HTML easier <C-e>,
    Plug 'rstacruz/sparkup', {'rtp': 'vim', 'for': 'html'}

    " Filetype support for cofeescript
    "Plug 'kchmck/vim-coffee-script', {'for': 'coffeescript'}

    " Filetype support for LESS
    "Plug 'groenewege/vim-less'

    " Better filetype support for JSON
    Plug 'elzr/vim-json', {'for': ['json', 'js']}

    " Ruby on rails VIM support
    "Plug 'tpope/vim-rails', {'for': 'ruby'}

    " Filetype support for Elixir
    Plug 'elixir-lang/vim-elixir'

    " Better :mksession handling (Session.vim managing)
    Plug 'tpope/vim-obsession'

    " Use :Ag as a replacement for grep 
    Plug 'rking/ag.vim'

    " Racket syntax and file type plugin
    Plug 'wlangstroth/vim-racket'

    " File explorer
    Plug 'scrooloose/nerdtree'

    " Search and display stuff from arbitrary sources
    " Plug Shougo/unite.vim
    
    " Self made firefox autorefresher
    "Plug 'EricR86/vim-firefox-autorefresh'
    
    if has("nvim")
        " Elixir neovim plugin bindings and elixir autocompletion
        Plug 'thinca/vim-ref'
        Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
    endif

    call plug#end()
" }

" Plugin Settings and Bindings {
    " Gundo {
    nnoremap <F5> :GundoToggle<CR>
    " }
    " Less-vim {
    nnoremap <leader>l :w <BAR> !lessc % > %:t:r.css<CR><space>
    "}
    " NERDTree {
    " close VIM if NERDTree is the only buffer left
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    " toggle NERDTree
    nnoremap <silent> <F2> :NERDTreeToggle<CR>
    " }
    " Netrw {
	" let g:netrw_list_cmd=" ssh -q USEPORT HOSTNAME ls -Fa"
        let g:netrw_altv=1 " split right instead of left
    " }
    " YouCompleteMe {
        let g:ycm_python_binary_path = '/scratch/arch/Linux-x86_64/opt/python-2.7.11/bin/python'
    " }
    " Syntastic {
        " These options don't work because of the earlier statusline settings
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_check_on_open = 1
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 2
        let g:syntastic_loc_list_height = 5 "doesn't seem to work
        let g:syntastic_check_on_wq = 0
    " }
" }

" Map leader {
let mapleader = ","
" }

" Quick .vimrc updating {
    " Source the vimrc file after saving it
    if has("autocmd")
      exec "autocmd bufwritepost " . expand("<sfile>:t") . " source $MYVIMRC"
    endif

    " Map opening the .vimrc
    exec "nmap <leader>` :e " . expand("<sfile>:p") . "<CR>"
" }

" Vim UI {
    set background=dark
    set t_Co=256                    " Set terminal colors to 256
    if &term =~ 'tmux'              " Tmux specific settings
        set ttymouse=xterm2
        set ttyfast
    endif
	"color molokai     	       		" load a colorscheme
	color kalisi     	       		" load a colorscheme
    "set guifont=ProFontWindows:h9:cANSI
    set guifont=Source\ Code\ Pro\ Medium\ 10
	set tabpagemax=15 				" only show 15 tabs
	set showmode                   	" display the current mode

	set cursorline  				" highlight current line
	hi CursorLine guibg=#ffffff 	" highlight bg color of current line
	hi CursorColumn guibg=#333333   " highlight cursor
    hi TermCursor ctermfg=red       " TODO: Fixthis

	if has('cmdline_info')
		set ruler                  	" show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
		set showcmd                	" show partial commands in status line and
									" selected characters/lines in visual mode
	endif

    " This is not used if airline is installed
	if has('statusline')
		set laststatus=2           	" always show status line (this is default)
		" Use the commented line if fugitive isn't installed
		set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
		"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
	endif

    " Remove GUI menus
    set guioptions-=T               " Remove Toolbar
    "set guioptions-=m               " Remove Menu
    set guioptions-=r               " Remove right hand scrollbar
    set guioptions-=R               " Remove right hand scrollbar
    set guioptions-=l               " Remove left hand scrollbar
    set guioptions-=L               " Remove left hand scrollbar when vertically split

	set backspace=indent,eol,start 	" backspace for dummys
	set linespace=0 				" No extra spaces between rows
	set nu 							" Line numbers on
	set showmatch                  	" show matching brackets/parenthesis
	set incsearch 					" find as you type search
	set hlsearch 					" highlight search terms
	set winminheight=0 				" windows can be 0 line high 
	set ignorecase 					" case insensitive search
	set smartcase 					" case sensitive when uc present
	set wildmenu 					" show list instead of just completing
	set wildmode=list:longest,full 	" command <Tab> completion, list matches, then longest common part, then all.
	"set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	set whichwrap=b,s,<,>,[,]	" backspace and cursor keys wrap to
	set scrolljump=5 				" lines to scroll when cursor leaves screen
	set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldenable  				" auto fold code
	"set gdefault					" the /g flag on :s substitutions by default
    
    " Nvim specific settings
    "if has('nvim')
    "endif 
" }

" General {
	filetype plugin indent on  	" Automatically detect file types.
	syntax on 					" syntax highlighting
	set mouse=a					" automatically enable mouse usage
	"set autochdir 				" always switch to the current file directory.. 
	" not every vim is compiled with this, use the following line instead
     "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
	scriptencoding utf-8
	" set autowrite
    set autoread                " Automatically read modified files outside of vim
	set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
	"set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	set viewoptions=folds,cursor,unix,slash " better unix / windows compatibility
	set virtualedit=onemore 	   	" allow for cursor beyond last character
	set history=1000  				" Store a ton of history (default is 20)
	" set spell 		 	     	" spell checking on
	
	" Setting up the directories {
		set backup 						" backups are nice ...
        " Moved to function at bottom of the file
		set backupdir=$HOME/vim/backup  " but not when they clog .
		set directory=$HOME/vim/swap	" Same for swap files
		set viewdir=$HOME/vim/views 	" same but for view files
		
		"" Creating directories if they don't exist
		"silent execute '!mkdir -p $HOME/vim/backup'
		"silent execute '!mkdir -p $HOME/vim/swap'
		"silent execute '!mkdir -p $HOME/vim/views'
		au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
		au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
	" }
" }

" Formatting {
	set nowrap                     	" do not wrap long lines
	set autoindent                 	" indent at the same level of the previous line
	set shiftwidth=4               	" use indents of 4 spaces
	set expandtab 	       		    " Tabs are spaces
    set smarttab                    " Tabs are tabs after a leading tab
	set tabstop=4 					" an indentation every four columns
    set textwidth=79                "Auto wrap when inserting after 80 columns (self-imposed)
	"set matchpairs+=<:>            	" match, to be used with % 
	set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" }

" Key Mappings {

	" Easier moving in tabs and windows
	map <C-J> <C-W>j<C-W>_
	map <C-K> <C-W>k<C-W>_
	map <C-L> <C-W>l<C-W>_
	map <C-H> <C-W>h<C-W>_
	map <C-K> <C-W>k<C-W>_
	map <S-H> gT
	map <S-L> gt

	" Stupid shift key fixes
	"cmap W w
	"cmap WQ wq
	"cmap wQ wq
	"cmap Q q
	"cmap Tabe tabE

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	" Shortcuts
	" Change Working Directory to that of the current file
    cmap cwd lcd %:p:h

    " Opening files and directories from current path
    cmap %/ <C-R>=expand("%:p:h")."/"<cr>
    map <leader>e :e %/
    map <leader>cd :cd %/

    " Center on next function after switching
    map ]] ]]zz
    map [[ [[zz

    " Keep cursor on '*'ed item
    map * *Nzz
    map # #Nzz

    " Remove highlighting with a backspace
    nmap <BS> :nohl<CR>

    " Diff between veritcally split windows
    nmap <leader>d :let @q = expand('%:p')<cr><C-w>c<C-w>p:vert diffsplit <C-r>q<cr>
    nmap <leader>D :diffoff!<cr>

    " Maximize current working window
    map <leader>m <C-w>_<C-w>\|

    "Map for quick replacement
    nmap ;; :%s//g<left><left>
    nmap ;' :%s//gc<left><left><left>
    vmap ;; :s//g<left><left>
    vmap ;' :s//gc<left><left><left>

    " Open temporary file
    map <leader>t :exe "e " . tempname()<cr>
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

" Language specific settings {
" Ruby {
autocmd FileType ruby set tabstop=2|set shiftwidth=2
" }
" }

" Neovim specific settings {
    if has("nvim")
        " Enable true colors if terminal supports it
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        " Point neovim to a specific python interpreter
        let g:python_host_prog = '/scratch/arch/Linux-x86_64/opt/python-2.7.11/bin/python'
    endif 
" }

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
    " For self made scripts check out ~/vimfiles/
    filetype off "required!
    set rtp+=~/.vim/bundle/vundle/ "places all auto-downloaded plugins/scripts in here
    call vundle#rc()

    " let Vundle manage Vundle
    " required! 
    Bundle 'gmarik/vundle'
    Bundle 'Headlights'
    Bundle 'molokai'
    Bundle 'jQuery'
    Bundle 'Gundo'
    Bundle 'repeat.vim'
    Bundle 'surround.vim'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'tComment'
    Bundle 'SuperTab'
    Bundle 'rstacruz/sparkup', {'rtp': 'vim'}
    Bundle 'EricR86/vim-firefox-autorefresh'
" }

" Plugin Settings and Bindings {
    " Gundo {
    nnoremap <F5> :GundoToggle<CR>
    " }
" }

" Map leader {
let mapleader = ","
" }

" Quick .vimrc updating {
    " Source the vimrc file after saving it
    if has("autocmd")
      autocmd bufwritepost _vimrc source $MYVIMRC
    endif

    " Map opening the .vimrc
    nmap <leader>` :e $MYVIMRC<CR>
" }

" Vim UI {
    set background=dark
	color molokai     	       		" load a colorscheme
    set guifont=ProFontWindows:h9:cANSI
	set tabpagemax=15 				" only show 15 tabs
	set showmode                   	" display the current mode

	set cursorline  				" highlight current line
	hi CursorLine guibg=#ffffff 	" highlight bg color of current line
	hi CursorColumn guibg=#333333   " highlight cursor

	if has('cmdline_info')
		set ruler                  	" show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
		set showcmd                	" show partial commands in status line and
									" selected characters/lines in visual mode
	endif

	if has('statusline')
		set laststatus=1           	" show statusline only if there are > 1 windows
		" Use the commented line if fugitive isn't installed
		set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
		"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
	endif

    " Remove GUI menus
    set guioptions-=T               " Remove Toolbar
    "set guioptions-=m               " Remove Menu
    set guioptions-=r               " Remove right hand scrollbar

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
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	set scrolljump=5 				" lines to scroll when cursor leaves screen
	set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldenable  				" auto fold code
	"set gdefault					" the /g flag on :s substitutions by default

" }

" General {
	filetype plugin indent on  	" Automatically detect file types.
	syntax on 					" syntax highlighting
	set mouse=a					" automatically enable mouse usage
	"set autochdir 				" always switch to the current file directory.. 
	" not every vim is compiled with this, use the following line instead
     "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
	scriptencoding utf-8
	set autowrite
	set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
	"set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	set viewoptions=folds,cursor,unix,slash " better unix / windows compatibility
	set virtualedit=onemore 	   	" allow for cursor beyond last character
	set history=1000  				" Store a ton of history (default is 20)
	" set spell 		 	     	" spell checking on
	
	" Setting up the directories {
		set backup 						" backups are nice ...
        " Moved to function at bottom of the file
		set backupdir=$HOME\vim\backup  " but not when they clog .
		set directory=$HOME\vim\swap	" Same for swap files
		set viewdir=$HOME\vim\views 	" same but for view files
		
		"" Creating directories if they don't exist
		"silent execute '!mkdir -p $HOME\vim\backup'
		"silent execute '!mkdir -p $HOME\vim\swap'
		"silent execute '!mkdir -p $HOME\vim\views'
		au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
		au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
	" }
" }

" Formatting {
	set nowrap                     	" wrap long lines
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

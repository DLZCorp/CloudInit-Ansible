" ########################
" ##                    ##
" ##  VUNDLE BOOTSTRAP  ##
" ##                    ##
" ########################
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
filetype off                  " required
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"Add your bundles here
Plugin 'https://github.com/vim-airline/vim-airline'
Plugin 'https://github.com/powerline/fonts'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'https://github.com/vim-syntastic/syntastic' "uber awesome syntax and errors highlighter
Plugin 'https://github.com/altercation/vim-colors-solarized' "T-H-E colorscheme
Plugin 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal
Plugin 'morhetz/gruvbox'
"...All your other bundles...
if iCanHazVundle == 0
    echo "Installing Vundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

call vundle#end()

" ############################
" ##                        ##
" ##  END VUNDLE BOOTSTRAP  ##
" ##                        ##
" ############################


"filetype plugin indent on " load filetype plugins/indent settings

let g:solarized_termcolors=256
autocmd vimenter * ++nested colorscheme gruvbox
colorscheme gruvbox
set background=dark
syntax on

filetype plugin on

" ###################
" ##               ##
" ##  VIM-AIRLINE  ##
" ##               ##
" ###################

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
set laststatus=2
set guifont=Liberation\ Mono\ Powerline\ 10
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.paste = 'ρ'
" end of vim-airline settings

" ################
" ##            ##
" ##  NERDTREE  ##
" ##            ##
" ################

" NT Hotkey
map <C-n> :NERDTreeToggle<CR>

" Open NT automatically if no file/dir was specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NT automatically if opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close vim if NT is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ########################
" ##                    ##
" ##   GENERAL CONFIG   ##
" ##  NON-PLUGIN STUFF  ##
" ##                    ##
" ########################

" Indent settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Automatically remove trailing whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e

" Place cursor AFTER the last character when pressing END in normal mode
set virtualedit=onemore

autocmd FileType ps1 :setlocal expandtab! " Use hard tabs for powershell scripts

" Everything else
set ai
set cursorline
set hlsearch
set incsearch
set showmatch
set encoding=utf-8
set t_Co=256
set belloff=all
syntax on

" reindent file via F7
map <F7> gg=G<C-o><C-o>

" easier split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Open NERDTree
map <C-n> :NERDTreeToggle<CR>

" Toggle paste mode
set pastetoggle=<F2>

" Display or remove unwanted whitespace with a script
" Source: http://vim.wikia.com/wiki/Remove_unwanted_spaces
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fix keypappings if running vim through tmux
if &term =~ '^screen'
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
  execute "set <xHome>=\e[1;*H"
  execute "set <xEnd>=\e[1;*F"
  execute "set <PageUp>=\e[5;*~"
  execute "set <PageDown>=\e[6;*~"
  execute "set <F1>=\eOP"
  execute "set <F2>=\eOQ"
  execute "set <F3>=\eOR"
  execute "set <F4>=\eOS"
  execute "set <xF1>=\eO1;*P"
  execute "set <xF2>=\eO1;*Q"
  execute "set <xF3>=\eO1;*R"
  execute "set <xF4>=\eO1;*S"
  execute "set <F5>=\e[15;*~"
  execute "set <F6>=\e[17;*~"
  execute "set <F7>=\e[18;*~"
  execute "set <F8>=\e[19;*~"
  execute "set <F9>=\e[20;*~"
  execute "set <F10>=\e[21;*~"
  execute "set <F11>=\e[23;*~"
  execute "set <F12>=\e[24;*~"
endif

" Because Vim doesn't like
" pasting that works.

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

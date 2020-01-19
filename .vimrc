let mapleader = ","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'vimlab/split-term.vim'
Plug 'tpope/vim-fugitive' 
Plug 'machakann/vim-highlightedyank'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-rooter'
Plug 'mg979/vim-visual-multi'
Plug 'liuchengxu/vista.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'kovetskiy/sxhkd-vim'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'
Plug 'justinmk/vim-sneak'
Plug 'sevko/vim-nand2tetris-syntax'
" Plug 'jeaye/color_coded'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'sheerun/vim-polyglot'
" Plug 'arakashic/chromatica.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

set tabstop=4
set shiftwidth=4
set expandtab
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
" Quick-save
nmap <leader>w :w<CR>
"" Colors
let base16colorspace=256  " Access colors present in 256 colorspace
" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
set background=dark
colorscheme base16-gruvbox-dark-hard
" colorscheme codedark
" let g:airline_theme = 'base16-gruvbox-dark-hard'
let base16colorspace=256
hi Normal ctermbg=NONE
" Get syntax
" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
    " let g:chromatica#enable_at_startup=1
    " colorscheme nord
	set encoding=utf-8
	set number relativenumber
    " Permanent undo
    set undodir=~/.vimdid
    set undofile
" Jump to start and end of line using the home row keys
map H ^
map L $
" Move by line
nnoremap j gj
nnoremap k gk
" terminal emu settings
let g:neoterm_default_mod='belowright' " open terminal in bottom split
let g:neoterm_size=16 " terminal split size
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" " sneak
let g:sneak#s_next = 1
" auto pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsMultilineClose = 0
" fzf"
nnoremap <C-p> :FZF<cr>
nmap <Leader>/ :BLines<cr>
nmap <leader>; :Buffers<CR>
" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
let g:vista_fzf_preview = ['right:50%']

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

"fzd search commands"
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>r :Rg<Space>

" Coc Vim
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ ]
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

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

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
nmap cg  <Plug>(coc-rename)
"
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
"**************************************************

" Nerd Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" Vista
nmap <F8> :Vista<CR>

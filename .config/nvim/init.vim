syntax on
"set number "Show current line number
set relativenumber "Show relative line numbers
set cursorline
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent


" Fold
set foldmethod=syntax
set foldlevel=1
set foldnestmax=1
set encoding=utf8

" Search
set hlsearch
nnoremap i :nohls<CR>i

" Plugin
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Better file browser
Plug 'preservim/nerdtree'

" Code commenter
Plug 'preservim/nerdcommenter'

" For Latex
Plug 'lervag/vimtex'

" For Julia 
Plug 'JuliaEditorSupport/julia-vim'

"A command-line fuzzy finder 
Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf.vim'

" Snippets
Plug 'honza/vim-snippets'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme
Plug 'cocopon/iceberg.vim'
Plug 'kevinhwang91/nvim-bqf' 
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'ynkdir/vim-diff'
Plug 'voldikss/vim-floaterm'
call plug#end()

"Color scheme
colorscheme iceberg
"colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_light = 'hard'
let g:airline_theme='papercolor'

" Setting for neovide
let g:neovide_scale_factor = 0.5

"Open NERDTree
:nnoremap <silent> <expr> <F2> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

"Coc.nvim
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>"
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_next = '<tab>'
nnoremap <leader>e :CocCommand snippets.editSnippets<CR>

" Comments
let mapleader = ","

" remap save
nnoremap <space> :w<CR>

" moving between windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-Left> <C-W>h
nnoremap <C-Down> <C-W>j
nnoremap <C-Up> <C-W>k
nnoremap <C-Right> <C-W>l
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>o :only<CR>
nnoremap <tab> :tabn<CR>
nnoremap <S-tab> :tabp<CR>
nnoremap <BS> <C-O>

"set clipboard+=unnamedplus
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P


" FZF key mapping
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>r :Rg<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>g :GFiles<CR>
nnoremap <silent> <Leader>w :Rg <C-R><C-W><CR>

filetype plugin on
set splitright
set splitbelow


function! IBusOff()
    " L??u engine hi???n t???i
    let g:ibus_prev_engine = system('ibus engine')
    " Chuy???n sang engine ti???ng Anh
    " N???u b???n th???y c??i c??? ??? ????y
    " kh??? n??ng l?? font c???a b???n ??ang render emoji lung tung...
    " xkb : us :: eng (kh??ng c?? d???u c??ch)
    silent! execute '!ibus engine xkb????????:eng'
endfunction



function! IBusOn()
    let l:current_engine = system('ibus engine')
    " n???u engine ???????c set trong normal mode th??
    " l??c v??o insert mode du??n lu??n engine ????
    if l:current_engine !~? 'xkb????????:eng'
        let g:ibus_prev_engine = l:current_engine
    endif
    " Kh??i ph???c l???i engine
    silent! execute '!ibus engine ' . g:ibus_prev_engine
endfunction

augroup IBusHandler
    " Kh??i ph???c ibus engine khi t??m ki???m
    autocmd CmdLineEnter [/?] silent call IBusOn()
    autocmd CmdLineLeave [/?] silent call IBusOff()
    autocmd CmdLineEnter \? silent call IBusOn()
    autocmd CmdLineLeave \? silent call IBusOff()
    " Kh??i ph???c ibus engine khi v??o insert mode
    autocmd InsertEnter * silent call IBusOn()
    " T???t ibus engine khi v??o normal mode
    autocmd InsertLeave * silent call IBusOff()
augroup END

silent call IBusOff()

"Language tool
let g:ale_linter_aliases = {'tex': ['tex', 'markdown']}
let g:ale_languagetool_executable = "java"
let g:ale_languagetool_options = "-jar /data/runtimes/languagetool/languagetool-commandline.jar --languagemodel /data/runtimes/languagemodel/ --word2vecmodel /data/runtimes/languagemodel/ --disable WHITESPACE_RULE,COMMA_PARENTHESIS_WHITESPACE"
let g:ale_disable_lsp = 1
map <F3> :ALEToggle<CR>


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

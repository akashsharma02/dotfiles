" set rtp+=anaconda3/lib/python3.7/site-packages/powerline/bindings/vim

" Map Space as my leader key
let g:mapleader = "\<Space>"

" Autoload VIM Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load Plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
Plug 'vim-airline/vim-airline-themes'

Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
"     " make YCM compatible with UltiSnips (using supertab)
"     let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"     let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"     let g:SuperTabDefaultCompletionType = '<C-n>'
"     let g:ycm_autoclose_preview_window_after_insertion = 1
"     let g:ycm_seed_identifiers_with_syntax = 1
"     let g:ycm_collect_identifiers_from_tags_files = 1

"     nnoremap <silent> <leader>jd :YcmCompleter GoTo<CR>
"     nnoremap <silent> <leader>ff :YcmCompleter FixIt<CR>
" " }}}
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
    let g:fzf_vim_statusline = 0 " disable statusline overwriting

    nnoremap <silent> <leader><space> :Files<CR>
    nnoremap <silent> <leader>a :Buffers<CR>
    nnoremap <silent> <leader>A :Windows<CR>
    nnoremap <silent> <leader>; :BLines<CR>
    nnoremap <silent> <leader>o :BTags<CR>
    nnoremap <silent> <leader>O :Tags<CR>
    nnoremap <silent> <leader>? :History<CR>
    nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
    nnoremap <silent> <leader>. :Ag<CR>

    nnoremap <silent> K :call SearchWordWithAg()<CR>
    vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
    nnoremap <silent> <leader>gl :Commits<CR>
    nnoremap <silent> <leader>ga :BCommits<CR>
    nnoremap <silent> <leader>ft :Filetypes<CR>

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)

    function! SearchWordWithAg()
        execute 'Ag' expand('<cword>')
    endfunction

    function! SearchVisualSelectionWithAg() range
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        let old_clipboard = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', old_reg, old_regtype)
        let &clipboard = old_clipboard
        execute 'Ag' selection
    endfunction
Plug 'junegunn/vim-easy-align'
    let g:easy_align_ignore_comment = 0 " align comments
    vnoremap <silent> <Enter> :EasyAlign<cr>

Plug 'vimwiki/vimwiki'
    let g:vimwiki_list = [{ 'path': '~/Dropbox/wiki/', 'ext':'.md', 'syntax':'markdown'}]
Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'

call plug#end()

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
match ErrorMsg '\s\+$'         " marks trailing whitespaces as error messages
set backspace=indent,eol,start " allow backspace over everything in insert
" setlocal spell
" set spelllang=en_us
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Visual setup
colorscheme monokai-phoenix
set number    		" show line numbers
set relativenumber 	" make the line numbers relative to the active
set laststatus=2    " always show the statusbar
set showtabline=2   " Always display the tabline, even if there is only one tab
set showcmd 		" show command in bottom bar
set cursorline      " highlight cursor line
set wildmenu        " visual autocomplete for command menu
filetype indent on  " load filetype-specific indent files
set lazyredraw      " redraw only when needed
set showmatch       " highlight matching

" searching setup
set incsearch       " search as characters are entered
set hlsearch        " hightlight matches

" remove trailing whitespaces in the file on save automatically
autocmd BufWritePre * %s/\s\+$//e

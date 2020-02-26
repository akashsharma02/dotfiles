"   _       _ _         _
"  (_)     (_) |       (_)
"   _ _ __  _| |___   ___ _ __ ___
"  | | '_ \| | __\ \ / / | '_ ` _ \
"  | | | | | | |_ \ V /| | | | | | |
"  |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

    let g:mapleader = "\<space>"
    let g:python_host_prog = '~/anaconda3/envs/python2.7/bin/python'
    let g:python3_host_prog = '~/anaconda3/envs/python3.6/bin/python'



"******************************************************************************
"    Vim Plugins
"******************************************************************************
" Autoload VIM Plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/vim-easy-align'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'honza/vim-snippets'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'sbdchd/neoformat'
call plug#end()

"******************************************************************************
" Some basic setup
"******************************************************************************
    set hidden                              " ensure hidden buffers are not abandoned
    set shortmess+=c                        " setting to get shortmessage
    set signcolumn=yes                      " ensure that signcolumn exists for linting and other purposes
    set nobackup nowritebackup              " make no backups of file before overwriting file
    set updatetime=300                      " length of time vim waits to trigger commands after typing stops
    set expandtab tabstop=4 softtabstop=4   " replace tabs with 4 spaces
    set shiftwidth=4                        " spaces to use for autoindent
    match ErrorMsg '\s\+$'                  " marks trailing whitespaces as error messages
    set backspace=indent,eol,start          " allow backspace over everything in insert
    set number relativenumber    		    " show line number and make the line numbers relative to the active
    set showtabline=2                       " Always display the tabline, even if there is only one tab
    set cursorline                          " highlight cursor line
    set lazyredraw                          " redraw only when needed
    set showmatch                           " highlight matching parentheses or other surrounding character
    set splitbelow splitright               " splits open at the bottom and right
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions -=o " Disables automatic commenting on
                                            " newline
    autocmd BufWritePre * %s/\s\+$//e       " remove trailing whitespaces on filesave
    autocmd BufWritePost $MYVIMRC source % | redraw
                                            " auto source VIMRC on save

"******************************************************************************
" Plugin configurations
"******************************************************************************

" Airline configurations
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline_powerline_fonts = 1

" Colorscheme configurations
    colorscheme gruvbox
    hi Normal guibg=NONE ctermbg=NONE

" fzf configurations
    " fuzzy find files in the working directory (where you launched Vim from)
    nnoremap <silent> <leader><space> :Files<CR>
    " fuzzy find text in the working directory
    nnoremap <silent> <leader>. :Ag<CR>
    " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)
    nmap <leader>c :Commands<cr>
    " fuzzy find an open buffer
    nnoremap <silent> <leader>b :Buffers<CR>
    " fuzzy find an open window
    nnoremap <silent> <leader>A :Windows<CR>
    " fuzzy find history of commands
    nnoremap <silent> <leader>? :History<CR>
    nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

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

" Vimwiki configurations
    let g:vimwiki_list = [{ 'path': '~/Dropbox/wiki/', 'ext':'.md', 'syntax':'markdown'}]

" coc.nvim configurations

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

    inoremap <silent><expr> <cr>
          \ pumvisible() ? coc#_select_confirm() :
          \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<Tab>'
    let g:coc_snippet_prev = '<S-Tab>'

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

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
    endfunction

    " Highlight symbol under cursor on CursorHold

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <C-d> <Plug>(coc-range-select)
    xmap <silent> <C-d> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>b
    " Open yank list
    nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Neoformat configurations
    let g:neoformat_enabled_python=['yapf']
    " Enable alignment
    let g:neoformat_basic_format_align = 1
    " Enable tab to spaces conversion
    let g:neoformat_basic_format_retab = 1
    " Enable trimmming of trailing whitespace
    let g:neoformat_basic_format_trim = 1

command! PackUpdate packadd minpac | call minpac#init() | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | call minpac#init() | source $MYVIMRC | call minpac#clean()

if !exists('*minpac#init')
  finish
endif

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('nelstrom/vim-visual-star-search')
call minpac#add('tpope/vim-abolish')
call minpac#add('godlygeek/tabular')
call minpac#add('sjl/gundo.vim')
call minpac#add('tpope/vim-repeat')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('SirVer/ultisnips')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('gerw/vim-HiLinkTrace')
call minpac#add('python-mode/python-mode')
call minpac#add('tpope/vim-commentary')
call minpac#add('kana/vim-textobj-user')
call minpac#add('kana/vim-textobj-entire')
call minpac#add('JamshedVesuna/vim-markdown-preview')
call minpac#add('masukomi/vim-markdown-folding')
call minpac#add('mileszs/ack.vim')
call minpac#add('easymotion/vim-easymotion')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('mg979/vim-visual-multi')
call minpac#add('vim-airline/vim-airline')
" call minpac#add('ycm-core/YouCompleteMe')
call minpac#add('dense-analysis/ale')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('preservim/tagbar')
call minpac#add('Yggdroot/indentLine')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-obsession')
call minpac#add('aklt/plantuml-syntax')
call minpac#add('puremourning/vimspector')

call minpac#add('vim-test/vim-test', {'type': 'opt'})
call minpac#add('lervag/vimtex', {'type': 'opt'})
call minpac#add('kana/vim-vspec', {'type': 'opt'})
call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
" call minpac#add('Shougo/ddu.vim', {'type': 'opt'})

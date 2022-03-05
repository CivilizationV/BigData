" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"		   for Unix:  ~/.vimrc
"		  for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"		  for Haiku:  ~/config/settings/vim/vimrc
"		for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
	finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
	packadd! matchit
endif


" Self added
set laststatus=2
set noswapfile
set nobackup

" http://vimcasts.org/episodes/minpac/
source ~/.vim/packages.vim

runtime macros/matchit.vim

" Enable line numbering
set number

" Enable file-type plugin
set nocompatible

" Enable incremental search
set incsearch
" Mute Search Highlighting
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Making & trigger the :&& command
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Enable the ‘hidden’ Setting Before Running ‘:*do’ Commands
set hidden

" Execute ctags Manually
nnoremap <f9> :!ctags -R<CR>
" Automatically Execute ctags Each Time a File is Saved
" :autocmd BufWritePost * call system("ctags -R")

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" http://vimcasts.org/episodes/the-edit-command/
" set of shortcuts for opening files located in the same directory as the
" current file.
" ‘ew’ stands for open in window. 
" ‘es’ stands for open in split.
" ‘ev’ stands for open in vertical split.
" ‘et’ stands for open in tab.
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" :set wrap linebreak nolist
command! -nargs=* Wrap set wrap linebreak nolist

" http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/
" http://vimcasts.org/episodes/running-vim-within-irb/
" http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
" Only do this part when compiled with support for autocommands
if has("autocmd")
	" Enable filetype detection
	filetype plugin indent on
	" http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/
	" Syntax of these languages is fussy over tabs Vs spaces
	autocmd FileType make setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
	autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab textwidth=79 foldmethod=indent
    autocmd FileType c setlocal foldmethod=marker foldmarker={,}
    autocmd FileType java setlocal foldmethod=marker foldmarker={,}

	" Restore cursor position
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\	exe "normal! g`\"" |
		\ endif

	" Source the vimrc file after saving it
	autocmd BufWritePost .vimrc source $MYVIMRC
endif
if &t_Co > 2 || has("gui_running")
	" Enable syntax highlighting
	syntax on
	" Switch on highlighting the last used search pattern.
	set hlsearch
endif
nmap <leader>v :tabedit $MYVIMRC<CR>

" http://vimcasts.org/episodes/tabs-and-spaces/
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

" http://vimcasts.org/episodes/tidying-whitespace/
function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>

" http://vimcasts.org/episodes/bubbling-text/
" Visually select the text that was last edited/pasted
" nmap gV `[v`]

" http://vimcasts.org/episodes/undo-branching-and-gundo-vim/
" Gundo.vim
if has('python3') 
	let g:gundo_prefer_python3 = 1 
endif
nnoremap <F8> :GundoToggle<CR>

" http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
" https://github.com/altercation/vim-colors-solarized
" At first, set terminal emulator's colorscheme to used the Solarized palette
syntax enable
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized8
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P


" http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
nnoremap <silent> <Plug>TransposeCharacters xp :call repeat#set("\<Plug>TransposeCharacters")<CR>
nmap cp <Plug>TransposeCharacters

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
set nofoldenable

" python
let g:pymode_doc = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
let g:pymode_syntax_print_as_function = 0
let g:pymode_syntax_space_errors = 0
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_lint = 1
let g:pymode_breakpoint = 1
let g:pymode_virtualenv = 1
let g:pymode_folding = 0

let g:pymode_options = 1

let g:pymode_rope = 1
let g:pymode_rope_autoimport_modules = ["os", "shutil", "datetime"]

let g:pymode_rope_completion = 1
let g:pymode_rope_autoimport = 0


" Options for vim-markdown-preview
let vim_markdown_preview_toggle=1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_temp_file=1
let vim_markdown_preview_pandoc=1


" Options for vim-visual-multi
" let g:VM_default_mappings = 1
" let g:VM_theme = 'iceblue'
" let g:VM_maps = {}
" let g:VM_maps["Undo"] = 'u'
" let g:VM_maps["Redo"] = '<C-r>'
" let g:VM_maps["Add Cursor Down"]   = '<C-j>'
" let g:VM_maps["Add Cursor Up"]     = '<C-k>'


" Settings for tagbar
nmap <F7> :TagbarToggle<CR>


" Settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

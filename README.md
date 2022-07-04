# Installation
1. Installation:

    git clone git@github.com:CivilizationV/dotvim.git ~/.vim

2. Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc

3. Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update


# Vim Resources
## Books
1. [Vim - Vi Improved](http://www.truth.sk/vim/vimbook-OPL.pdf)
2. [Practical Vim](https://iccf-holland.org/vim_books.html#practical)
3. [Learning the vi and Vim Editors](https://www.amazon.com/Learning-Vim-Editors-Agility-Editing/dp/1492078808/ref=sr_1_1?keywords=Learning+the+vi+and+Vim+Editors&qid=1655900505&s=books&sr=1-1)
4. [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)
5. [Modern Vim: Craft Your Development Environment with Vim 8 and Neovim](https://www.amazon.com/Modern-Vim-Development-Environment-Neovim/dp/168050262X/ref=sr_1_4?keywords=vim&qid=1652414532&s=books&sr=1-4)

## Projects
1. [vim/vim](https://github.com/vim/vim.git)
2. [nelstrom/dotfiles](https://github.com/nelstrom/dotfiles)
3. [tpope/dotfiles](https://github.com/tpope/dotfiles)
4. [sjl/dotfiles](https://github.com/sjl/dotfiles)
5. [amix/vimrc](https://github.com/amix/vimrc)

## Websites
1. [vim home](https://www.vim.org/)
2. [Seven Habits of Effective Text Editing](http://www.moolenaar.net/habits.html)
3. [vimcasts](http://vimcasts.org/)


# Plugins

## vim-markdown-preview

bugfix
```
diff --git a/plugin/vim-markdown-preview.vim b/plugin/vim-markdown-preview.vim
index 082c69f..9e9e1f6 100644
--- a/plugin/vim-markdown-preview.vim
+++ b/plugin/vim-markdown-preview.vim
@@ -118,9 +118,9 @@ function! Vim_Markdown_Preview_Local()
   if g:vim_markdown_preview_github == 1
     call system('grip "' . b:curr_file . '" --export vim-markdown-preview.html --title vim-markdown-preview.html')
   elseif g:vim_markdown_preview_perl == 1
-    call system('Markdown.pl "' . b:curr_file . '" > /tmp/vim-markdown-preview.html')
+    call system('Markdown.pl "' . b:curr_file . '" > vim-markdown-preview.html')
   elseif g:vim_markdown_preview_pandoc == 1
-    call system('pandoc --standalone "' . b:curr_file . '" > /tmp/vim-markdown-preview.html')
+    call system('pandoc --standalone "' . b:curr_file . '" > vim-markdown-preview.html')
   else
     call system('markdown "' . b:curr_file . '" > vim-markdown-preview.html')
   endif
```

## YouCompleteMe

bugfix
unable to get local issuer certificate
```
diff --git a/build.py b/build.py
index 21db3470..a440d9b9 100755
--- a/build.py
+++ b/build.py
@@ -18,6 +18,8 @@ import tarfile
 from zipfile import ZipFile
 import tempfile
 import urllib.request
+import ssl
+import certifi


 class InstallationFailed( Exception ):
@@ -146,7 +148,7 @@ def CheckFileIntegrity( file_path, check_sum ):


 def DownloadFileTo( download_url, file_path ):
-  with urllib.request.urlopen( download_url ) as response:
+  with urllib.request.urlopen( download_url, context=ssl.create_default_context(cafile=certifi.where())) as response:
     with open( file_path, 'wb' ) as package_file:
       package_file.write( response.read() )
```

# [browsing the git object database](http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/)

## Reading a file from any git branch
```
:Gedit branchname:path/to/file
:Gedit master:Gemfile
```

## Exploring the git object database

4 kinds of git object:

1. blobs - correspond to the content of a file
2. trees - correspond to a directory on the filesystem, representing a list of blobs and trees
3. commits - can reference a tree and one or more parent commits
4. tags - refer to a particular commit by name

```
:Gedit SHA
git show SHA
git ls-tree SHA
```
Press the `a` key to toggle between the git show and git ls-tree views.

Whenever your current buffer contains a git tree or blob, you can always jump up to the commit object for the current tree by pressing `C`.

```
:Gedit HEAD
:Gedit HEAD^
```


# [exploring the history of a git repository](http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/)

## Browsing past revisions or commits in the quickfix list

| command                    | action                                                                                                   |
| :------                    | :-----                                                                                                   |
| `:Gclog`                      | load all previous revisions of the current file into the quickfix list                                   |
| `:Gclog -10`                  | load the last ten previous revisions of the current file into the quickfix list                          |
| `:Gclog -10 --reverse`        | load the first ten revisions of the current file into the quickfix list (in reverse chronological order) |
| `:Gclog -1 --until=yesterday` | load the last version of the current file that was checked in before midnight last night                 |
| `:Gclog --`                   | load all ancestral commit objects into the quickfix list                                                 |
| `:Gclog -- %`                 | load all ancestral commit objects that touched the current file into the quickfix list                   |

## Searching a git repository

### Searching the working tree

grep
```
grep -r fugitive * | view -
grep -r --exclude="*.sql" fugitive * | view -
```

git grep
```
git grep fugitive * | view -
```

:Ggrep
```
:Ggrep fugitive
:copen
```

### Searching branches, tags and commits

```
:Ggrep 'find me' branchname
:Ggrep 'find me' SHA
```

| command                  | action                                                                |
| -------                  | ------                                                                |
| `:Ggrep findme`            | search for ‘findme’ in working copy files (excluding untracked files) |
| `:Ggrep --cached findme`   | search for ‘findme’ in the index                                      |
| `:Ggrep findme branchname` | search for ‘findme’ in branch ‘branchname’                            |
| `:Ggrep findme tagname`    | search for ‘findme’ in tag ‘tagname’                                  |
| `:Ggrep findme SHA`        | search for ‘findme’ in the commit/tag identified by SHA               |


### Searching for text in a commit message

git log
```
git log --grep=findme
```

:Gclog
```
:Gclog --grep='xtype' --
```

| command                  | action                                                                                    |
| -------                  | ------                                                                                    |
| `:Gclog --grep=findme --`   | search for ‘findme’ in all ancestral commit messages                                      |
| `:Gclog --grep=findme -- %` | search for ‘findme’ in all ancestral commit messages that touch the currently active file |


### Searching for text added or removed by a commit

git log
```
git log -Sfindme
```

:Gclog
```
:Gclog -Spaginate --
```

| command             | action                                                                                           |
| -------             | ------                                                                                           |
| `:Gclog -Sfindme --`   | search for ‘findme’ in the diff for each ancestral commit                                        |
| `:Gclog -Sfindme -- %` | search for ‘findme’ in the diff for each ancestral commit that touches the currently active file |


# Git commands

`git log --graph --oneline --decorate --all`

`git commit -a -m "COMMIT_MESSAGE"` : Add only modified files to staging area & commit

`git checkout BRANCH_NAME` : Switch/Checkout to `BRANCH_NAME`

`git checkout -b NEW_BRANCH_NAME` : Create & checkout `NEW_BRANCH_NAME`

`git status`


## LOG
[`git log`](https://git-scm.com/docs/git-log)
> 
`--graph      `: Draw a text-based graphical representation of the commit history on the left hand side of the output.

`--oneline      `:

`--decorate     `:

`--all          `:

`--relative-date`: shows dates relative to the current time, e.g. “2 hours ago”.

`--stat         `:


## COMMIT adding modified files only
`git commit -a -m "Commit message"`


## CHECKOUT a branch
[`git checkout`](https://git-scm.com/docs/git-checkout)
>
`-f` : proceed even if the index or the working tree differs from HEAD. This is used to throw away local changes.

`-b <new_branch>` : Create a new branch named <new_branch> and start it at <start_point>

`-t`|`--track` : set up "upstream" configuration

`-m`|`--merge` : 

`git checkout <branch>`


## BRANCH: List, create, or delete branches
[`git branch`](https://git-scm.com/docs/git-branch)
>
`-d`|`--delete`: Delete a branch. The branch must be fully merged in its upstream branch, or in HEAD if no upstream was set with --track or --set-upstream.

`-D` : Shortcut for `--delete --force`.

`-f`|`--force` : Reset <branchname> to <startpoint> if <branchname> exists already

`-i`|`--ignore-case` : Sorting and filtering branches are case insensitive.

`-m`|`--move` : Move/rename a branch and the corresponding reflog. To rename: `git branch -m <oldname> <newname>`.To rename the current branch, you can do: `git branch -m <newname>`.

`-a`|`--all` : List both remote-tracking branches and local branches.


## STATUS
`git status`


## ADD new/modified to staging area
`git add "FILES"`


## SAVE PASSWORD
(`git config credential.helper store`)[https://git-scm.com/docs/git-credential-store]

A `.git-credentials` file is stored/read in plaintext in order of precedence of: `~/.git-credentials` or `$XDG_CONFIG_HOME/git/credentials`


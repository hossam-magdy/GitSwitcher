# Git commands

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


## BRANCH: List, create, or delete branches
[`git branch`](https://git-scm.com/docs/git-branch)
>
`-d` : 


## CHECKOUT a branch
[`git checkout`](https://git-scm.com/docs/git-checkout)
>
`-f` : proceed even if the index or the working tree differs from HEAD. This is used to throw away local changes.

`-b <new_branch>` : Create a new branch named <new_branch> and start it at <start_point>

`-t`|`--track` : set up "upstream" configuration

`-m`|`--merge` : 

`git checkout <branch>`


## STATUS
`git status`


## ADD new/modified to staging area
`git add "FILES"`


## SAVE PASSWORD
`git config credential.helper store`


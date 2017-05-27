# Git commands

`git status`

`git log --graph --oneline --decorate --all`

`git commit -a -m "COMMIT_MESSAGE"` : Add only modified files to staging area & commit

`git commit -a --amend` : Add only modified files to the last commit (amend/edit the last commit)

`git checkout BRANCH_NAME` : Switch/Checkout to `BRANCH_NAME`

`git checkout -b NEW_BRANCH_NAME` : Create & checkout `NEW_BRANCH_NAME`

`git branch` : List LOCAL branches. `git branch -r` : List REMOTE branches. `git branch -a` : List ALL branches.

`git branch NEW_BRANCH` : Create new branch.

`git branch -d BRANCH_TO_DELETE` : Delete a branch (if it is fully-merged to its upstream or HEAD)

`git branch -D BRANCH_TO_DELETE` : Delete a branch (regardless the merge state to its upstream or HEAD)

`git checkout HEAD -- my-file.txt`: resets only `my-file.txt` to its state at current `HEAD`

`git reset --hard`: DISCARD all uncommited changes in working tree

`git reset HEAD~1 --soft`: remove a commit (reset HEAD to 1st previous commit) & KEEP changes in working tree

`git reset HEAD~1 --hard`: remove a commit (reset HEAD to 1st previous commit) & DISCARD changes in working tree

`git config credential.helper store` : store/read credentials as plaintext in `~/.git-credentials`

`git config --global user.email "you@example.com"`: set the Email of the author/committer

`git config --global user.name "Your Name"`: set the Name of the author/committer


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
[`git commit`](https://git-scm.com/docs/git-commit)
>
`-a` |`--all` : automatically stage files that have been modified and deleted, but new files you have not told Git about are not affected

`--reset-author` : When used with -C/-c/--amend options, or when committing after a conflicting cherry-pick, declare that the authorship of the resulting commit now belongs to the committer. This also renews the author timestamp.

`-m <msg>`|`--message=<msg>` : Use the given `<msg>` as the commit message. If multiple -m options are given, their values are concatenated as separate paragraphs

`--amend` : Replace the tip of the current branch by a new commit. The new commit has the same parents and author as the current one (the --reset-author option can countermand this). It is a rough equivalent for:

	$ git reset --soft HEAD^
	$ ... do something else to come up with the right tree ...
	$ git commit -c ORIG_HEAD

`-F <file>`|`--file=<file>` : Take the commit message from the given file

`-v`|`--verbose` : Show unified diff between the HEAD commit and what would be committed at the bottom of the commit message template to help the user describe the commit by reminding what changes the commit has. Note that this diff output doesn’t have its lines prefixed with #. This diff will not be a part of the commit message. 

`--dry-run` : Do not create a commit, but show a list of paths that are to be committed, paths with local changes that will be left uncommitted and paths that are untracked.

`<file>…` : When files are given on the command line, the command commits the contents of the named files, without recording the changes already staged


## RESET: Reset current HEAD to the specified state
[`git reset`](https://git-scm.com/docs/git-reset)


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


## DIFF: Show changes between commits, commit and working tree, etc
[`git diff`](https://git-scm.com/docs/git-diff)
>
`-a` |`--all` : automatically stage files that have been modified and deleted, but new files you have not told Git about are not affected


## STATUS
`git status`


## ADD new/modified to staging area
`git add "FILES"`


## SAVE PASSWORD
[`git config credential.helper store`](https://git-scm.com/docs/git-credential-store)

A `.git-credentials` file is stored/read as plaintext in order of precedence of: `~/.git-credentials` or `$XDG_CONFIG_HOME/git/credentials`


## Note:
In any git command: parameter ` -- ` (with space before & after) basically means: *treat every argument after this point as a file name*.


# ShortNotes of Git commands

### This is a quick reference, brief documentation for as a summary of 3 Udacity courses:
### [ [ud775](https://www.udacity.com/course/how-to-use-git-and-github--ud775) , [ud123](https://www.udacity.com/course/version-control-with-git--ud123) , [ud456](https://www.udacity.com/course/github-collaboration--ud456) ] for the git commands used in hands-on situations.

* * *

# The most common:

#### - Status & log

`git status`

`git log --graph --oneline --decorate --all --stat`

#### - Committing

`git commit -a -m "COMMIT_MSG"`: Add only changed tracked-files to staging area & commit

`git commit -a --amend` : Amend/edit the last commit to include changes in tracked files

#### - Branching & switching (checkout)

`git checkout BRANCH_NAME` : Switch/Checkout to `BRANCH_NAME`

`git checkout -b NEW_BRANCH_NAME` : Create & checkout a new branch

`git branch` : List LOCAL branches. `git branch -r` : List REMOTE branches. `git branch -a` : List ALL branches.

`git branch NEW_BRANCH` : Create new branch.

`git branch -d BRANCH_TO_DELETE` : Delete a branch (if it is fully-merged to its upstream or HEAD)

`git branch -D BRANCH_TO_DELETE` : Delete a branch (regardless the merge state to its upstream or HEAD)

`git checkout HEAD -- my-file.txt`: resets only `my-file.txt` to its state at current `HEAD`

#### - Remove last commit[s] or uncommitted changes

`git reset HEAD~1 [--mixed]`: remove the last 1 commit & KEEP changes in working directory/tree

`git reset HEAD~1 --soft`: remove the last 1 commit & KEEP changes in "Changes to be committed"

`git reset HEAD~1 --hard`: remove the last 1 commit & DISCARD changes in working directory/tree

`git reset --hard`: DISCARD all uncommited changes in working tree or staging area

#### - Changing the committer identity

`git config [--global] user.email "YOU@EXAMPLE.COM"`: set the Email of the author/committer

`git config [--global] user.name "YOUR NAME"`: set the Name of the author/committer

#### - Storing credentials

`git config credential.helper store` : [store](https://git-scm.com/docs/git-credential-store) the next input credentials as plaintext in `~/.git-credentials`

`git config credential.helper cache [--timeout=900]` : [cache](https://git-scm.com/docs/git-credential-cache) the next input credentials as plaintext in global file.
>To forget all cached credentails before timeout: `git credential-cache exit`

`git remote set-url origin https://USER:PASS@repo-url.com/repo.git`: store credentials as plaintext for local repository (`.git/config`)


* * *

# Detailed:

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

`-m <msg>`|`--message=<msg>` : Use the given `<msg>` as the commit message. If multiple -m options are given, their values are concatenated as separate paragraphs  (use multiple `-m` attributes for multi-line commit message)

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

`git reset HEAD~1 [--mixed]`: remove a commit (reset HEAD to 1st previous commit) & KEEP changes in working directory/tree

`git reset HEAD~1 --soft`: remove a commit (reset HEAD to 1st previous commit) & KEEP changes in "Changes to be committed"

`git reset HEAD~1 --hard`: remove a commit (reset HEAD to 1st previous commit) & DISCARD changes in working directory/tree


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


## SAVE CREDENTIALS
[`git config credential.helper store`](https://git-scm.com/docs/git-credential-store): The next input credentials are stored in `.git-credentials` is as plaintext in order of precedence of: `~/.git-credentials` or `$XDG_CONFIG_HOME/git/credentials`

[`git config credential.helper cache [--timeout=900]`](https://git-scm.com/docs/git-credential-cache): The next input credentials are cached in `$XDG_CACHE_HOME/git/credential/socket` unless `~/.git-credential-cache/socket` exists

`git credential-cache exit`: Forget all cached credentails before timeout

`git remote set-url origin https://USERNAME:PASSWORD@repository-url.com/group/repo.git`: Store credentials as plaintext in `.git/config` file of local repository


## Note:
In any git command: parameter ` -- ` (with space before & after) basically means: *treat every argument after this point as a file name*.


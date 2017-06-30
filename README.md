# ShortNotes of Git commands

### This is a quick reference or brief documentation as a summary of 3 Udacity courses (in order):
### [ [ud775](https://www.udacity.com/course/how-to-use-git-and-github--ud775) , [ud123](https://www.udacity.com/course/version-control-with-git--ud123) , [ud456](https://www.udacity.com/course/github-collaboration--ud456) ] for the git commands used in hands-on situations.

* * *

# The most common:

### - Status & log

`git status`

`git log --graph --oneline --decorate --all --stat`

### - Committing

`git commit -am "COMMIT_MSG"`: Add only changed tracked-files to staging area & commit

`git commit -a --amend` : Amend/edit the last commit to include changes in tracked files

### - Branching & switching (checkout)

`git checkout BRANCH_NAME` : Switch/Checkout to `BRANCH_NAME`

`git checkout -b NEW_BRANCH_NAME` : Create & checkout a new branch

`git branch` : List LOCAL branches. `git branch -r` : List REMOTE branches. `git branch -a` : List ALL branches.

`git for-each-ref --ignore-case --sort=refname --format='%(refname:lstrip=3)' refs/remotes/`: List remote branches

`git branch NEW_BRANCH [<start-point>]` : Create new branch [optionally from a start-point (refs)]

`git branch -d BRANCH_TO_DELETE` : Delete a branch (if it is fully-merged to its upstream or HEAD)

`git branch -D BRANCH_TO_DELETE` : Delete a branch (regardless the merge state to its upstream or HEAD)

`git checkout HEAD -- my-file.txt`: resets only `my-file.txt` to its state at current `HEAD`

### - Removing last commit[s] or uncommitted changes or Reverting specific commit[s]

`git reset HEAD~1 [--mixed]`: remove the last 1 commit & KEEP changes in working directory/tree

`git reset HEAD~1 --soft`: remove the last 1 commit & KEEP changes in "Changes to be committed"

`git reset HEAD~1 --hard`: remove the last 1 commit & DISCARD changes in working directory/tree

`git reset --hard`: DISCARD all uncommited changes in working tree or staging area

`git revert COMMIT_ID`: Revert/Undo the changes of a commit and Create a new commit with the reverted changes

### - Changing the committer identity

`git config [--global] user.email "YOU@EXAMPLE.COM"`: set the Email of the author/committer

`git config [--global] user.name "YOUR NAME"`: set the Name of the author/committer

### - Storing credentials

`git config credential.helper store` : [store](https://git-scm.com/docs/git-credential-store) the next input credentials as plaintext in `~/.git-credentials`

`git config credential.helper cache [--timeout=900]` : [cache](https://git-scm.com/docs/git-credential-cache) the next input credentials as plaintext in global file.

`git credential-cache exit`: Forget all cached credentails (stored by credential.helper cache) even before timeout

`git remote set-url origin https://USER:PASS@repo-url.com/repo.git`: store credentials as plaintext for local repository (`.git/config`)

### - Diff branches, Merging & Solving conflicts (**: must run, *: recommended)

*`git diff ..BRANCH_TO_MERGE` or `git diff CURRENT_BRANCH..BRANCH_TO_MERGE`: Compare the tips of two branches

**`git merge --no-commit --stat --progress [--strategy-option==ours|theirs] BRANCH_TO_MERGE`: Merge branch to current HEAD (current checked-out branch)

*`git diff HEAD`: Show any changes (in case merge is done with --no-commit)

*`git diff HEAD --name-only`: List file names that changed (in case merge is done with --no-commit)

*[if conflict] `git diff --name-only --diff-filter=U`: List file names that have merge conflicts

*[if conflict] `git diff`: Show the merge conflicts

`git log --merge --decorate --source -p PATH_TO_FILE`: Show the history of a single file indicating branch names of each change

`git checkout --ours -- PATH_TO_FILE`: Revert a file to to its version at "our branch" (was checked out / being merged INTO)

`git checkout --theirs -- PATH_TO_FILE`: Revert a file to to its version at "their branch" (being merged)

`git checkout BRANCH_NAME -- PATH_TO_FILE`: Revert a file to to its version at specific branch

**`git commit -am "Merged branch BRANCH_TO_MERGE"`: Comit the merge

* * *

# Handy tools & guides:

### [Git Commit Message Style Guide](https://udacity.github.io/git-styleguide/)

### [`git-flow`](https://github.com/nvie/gitflow)

A collection of Git extensions to provide high-level repository operations for [Vincent Driessen's branching model](http://nvie.com/posts/a-successful-git-branching-model/).

- To install: `curl https://raw.githubusercontent.com/nvie/gitflow/develop/contrib/gitflow-installer.sh | bash;`

- To initialize/use: `cd REPO_PATH;`,
then: `git flow init;`,
then run any of [git-flow commands](https://github.com/nvie/gitflow/wiki/Command-Line-Arguments),
see also:
[guide 1](https://blog.axosoft.com/2017/01/31/gitflow/), 
[guide 2](https://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/), 
[under the hood](https://leanpub.com/git-flow/read)

### [`git-webui`](https://github.com/alberthier/git-webui)

A standalone git-extension for git repositories web-based user interface.

(`.git-webui` folder, <2MB, located in user's home dir => ~/)

- To install: `curl https://raw.githubusercontent.com/alberthier/git-webui/master/install/installer.sh | bash;`

- To run: `cd REPO_PATH;`, then: `git webui [-h] [--port PORT] [--repo-root REPO_ROOT] [--allow-hosts ALLOW_HOSTS] [--no-browser] [--host HOST];`

- To stop: kill the `python` process

- To uninstall: `curl https://raw.githubusercontent.com/alberthier/git-webui/master/install/uninstaller.sh | bash;`

* * *

# Detailed:

## LOG
[`git log`](https://git-scm.com/docs/git-log)
> 
`--graph	`: Draw a text-based graphical representation of the commit history on the left hand side of the output.

`--oneline	`:

`--decorate	`:

`--all		`:

`--relative-date`: shows dates relative to the current time, e.g. “2 hours ago”.

`--stat		`:

`--merges	`: Print only merge commits. This is exactly the same as --min-parents=2

`--merge	`: After a failed merge, show refs that touch files having a conflict and don’t exist on all heads to merge

`--source	`: show the ref (branch) name given on the command line by which each commit was reached


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


## REVERT: Revert some existing commits
[`git revert`](https://git-scm.com/docs/git-revert)

`git revert <commit>`: Revert/Undo/Negate the changes specified by a commit and Create a new commit with the reverted changes
>
`-n`|`--no-commit` : Usually the command automatically creates some commits with commit log messages stating which commits were reverted. This flag applies the changes necessary to revert the named commits to your working tree and the index, but does not make the commits


## CHECKOUT a branch
[`git checkout`](https://git-scm.com/docs/git-checkout)
>
`-f`|`--force` : proceed even if the index or the working tree differs from HEAD. This is used to throw away local changes.

`-b <new_branch>` : Create a new branch named <new_branch> and start it at <start_point>

`-t`|`--track` : set up "upstream" configuration

`-m`|`--merge` : When switching branches, if you have local modifications to files that are different between the current branch and the branch to which you are switching, the command refuses to switch branches in order to preserve your modifications in context. However, with this option, a three-way merge between the current branch, your working tree contents, and the new branch is done, and you will be on the new branch.

`--detach` : Rather than checking out a branch to work on it, check out a commit for inspection and discardable experiments. This is the default behavior of "git checkout <commit>" when <commit> is not a branch name.

`git checkout <branch/commit>`


## BRANCH: List, create, or delete branches
[`git branch`](https://git-scm.com/docs/git-branch)
>
`-d`|`--delete`: Delete a branch. The branch must be fully merged in its upstream branch, or in HEAD if no upstream was set with --track or --set-upstream.

`-D` : Shortcut for `--delete --force`.

`-f`|`--force` : Reset <branchname> to <startpoint> if <branchname> exists already

`-i`|`--ignore-case` : Sorting and filtering branches are case insensitive.

`-m`|`--move` : Move/rename a branch and the corresponding reflog. To rename: `git branch -m <oldname> <newname>`.To rename the current branch, you can do: `git branch -m <newname>`.

`-r`|`--remotes` : List both remote-tracking branches.

`-a`|`--all` : List both remote-tracking branches and local branches.

`-u <upstream>`|`--set-upstream-to=<upstream>`: Set up <branchname>'s tracking information so <upstream> is considered <branchname>'s upstream branch. `git branch -u myRemoteName/myBranchName [myBranchName]`


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


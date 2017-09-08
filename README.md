# ShortNotes of Git commands

### This is a quick reference or brief documentation as a summary of 3 Udacity courses (in order):
### [ [ud775](https://www.udacity.com/course/how-to-use-git-and-github--ud775) , [ud123](https://www.udacity.com/course/version-control-with-git--ud123) , [ud456](https://www.udacity.com/course/github-collaboration--ud456) ] for the git commands used in hands-on situations.

* * *

# The most common:

### - Status, log, commit search & upgrading from remote

`git status`

`git log --graph --oneline --decorate --all --stat`

`git log --oneline --grep="STRING" -F -i`: Find/list all commits with msg including case-insensitive `STRING`

`git fetch [--all]`: Fetch all remote[s] changes

`git reset --hard @{u}`: RESET (hardly) current branch state to its upstream

`git rebase`: Rebase current branch state to its upstream (without loosing the unpushed local commits)

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

`git branch -m <oldname> <newname>`: to rename a branch while pointed to any branch

`git branch -m <newname>`: to rename the current branch

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

### - Configuring [difftool](https://git-scm.com/docs/git-difftool)(s) & [mergetool](https://git-scm.com/docs/git-mergetool)(s)

difftool.[meld](http://meldmerge.org/): `git config --global difftool.meld.cmd '"C:/Program Files (x86)/Meld/Meld.exe" "$LOCAL" "$REMOTE"'`

mergetool.[meld](http://meldmerge.org/): `git config --global mergetool.meld.cmd '"C:/Program Files (x86)/Meld/Meld.exe" --auto-merge "$LOCAL" "$BASE" "$REMOTE" --output "$MERGED"'`

difftool.[p4merge](https://www.perforce.com/downloads/visual-merge-tool): `git config --global difftool.p4.cmd '"C:/Program Files/Perforce/p4merge.exe" "$LOCAL" "$REMOTE"'`

mergetool.[p4merge](https://www.perforce.com/downloads/visual-merge-tool): `git config --global mergetool.p4.cmd '"C:/Program Files/Perforce/p4merge.exe" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"'`

difftool.[winmerge](http://winmerge.org/): `git config --global difftool.winmerge.cmd '"WinMergeU.exe" -e -u -dl Local -dr Remote "$LOCAL" "$REMOTE"'`

mergetool.[winmerge](http://winmerge.org/): `git config --global mergetool.winmerge.cmd '"WinMergeU.exe" -e -u -dl Base -dr Mine "$LOCAL" "$REMOTE" "$MERGED"'`

`git config --global difftool.prompt false`: disable prompt on lanching `difftool` on each file diff

`git config --global mergetool.prompt false`: disable prompt on lanching `mergetool` on each file diff

`git config --global diff.tool meld`: set the `difftool` to `meld`, `p4` OR `winmerge`

`git config --global merge.tool meld`: set the `mergetool` to `meld`, `p4` OR `winmerge`

`git difftool [-d|--dir-diff] ..RightBranch`: diff with another branch/commit using difftool

`git difftool [-d|--dir-diff] LeftBranch..RightBranch`: diff with another branch/commit using difftool

### - Storing credentials & other configurations

`git config credential.helper store` : [store](https://git-scm.com/docs/git-credential-store) the next input credentials as plaintext in `~/.git-credentials`

`git config credential.helper cache [--timeout=900]` : [cache](https://git-scm.com/docs/git-credential-cache) the next input credentials as plaintext in global file.

`git credential-cache exit`: Forget all cached credentails (stored by credential.helper cache) even before timeout

`git remote set-url origin https://USER:PASS@repo-url.com/repo.git`: store credentials as plaintext for local repository (`.git/config`)

`git config --global core.autocrlf false`: True => EOL in working directory is CRLF while in repository is LF. False => EOL is not changed.  (EOL changes "LF=>CRLF" occur @ checkout in windows).

### - Diff branches, Merging & Solving conflicts (**: must run, *: recommended)

*`git diff ..BRANCH_TO_MERGE --ignore-all-space` or `git diff CURRENT_BRANCH..BRANCH_TO_MERGE`: Compare the tips of two branches

**`git merge --no-commit --stat --progress [--strategy-option==ours|theirs] BRANCH_TO_MERGE`: Merge branch to current HEAD (current checked-out branch)

*`git diff HEAD -w --ignore-blank-lines`: Show any changes (in case merge is done with --no-commit)

*`git diff HEAD -w --ignore-blank-lines --name-only`: List file names that changed (in case merge is done with --no-commit)

*[if conflict] `git mergetool`: run the pre-configured `mergetool` to resolve conflicts

*[if conflict] `git diff -w --ignore-blank-lines`: Show the merge conflicts

*[if conflict] `git diff -w --ignore-blank-lines --name-only --diff-filter=U`: List file names that have merge conflicts

`git log --merge --decorate --source -p PATH_TO_FILE`: Show the history of a single file indicating branch names of each change

`git checkout --ours -- PATH_TO_FILE`: Revert a file to to its version at "our branch" (was checked out / being merged INTO)

`git checkout --theirs -- PATH_TO_FILE`: Revert a file to to its version at "their branch" (being merged)

`git checkout BRANCH_NAME -- PATH_TO_FILE`: Revert a file to to its version at specific branch

**`git commit -am "Merged branch BRANCH_TO_MERGE"`: Commit the merge

### - Tagging:

`git tag <tagname> <commit>`: Create new tag at specified commit

`git tag -d <tagname>`: Delete existing tag with given name

`git tag -l`: List all existing tags

* * *

# Handy tools & guides:

### [Git Commit Message Style Guide](https://udacity.github.io/git-styleguide/)

### Video guides for git & git-flow

- [(Introducing git commands) Learn Git in 20 Minutes](https://www.youtube.com/watch?v=Y9XZQO1n_7c)

- [(Realizing what git commands actually do) Udacity: GIT Workflow - Software Development Process - Georgia Tech](https://www.youtube.com/watch?v=3a2x1iJFJWc)

- [(Introducing concepts remote, local, push, pull) Learn to Git: Basic Concepts](https://www.youtube.com/watch?v=8KCQe9Pm1kg)

- [(Branching for large projects) Git workflows in the Enterprise](https://www.youtube.com/watch?v=gLWSJXBbJuE)

- [Increasing Agility Through Continuous Delivery: Branching Strategy](https://www.youtube.com/watch?v=y4yg7aT4NgM)

- [BuildaModule: Introduction to branching and merging in Git](https://www.youtube.com/watch?v=BEXAx1qPm-o)

- [BuildaModule: How to use a scalable Git branching model called Gitflow](https://buildamodule.com/video/change-management-and-version-control-deploying-releases-features-and-fixes-with-git-how-to-use-a-scalable-git-branching-model-called-gitflow#viewing)

### Extenstion: [`git-flow`](https://github.com/petervanderdoes/gitflow-avh)

A collection of Git extensions to provide high-level repository operations for Vincent Driessen's [branching model](http://nvie.com/posts/a-successful-git-branching-model/) with functionality not added to [original](https://github.com/nvie/gitflow) branch.

- To install (updated edition): `curl https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh | bash -s install develop;`

- To initialize/use: `cd REPO_PATH;`,
then: `git flow init;`,
then run any of [git-flow commands](https://github.com/petervanderdoes/gitflow-avh/wiki#reference),
see:
[cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/), 
[1](https://blog.sourcetreeapp.com/2012/08/01/smart-branching-with-sourcetree-and-git-flow/)
[2](https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/git-flow), 
[3](https://blog.axosoft.com/2017/01/31/gitflow/), 
[4](https://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/), 
[5](https://leanpub.com/git-flow/read), 
[compare commands](https://gist.github.com/Leland/eae99114bcf5349e692f4aca63193775)

- To uninstall: `curl https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh | bash -s uninstall;`

- Note: use `--showcommands` option with any `git-flow command` to: *Show git commands while executing them*

- Note: you can also install [`git-flow-completion`](https://github.com/petervanderdoes/git-flow-completion)

### Extenstion: [`git-webui`](https://github.com/alberthier/git-webui)

A standalone git-extension for git repositories web-based user interface.

(`~/.git-webui` folder, <2MB, ~ = user's home dir)

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

`--oneline	`: This is a shorthand for `--pretty=oneline --abbrev-commit` used together.

`--decorate	`: Print out the ref names of any commits that are shown

`--all		`: Pretend as if all the refs in `refs/`, along with `HEAD`, are listed on the command line as `<commit>`

`--relative-date`|[`--date=relative`](https://git-scm.com/docs/git-log#git-log---dateltformatgt): shows dates relative to the current time, e.g. “2 hours ago”.

`--stat		`: Generate a diffstat. By default, as much space as necessary will be used for the filename part, and the rest for the graph part

`--merges	`: Print only merge commits. This is exactly the same as --min-parents=2

`--merge	`: After a failed merge, show refs that touch files having a conflict and don’t exist on all heads to merge

`--source	`: show the ref (branch) name given on the command line by which each commit was reached

`--pretty[=<format>]`|`--format=<format>`: Pretty-print the contents of the commit logs in a given format, where <format> can be one of `oneline`, `short`, `medium`, `full`, `fuller`, `email`, `raw`, `format:<string>` and `tformat:<string>`. When `<format>` is none of the above, and has `%placeholder` in it, it acts as if `--pretty=tformat:<format>` were given. See the "[PRETTY FORMATS](https://git-scm.com/docs/git-log#_pretty_formats)" section for some additional details for each format. When `=<format>` part is omitted, it defaults to medium.

`--grep=<pattern>`: Limit the commits output to ones with log message that matches the specified pattern (regex). With more than one `--grep=<pattern>`, commits whose message matches any of the given patterns are chosen (but see `--all-match`). When `--show-notes` is in effect, the message from the notes is matched as if it were part of the log message.

`--all-match`: Limit the commits output to ones that match all given `--grep`, instead of ones that match at least one

`--invert-grep`: Limit the commits output to ones with log message that do not match the pattern specified with `--grep=<pattern>`

`-i`|`--regexp-ignore-case`: Match the regular expression limiting patterns without regard to letter case

`--basic-regexp`: Consider the limiting patterns to be basic regular expressions; this is the default

`-E`|`--extended-regexp`: Consider the limiting patterns to be extended regular expressions instead of the default basic regular expressions

`-F`|`--fixed-strings`: Consider the limiting patterns to be fixed strings (don’t interpret pattern as a regular expression)

`--perl-regexp`: Consider the limiting patterns to be Perl-compatible regular expressions. Requires libpcre to be compiled in

`-S<string>`: Look for differences that change the number of occurrences of the specified string (i.e. addition/deletion) in a file. Intended for the scripter’s use.

It is useful when you’re looking for an exact block of code (like a struct), and want to know the history of that block since it first came into being: use the feature iteratively to feed the interesting block in the preimage back into -S, and keep going until you get the very first version of the block.

`-G<regex>`: Look for differences whose patch text contains added/removed lines that match <regex>. Notice the difference between `-S<regex> --pickaxe-regex` and `-G<regex>`.

`--pickaxe-all`: When -S or -G finds a change, show all the changes in that changeset, not just the files that contain the change in <string>

`--pickaxe-regex`: Treat the <string> given to -S as an extended POSIX regular expression to match

`-w`|`--ignore-all-space`: Ignore whitespace when comparing lines. This ignores differences even if one line has whitespace where the other line has none


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

`-w`|`--ignore-all-space`: Ignore whitespace when comparing lines

`--ignore-blank-lines`: Ignore changes whose lines are all blank


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


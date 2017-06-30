#!/bin/bash
reqGitVer='2.13.0';
#################################### CONFIGURATIONS
repositoryPath='/path/to/repo';
remoteName='origin';
checkoutParams='--force --progress';
checkoutRemotely=0;
listSortByField='-creatordate' # Available values: refname || -creatordate || authorname || authorname
tmpFile='/tmp/git-repo-switcher.txt';
# Config. of listing refs (branches & tags)
colW_num=2;
colW_refname=30;
colW_date=11;
colW_author=13;
colW_commitID=7;
colW_commitMsg=12;
colW_ALL=80; # Should equal to (sum of colW_*) + (num of colW_* - 1)
col_Sep='|'; # Separator between columns
# READY VARS: num refname date author commitID commitMsg
dateFormat='%d/%m_%H.%M'; #'%Y-%m-%d %H:%M:%S'
rowSeparator=''; #"printf '%.0s-' {1..${colW_ALL}}; printf '\n';";
rowHeader='eval ${rowSeparator}; printf "${S_ListingHeaderOn}%${colW_num}s${col_Sep}%-${colW_refname}s${col_Sep}%-${colW_date}s${col_Sep}%-${colW_commitID}s${col_Sep}%-${colW_commitMsg}s${col_Sep}%${colW_author}s${S_ListingHeaderOf}\n" "#" "REFNAME (BRANCH/TAG)" "COMMIT:DATE" "ID" "MSG..." "BY"; eval ${rowSeparator}; ';
rowListing='printf "%${colW_num}d${col_Sep}${S_ifCurrentON}%-${colW_refname}s${S_ifCurrentOF}${col_Sep}%-${colW_date}s${col_Sep}%${colW_commitID}s${col_Sep}%-${colW_commitMsg}s${col_Sep}%${colW_author}s\n" "$num" "${refname:0:${colW_refname}}" "$date" "${commitID:0:${colW_commitID}}" "${commitMsg:0:${colW_commitMsg}}" "${author:0:${colW_author}}"';

#git config credential.helper store;
#git -c color.ui=false status;
#sudo_pass='6236';
#ssh_sudo_command='echo '"'$ssh_sudo_pass'"' | sudo -p "" -S '
#echo "${sudo_pass}" | sudo -p "" -S git fetch --all;

# STYLING
S_ULON=$(tput smul);
S_ULOF=$(tput rmul);
S_ITON=$(tput sitm);
S_ITOF=$(tput ritm);
S_BOLD=$(tput bold);
S_FB=$(tput rmso); # FrontBack (default)
S_BF=$(tput smso); # BackFront (reverse)
S_RED=$(tput setaf 1);
S_GREEN=$(tput setaf 2);
S_YELLOW=$(tput setaf 3);
S_BLUE=$(tput setaf 4);
S_MAGENTA=$(tput setaf 5);
S_CYAN=$(tput setaf 6);
S_WHITE=$(tput setaf 7);
S_DIM=$(tput setaf 0);
S_RESET=$(tput sgr0);
S_STEP=${S_BOLD}${S_GREEN}'\n - ';
S_ListingHeaderOn=${S_BF}${S_WHITE}${S_BOLD};
S_ListingHeaderOf=${S_FB}${S_RESET};
S_CMDON=${S_RESET}${S_BOLD}${S_BLUE}"Running: "${S_ITON}${S_WHITE};
S_CMDOF=${S_RESET};
S_ifCurrentStyle=${S_GREEN};

# Variables that are set in runtime
currentRef=''; # Should be set by function 'git_loadCurrentRef'
S_ifCurrentON=''; # to be set in while loop
S_ifCurrentOF=''; # to be set in while loop

#################################### Welcome message
printf ${S_GREEN};
echo "============================== Git Repo Switcher ===============================";
echo "What this script does: "
echo " - cd GIT_REPO_PATH: (${repositoryPath})";
echo " - fetch updates from all remotes";
echo " - list remote (${remoteName}) refs (branches & tags) sorted (by ${listSortByField})";
echo " - checkout selected refname";
echo " - show git status";
echo "================================================================================";
printf ${S_RESET};

#################################### FUNCTIONS
function git_verifyGitVersion # SET 'currentRef' VAR
{
    version=$(git --version 2>/dev/null | grep -Po "^git version .*" | sed -E "s/git version //g");
    IFS='.' read majorVer minorVer extraVer <<< ${version};
    IFS='.' read majorVerReq minorVerReq extraVerReq <<< ${reqGitVer};
    majorDiff=$[majorVer-majorVerReq];
    minorDiff=$[minorVer-minorVerReq];
    if [ "$version" ]; then
        printf "Current git version: ${version}\n";
    else
        printf ${S_BF}${S_RED}"Git is not installed${S_RESET}\n";
    fi
    if [ "$version" ] && (( majorDiff > 0 || ( majorDiff == 0 && minorDiff >= 0 ) )); then
        printf ${S_GREEN}" >= ${reqGitVer}${S_RESET}\n"
        #printf ${S_YELLOW}"Press Enter to continue ..."${S_RESET};
        #read -s;
        echo ;
    else
        #printf ${S_RED}" < ${reqGitVer}\n"
        printf ${S_BF}${S_RED}"Required git version: ${reqGitVer} or later${S_FB}\n";
        printf ${S_YELLOW}"To install/upgrade git, run:${S_RESET}\n";
        printf "\tsudo add-apt-repository ppa:git-core/ppa;\n";
        printf "\tsudo apt-get update;\n";
        printf "\tsudo apt-get install --only-upgrade git;\n";
        read -s;
        exit 1;
    fi
}

function fixRepoPath
{
	cd "${repositoryPath}" &> /dev/nul;
	repositoryPath=${PWD}
	while [ ! -d "${repositoryPath}/.git" ]
	do
		resetRepoPath;
	done
	cd "${repositoryPath}";
}

function resetRepoPath
{
	if [ ! -d "${repositoryPath}/.git" ]; then
		printf ${S_BF}${S_RED}"\nRepository path can not be found:${S_RESET} ${repositoryPath}";
	fi
	printf ${S_YELLOW}"\nEnter the new repo-path: ${S_RESET}";
	read -e repositoryPath;
	if [ -d "${repositoryPath}/.git" ]; then
		cd "${repositoryPath}";
		printf ${S_GREEN}"Repo-path changed to: ${S_MAGENTA}${repositoryPath}${S_RESET}\n";
	else
		repositoryPath=${PWD}
		printf ${S_RED}"The entered path is not recognized as a git repo${S_RESET}\n";
	fi
}

function showConfigs
{
    printf "${S_STEP}Configuration variables:${S_RESET}\n";
	printf "%-18s %s\n" "repositoryPath" "= ${repositoryPath}";
	printf "%-18s %s\n" "checkoutParams" "= ${checkoutParams}";
	printf "%-18s %s\n" "checkoutRemotely" "= ${checkoutRemotely}";
	printf "%-18s %s\n" "listSortByField" "= ${listSortByField}  # -creatordate|refname (see man git for-each-ref)";
	printf "%-18s %s\n" "tmpFile" "= ${tmpFile}";
}

function git_loadCurrentRef # SET 'currentRef' VAR
{
    currentRef=$(git branch | grep -Po '^\*.*$' | sed -E "s/(\* |\(|\)|HEAD detached at |${remoteName}\/)//g");
}

function git_fetch
{
    cmd="git fetch --all --tags --progress;";
    printf "${S_STEP}Fetching updates: \n${S_CMDON}${cmd}${S_CMDOF}${S_RESET}\n";
    eval $cmd;
}

function git_status
{
    cmd="git status;";
    printf "${S_STEP}Status: \n${S_CMDON}${cmd}${S_CMDOF}${S_RESET}\n";
    #eval $cmd;
    git -c color.ui=false status;
	fixRepoPath;
}

function git_listRefs
{
    cmd="git branch --remote --ignore-case;  git tag --ignore-case;";
    printf "${S_STEP}Listing Branches & Tags (remote=${remoteName}):\n${S_CMDON}${cmd}${S_CMDOF}${S_RESET}\n";
    git for-each-ref --ignore-case --sort=${listSortByField} --format='%(refname:lstrip=1)|%(creatordate:iso)|%(if)%(taggername)%(then)%(taggername)%(else)%(authorname)%(end)|%(objectname:short)|%(subject)' |
        
        # To match tags & branches of only specified-remote
        grep -Po "^(tags/|remotes/${remoteName}/).*" |
        grep -Pv "(.+/HEAD.*)" |
        
        # To match any ref (tags & branches) except local branches (heads/*)
        #grep -Pv "^(heads.*|remotes/${remoteName}/HEAD)" |
        
        # Remove remotes/* from refname
        sed -e "s/\s*remotes\/${remoteName}\///g" >${tmpFile};
    eval ${rowHeader};
    grep -n "" ${tmpFile} |
        while IFS="|" read refname date author commitID commitMsg
        do 
            date=$(date --date="${date}" "+${dateFormat}")
            IFS=':' read num refname <<< ${refname}
            # Mark the currentRef
            if [[ "${currentRef}" == "${refname}" ||  ("${refname}" == "tags/"* && "${refname}" == *"${currentRef}") ]]; then
                #refname="* "${refname}; #${S_GREEN}${refname}${S_RESET};
                S_ifCurrentON=${S_ifCurrentStyle};
                S_ifCurrentOF=${S_RESET};
            else
                S_ifCurrentON='';
                S_ifCurrentOF='';
            fi
            # READY VARS: num refname date author commitID commitMsg
            eval ${rowListing};
        done
    eval ${rowHeader};
}

function askWhichRef
{
    IFS=" " read totalLines tmp <<< $(wc --lines ${tmpFile}); # get ${totalLines}
    
    # Resize terminal
    terminalRows=$[totalLines+5];
    printf "\e[8;${terminalRows};${colW_ALL}t";
    
    printf "${S_YELLOW}Checkout / switch to [1-${totalLines}]: ${S_RESET}";
    read -p "";
    selectedLineNum=$[$(echo ${REPLY} | sed 's/[^0-9]*//g')+0]; # get ${selectedLineNum} (extract num)
    if (( ${selectedLineNum} >= 1  &&  ${selectedLineNum} <= ${totalLines} )); then
        line=$(sed "${selectedLineNum}q;d" ${tmpFile});
        IFS='|' read refName date author <<< ${line};
        if [[ 1 == ${checkoutRemotely} && ! ${refName} =~ ^tags/ ]]; then
            refName=${remoteName}/${refName};
        fi
		cmd="git checkout ${refName} ${checkoutParams};";
        echo "Choosed refname: ${refName}";
        printf "${S_STEP}Checking out (${refName}):${S_RESET}\n";
        printf "${S_CMDON}${cmd}${S_CMDOF}${S_RESET}\n";
        eval ${cmd};
		git_loadCurrentRef;
    else
        echo "Skipping 'checkout': ${S_YELLOW}Selected refname (branch/tag) is unrecognized${S_RESET}";
    fi
}

function git_resetRemote
{
	git_loadCurrentRef;
	printf "${S_STEP}Resetting branch to remote (${remoteName}/${currentRef}):${S_RESET}\n";
	cmd="git reset --hard ${remoteName}/${currentRef};";# "git merge --ff-only;";
	printf "${S_CMDON}${cmd}${S_CMDOF}${S_RESET}\n";
	eval ${cmd};
}

#################################### IMPLEMENTATION
git_verifyGitVersion;
fixRepoPath;
# git_fetch;
# git_status;
# git_loadCurrentRef; # Sets variable: "currentRef"
# git_listRefs;
# askWhichRef;
# git_status;

while true
do
    printf "${S_BF}${S_STEP}Select action:${S_RESET}\n";
	echo "(1) ALL: Fetch + Status + List/CheckoutRef + Status";
	echo "(2) Fetch updates";
	echo "(3) Reset branches to remote";
	echo "(4) Show status";
	echo "(5) List/checkout remote ref/branch";
	echo "(6) Change repo-path: ${S_MAGENTA}${repositoryPath}${S_RESET}";
	echo "(7) Show script configurations";
	#echo "${S_YELLOW}0 - EXIT${S_RESET}";
    printf "${S_YELLOW}Select action [1-5] (0=Exit): ${S_RESET}";
	read;
    inputNum=$[$(echo ${REPLY} | sed 's/[^0-9]*//g')+0]; # get ${selectedLineNum} (extract num)
    if (( ${inputNum} >= 0  &&  ${inputNum} <= 7 )); then
		if (( ${inputNum} == 0 )); then
			break;
		elif (( ${inputNum} == 1 )); then
			git_fetch;
			git_status;
			git_loadCurrentRef; # Sets variable: "currentRef"
			git_listRefs;
			askWhichRef;
			git_status;
		elif (( ${inputNum} == 2 )); then
			git_fetch;
		elif (( ${inputNum} == 3 )); then
			git_resetRemote;
		elif (( ${inputNum} == 4 )); then
			git_status;
		elif (( ${inputNum} == 5 )); then
			git_loadCurrentRef; # Sets variable: "currentRef"
			git_listRefs;
			askWhichRef;
		elif (( ${inputNum} == 6 )); then
			resetRepoPath;
		elif (( ${inputNum} == 7 )); then
			showConfigs;
		fi
    else
        echo "Unrecognized choice selected";
    fi
done

#################################### END
echo ${S_GREEN}"================================================================================"${S_RESET};

#read -s;

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function gbin {
    OTHER=$1
    [[ $(grep "svn-remote" .git/config | wc -l) -eq 1 ]] && OTHER="remotes/git-svn"
    echo branch \($OTHER\) has these commits and \($(parse_git_branch)\) does not 
    git log ..$OTHER --no-merges --format='%h | Author:%an | Date:%ad | %s' --date=local
}

function gbout {
    OTHER=$1
    [[ $(grep "svn-remote" .git/config | wc -l) -eq 1 ]] && OTHER="remotes/git-svn"
    echo branch \($(parse_git_branch)\) has these commits and \($OTHER\) does not 
    git log $OTHER.. --no-merges --format='%h | Author:%an | Date:%ad | %s' --date=local
}

function gswitch {
    # like 'cd -' but for git branches...
    [[ $# -eq 1 ]] && TARGET=$1 || TARGET=${GIT_PREVIOUS_BRANCH:-master}
    CURRENT=$(parse_git_branch)
    [[ $TARGET = $CURRENT ]] && echo "$TARGET == $CURRENT" && return
    export GIT_PREVIOUS_BRANCH=$CURRENT
    git checkout $TARGET
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
X=$(which most 2> /dev/null)
[[ $? = 1 ]] && PAGER=less || PAGER=most
export PAGER
export EDITOR=vim

export JAVA_HOME=/usr/lib/jvm/default-java

alias tmux="TERM=xterm-256color tmux"

setopt appendhistory autocd nomatch
unsetopt beep notify
bindkey -e

# oh-my-zsh rebinds this to 'cd ..' which is daft
bindkey '\e.' insert-last-word
# it also enables history sharing between shells (which sucks in tmux!)
unsetopt share_history

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jrutherford/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#keychain ~/.ssh/id_dsa &>/dev/null
#. ~/.keychain/*-sh

# use rsync to resume partial scp transfers
alias scpr="rsync --partial --progress --rsh=ssh"

export PYTHONSTARTUP=/home/jrutherford/.pystartup

function setdsm() {
    # add the current directory and the parent directory to PYTHONPATH
    # sets DJANGO_SETTINGS_MODULE
    export PYTHONPATH=$PYTHONPATH:$PWD/..
    export PYTHONPATH=$PYTHONPATH:$PWD
    if [ -z "$1" ]; then
        x=${PWD/\/[^\/]*\/}
        export DJANGO_SETTINGS_MODULE=$x.settings
    else
        export DJANGO_SETTINGS_MODULE=$1
    fi

    echo "DJANGO_SETTINGS_MODULE set to $DJANGO_SETTINGS_MODULE"
}

export PYTHONPATH=$PYTHONPATH:~/python/libs

# virtualenv(wrapper) whatnot
export WORKON_HOME=~/src/envs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
export VIRTUALENVWRAPPER_LOG_DIR=$WORKON_HOME/log

# virtualenv(wrapper) whatnot. we override the mkvirtualenv & workon functions
# defined in virtualenvwrapper.sh because 99% of the time we don't need to run
# this crap when opening a shell.
function mkvirtualenv () {
    source /usr/local/bin/virtualenvwrapper.sh
    mkvirtualenv $@
}

function workon () {
    source /usr/local/bin/virtualenvwrapper.sh
    workon $@
}

if [[ $TMUX != "" ]]; then
    venv=$(tmux show-environment | grep VIRTUAL_ENV | cut -d "=" -f 2)
    if [[ $venv != "" ]] && [[ $(echo $venv | sed 's/^-.*/MATCH/') != "MATCH" ]]; then
        export VIRTUAL_ENV=$venv
        # we only do this if we're running inside a tmux session
        PROJ=$(echo $VIRTUAL_ENV | sed 's#.*/\(.*\)#\1#')
        workon $PROJ
        cd $(tmux show-options | grep default-path | sed 's/.*"\(.*\)"/\1/')
#        [[ $tmux_dir != "" ]] && cd $tmux_dir
    fi
fi

function cdv () {
    if (( $# == 0 ))
    then
        builtin cd $VIRTUAL_ENV
    else
        builtin cd "$@"
    fi
}

function import () {
    if (( $# > 0 ))
    then
        python -i -c "$0 $@"
    fi
}

function from () {
    if (( $# > 0 ))
    then
        python -i -c "$0 $@"
    fi
}

function attach() {
    if (( $# == 1 )); then
        tmux attach-session -t $1
    else
        echo "usage: attach <tmux session name>"
    fi
}

function tlist() {
    tmux list-sessions
}

function new_session() {
    create_session $@
    tmux attach-session -t$1
}

function create_session() {
    if (( $# >= 1 )); then
        SESSION_NAME=$1
        NUM_WINDOWS=${2:=0}
        tmux -2 new-session -d -s $SESSION_NAME -n zsh

        tmux set-option -t$SESSION_NAME default-path $(pwd)

        # these environment variables should be inherited into the session
        # being created, but blocked from entering into the global environment
        tmux set-environment -gr VIRTUAL_ENV
        tmux set-environment -gr PYTHONPATH
        tmux set-environment -gr DJANGO_SETTINGS_MODULE
        tmux set-environment -gr DJANGO_DEVELOPMENT

        if [[ -n $VIRTUAL_ENV ]]; then
            echo "setting VIRTUAL_ENV=$VIRTUAL_ENV"
            tmux set-environment -t$SESSION_NAME VIRTUAL_ENV $VIRTUAL_ENV
        else
            echo "un-setting VIRTUAL_ENV:"
            tmux set-environment -u VIRTUAL_ENV
            tmux set-environment -r VIRTUAL_ENV
        fi

        tmux set-environment -t$SESSION_NAME PYTHONPATH $PYTHONPATH
        tmux set-environment -t$SESSION_NAME DJANGO_SETTINGS_MODULE $DJANGO_SETTINGS_MODULE
        tmux set-environment -t$SESSION_NAME DJANGO_DEVELOPMENT $DJANGO_DEVELOPMENT

        for i in $(seq 1 $NUM_WINDOWS); do
            tmux new-window -t$SESSION_NAME:$i
        done

        tmux select-window -t$SESSION_NAME:0
    else
        echo "usage: new_session <tmux session name>"
    fi
}

function up() {
    if [ -d .svn ]; then
        svn up
    fi
    if [ -d .hg ]; then
        hg pull -u
    fi
    if [ -d .git ]; then
        # If this is a git-svn bridge repo, don't just pull
        [[ $(grep "svn-remote" .git/config | wc -l) -eq 1 ]] && git svn rebase || git pull
    fi
}

function st() {
    if [ -d .svn ]; then
        svn status
    fi
    if [ -d .hg ]; then
        hg status
    fi
    if [ -d .git ]; then
        git status
    fi
}

function conflicts() {
    svn st | grep ^C | cut -d " " -f 8
}

function scm_diff() {
    if [ -d .svn ]; then
        svn diff $@ | source-highlight --out-format=esc --src-lang=diff | $PAGER
    fi
    if [ -d .hg ]; then
        hg diff $@
    fi
    if [ -d .git ]; then
        git diff $@
    fi
}

alias vvim="vim -O"

alias vipython="python ~/src/ipython/ipython.py"

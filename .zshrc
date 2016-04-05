# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode git django pip python git_extras jimr django_extras ruby rvm)
#plugins=(jimr git ruby)

source $ZSH/oh-my-zsh.sh

# Don't autocomplete things starting with . or _ unless I say so!
CORRECT_IGNORE='[._]*'

unsetopt CORRECTALL

# Customize to your needs...

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#
#source $(rvm 2.1.1 do rvm env --path)
#
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [[ $(echo $HOME | cut -d '/' -f 2) = 'Users' ]]; then
    JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home/
    export JAVA_HOME
    export PATH=$PATH:$JAVA_HOME/bin

    export PATH=$PATH:/Users/jrutherford/Library/Python/2.7/bin

    source /Users/jrutherford/.iterm2_shell_integration.zsh
    export PATH=$PATH:/Applications/Postgres.app/Contents/MacOS/bin
fi

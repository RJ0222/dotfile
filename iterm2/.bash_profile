# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

function _completeSSHHosts {

	COMPREPLY=()
	local currentWord=${COMP_WORDS[COMP_CWORD]}

	local completeHosts=$(
		cat "$HOME/.ssh/config" | \
		grep --extended-regexp --regexp "^Host +[^* ]+? *$" | \
		tr -s " " | cut -d " " -f 2;
		cat /etc/hosts | \
		grep --extended-regexp --regexp "^[0-9]{3}\." | \
		awk "{print \$2}"
	)

	COMPREPLY=($(compgen -W "$completeHosts" -- "$currentWord"))
	return 0
}

complete -F _completeSSHHosts ssh

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enables colorin the terminal bash shell export
export CLICOLOR=1
# sets up thecolor scheme for list export
# export LSCOLORS=gxfxcxdxbxegedabagacad
# sets up theprompt color (currently a green similar to linux terminal)
export TERM=xterm-color

alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_TERMINAL_PROMPT=1
source ~/.git-prompt.sh
source ~/.git-completion.bash
if [ -n "$BASH_VERSION" ]; then
    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
fi

export GOPATH=~/Project/gopath
export GOBIN=$GOPATH/bin
export GOTRACEBACK=crash
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/Users/rockid/Scripts/bin/
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/Cellar/mysql@5.7/5.7.26/bin/:$PATH
export PATH="/usr/local/opt/node@10/bin:$PATH"
export PYTHON3PATH=/Users/rockid/Scripts/python/modules

eval "$(direnv hook bash)"
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

source <(helm completion bash)
source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.

export GO111MODULE=on
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export KUBECONFIG=~/.kube/staging-config:~/.kube/config:~/.kube/oa-config:~/.kube/enterprise-config:~/.kube/ide-staging-config:~/.kube/wuhaili-config:~/.kube/ide-prod-config

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="/Users/rockid/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME=''
# export BASH_IT_THEME='powerline-multiline'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)
# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
# export BASH_IT_THEME='atomic'
# export BASH_IT_USE_THEME=false
source "$BASH_IT"/bash_it.sh
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
# export BASH_IT_THEME='/Users/rockid/.bash_it/themes/powerline/powerline.base.bash'

# assets 𝘟 ✗ Ӽ 𝘟 𝞦 ✔ ✓ ▲ ➜
# Git status
check_status() {
red="$bold$(tput setaf 1)"
green=$(tput setaf 2)
boshka= git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' > /dev/null 2>&1
# Checks if something to commit or not
if git rev-parse --git-dir > /dev/null 2>&1; then
    if ! git status | grep "nothing to commit" > /dev/null 2>&1; then
        echo "${red} x "
        return 0
    elif $boshka; then
        echo "${green} ✓ "
    fi
fi

}


# Git branch
check_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS1 is similar to html tags but with color the tag starts like:
# \[\e[0;32m] bla bla \[\e[0m\] 0;32 is color green, space is \[$(tput sgr0)\], \W current dir

export PS1="\[\e[0;32m\]➜ \[\e[0m\]\[\$(check_status)\]"
       PS1+="\[$(tput sgr0)\]\[\e[1;34m\]\W\[\e[0m\]"
       PS1+="\[\e[0;36m\]\$(check_branch)\[\e[0m\]\n    \[$(tput sgr0)\]"
       PS1+="\[\e[0;33m\] ▲ =\[\e[0m\]\[$(tput sgr0)\]\[\e[1;37m\] "

export CLICOLOR=1
export LSCOLORS=fxfxBxDxgxegedabagacad
# some more ls aliases
LS_COLORS=$LS_COLORS:'di=0;35:'; export LS_COLORS
alias ls='ls -F -H -G --color=always'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export LC_ALL=en_US.UTF-8

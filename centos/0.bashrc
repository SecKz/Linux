# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias la='ls -A'
alias ll='ls -Alh'
alias lt='ls -tAlh'
alias l='ls -AFhlt'
alias lh='l | head'
alias ipl='iptables -nL'
alias vi=vim
alias py=python
alias py3=python3
alias ser=service

#GREP_OPTIONS="--color=auto"
#alias grep='grep --color'
#alias egrep='egrep --color'
#alias fgrep='fgrep --color'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export LANG=zh_CN.utf8
PS1="\[\e[01;31m\][\u@\h \W]#\[\e[m\]"
#TMOUT=7200

# Auto add env parameter $PROMPT_COMMAND when use non-Linux tty login by ssh.
if [ "$SSH_CONNECTION" != '' -a "$TERM" != 'linux' ]; then
	declare -a HOSTIP
	HOSTIP=`echo $SSH_CONNECTION |awk '{print $3}'`
	export PROMPT_COMMAND='echo -ne "\033]0;${USER}@$HOSTIP:[${HOSTNAME%%.*}]:${PWD/#$HOME/~} \007"'
fi


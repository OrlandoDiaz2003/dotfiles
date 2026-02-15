# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

#historial
export HISTSIZE=1000000
export HISTFILESIZE=2000000
export HISTTIMEFORMAT='%d-%m-%YT%H: %M:%S '

shopt -s histappend

#git completion
parse_git_branch() {
    git symbolic-ref --short HEAD 2>/dev/null
}

PS1='[\u@\h \W$(b=$(parse_git_branch); if [ -n "$b" ]; then printf ":\[\e[38;2;32;147;219m\]%s\[\e[0m\]" "$b"; fi)]$ '
export PATH
export PATH=$HOME/.local/scripts:$PATH
export PATH=$HOME/opt/node/bin:$PATH
export PATH=$HOME/opt/code/bin:$PATH
export PATH=$HOME/opt/lsp/clangd_21.1.0/bin:$PATH
export PATH=$HOME/software/gf:$PATH
export PATH=$HOME/software/lua-5.5.0/src:$PATH
export MANWIDTH=85

#alias
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias open="xdg-open ."
alias neofetch="fastfetch --config neofetch"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "$HOME/.cargo/env"

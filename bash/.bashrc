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

#PS1='\e[32m[\u@\h \w$(b=$(parse_git_branch); if [ -n "$b" ] \e[0m; then printf ":%s" "$b"; fi)]$ '
PS1='\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\] '

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

export PATH
export PATH=$HOME/.local/scripts:$PATH
export PATH=$HOME/opt/node/bin:$PATH
export PATH=$HOME/opt/code/bin:$PATH
export PATH=$HOME/opt/lsp/clangd_21.1.0/bin:$PATH
export PATH=$HOME/software/gf:$PATH
export PATH=$HOME/software/lua-5.5.0/src:$PATH
export PATH=$HOME/opt/gnucobol/bin:$PATH
export PATH=$HOME/opt/lazygit:$PATH
export PATH=$HOME/opt/lsp/jdt-language-server-latest/bin:$PATH

export MANWIDTH=85
export LESS="-X"

# export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=gruvbox-dark'"
export MANROFFOPT="-P-c"

# Colores estilo Gruvbox para `man` y `less`
export LESS_TERMCAP_mb=$'\e[1;31m'      # Inicio de parpadeo (Blink) -> Rojo Gruvbox
export LESS_TERMCAP_md=$'\e[1;36m'      # Inicio de negrita (Títulos/Comandos) -> Azul/Cian Gruvbox
export LESS_TERMCAP_me=$'\e[0m'         # Fin de modo (Reset)
export LESS_TERMCAP_se=$'\e[0m'         # Fin de modo Standout
export LESS_TERMCAP_so=$'\e[1;40;33m'   # Modo Standout (Barra de búsqueda/info) -> Fondo oscuro, texto Amarillo Gruvbox
export LESS_TERMCAP_ue=$'\e[0m'         # Fin de subrayado
export LESS_TERMCAP_us=$'\e[1;32m'      # Inicio de subrayado (Variables/Argumentos) -> Verde Gruvbox
export LESS_TERMCAP_mr=$'\e[7m'         # Modo inverso
export LESS_TERMCAP_mh=$'\e[2m'         # Modo tenue (Dim)
export MANPAGER='less'

#alias
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias vi='nvim'
alias vim='nvim'

alias code='codium'
alias slop='agy'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias rm='rm -I'
alias cp='cp -v'
alias mv='mv -v'

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

stty -ixon


# opencode
export PATH=/home/orlando/.opencode/bin:$PATH


# Added by Antigravity CLI installer
export PATH="/home/orlando/.local/bin:$PATH"

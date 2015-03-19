# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/marcos_sandim/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#shopt -s checkwinsize

VISUAL=vim

export VISUAL

# some more ls aliases

#alias la='ls -A'
alias l='ls -CF'
alias la="ls -lAF"

recursive_php_lint() {
    #do things with parameters like $1 such as
    find -L $1 -name '*.php' -print0 | xargs -0 -n 1 -P 4 php -l
}

alias run_acl='php application/modules/Acl/scripts/assets/acl.php'
alias run_acl_deploy='php application/modules/Acl/scripts/acl_deploy.php'
alias set_kbd_m='sudo setxkbmap -model 105-key -layout us -variant intl'
alias svnc="svn st --ignore-externals | grep ^[[:space:]C\!\~]"
alias svnnv='svn st --ignore-externals | grep "^?"'
alias svnm="svn st --ignore-externals | grep ^[[:space:]ACDIMR\!\~]"
alias svnst="svn st --ignore-externals"
alias svnup="svn up --ignore-externals"
alias svn_colordiff="svn diff | colordiff | less -R"
alias calc="sh /home/marcos_sandim/bashcalc.sh"
alias php_lint_r=recursive_php_lint

# unalias rm
setopt RM_STAR_SILENT

# zc () { for exp in $argv; do print "$exp = $(( exp ))"; done; }

bindkey '\e[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line


# Report CPU usage for commands running longer than 10 seconds
TIMEFMT=$'\n\treal\t%E\n\tuser:\t%U\n\tsys:\t%S'
REPORTTIME=5

#autoload -U add-zsh-hook
#source /home/marcos_sandim/Downloads/autotime.zsh/autotime.zsh

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats "(%{$fg[grey]%}%s %{$reset_color%}%r %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%})"
precmd() {
    vcs_info
}

setopt PROMPT_SUBST
PROMPT='%(!.%F{red}.%F{cyan})%n%f@%F{yellow}%m
    %f%~${vcs_info_msg_0_} %(!.%F{red}.%F{cyan})%#%f '

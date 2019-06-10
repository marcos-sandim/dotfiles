# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/marcos_sandim/.zshrc'

export TERM="xterm-256color"

setopt HIST_IGNORE_ALL_DUPS

export ZSH="/home/sandim/.oh-my-zsh"

#ZSH_THEME="powerline"
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(fzf docker thefuck)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit
compinit
# End of lines added by compinstall

#shopt -s checkwinsize

VISUAL=nvim

export VISUAL

# some more ls aliases

#alias la='ls -A'
alias l='ls -CF'
alias la="ls -lAF"

alias xopen='xdg-open'

recursive_php_lint() {
    #do things with parameters like $1 such as
    # find -L $1 -name '*.php' -not -path './vendor/*' -print0 | xargs -0 -n 1 -P 4 php -l
    docker run --rm -ti --name composer -v $(pwd):/app composer bash -c "find -L /app -name '*.php' -not -path '/app/vendor/*' -print0 | xargs -0 -n 1 -P 4 -I{} php -l {}"
}

phan() {
    docker run -v $(pwd):/mnt/src --rm -u "$(id -u):$(id -g)" cloudflare/phan:latest $@; return $?;
}

#docker run -d -v $(pwd):/src -w /src --name pg_client postgres:9.5-alpine psql
#docker run -it --rm --network="bridge" jbergknoff/postgresql-client postgresql://arquivei:q1w2e3@172.17.0.3:5432/arquivei
#docker run -it --rm --network="bridge" -e "PGPASSWORD=q1w2e3" jbergknoff/postgresql-client -U arquivei -h 172.17.0.3 -p 5432 -d arquivei
#psql() {
#    docker run -v $(pwd):/src -w /src pg_client psql $@; return $?;
#}


alias run_acl='php application/modules/Acl/scripts/assets/acl.php'
alias run_acl_deploy='php application/modules/Acl/scripts/acl_deploy.php'
alias set_kbd_m='sudo setxkbmap -model 105-key -layout us -variant intl'
alias svnc="svn st --ignore-externals | grep '^[[:space:]C\!\~]'"
alias svnnv='svn st --ignore-externals | grep "^?"'
alias svnm="svn st --ignore-externals | grep '^[[:space:]ACDIMR\!\~]'"
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
zstyle ':vcs_info:*' disable-patterns "${(b)HOME}/repos/(Particle_Resampling|BPart)(|/*)"
#zstyle ':vcs_info:*' formats "(%{$fg[grey]%}%s %{$reset_color%}%r %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%})"
#precmd() {
#    vcs_info
#}

zstyle ':notify:*' error-icon "$HOME/200_s.gif"
zstyle ':notify:*' error-title "wow such #fail"
zstyle ':notify:*' success-icon "$HOME/b55a1805f5650495a74202279036ecd2.jpg"
zstyle ':notify:*' success-title "very #success. wow"

#setopt PROMPT_SUBST
#PROMPT='%(!.%F{red}.%F{cyan})%n%f@%F{yellow}%m
#    %f%~${vcs_info_msg_0_} %(!.%F{red}.%F{cyan})%#%f '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH="$HOME/repos/rgit/bin:$PATH"
export PATH

eval $(thefuck --alias)

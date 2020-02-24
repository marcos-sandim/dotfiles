# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ?????
autoload -Uz compinit
compinit
export TERM="xterm-256color"

# VI-mode
bindkey -v

# 10ms for key sequences
KEYTIMEOUT=1

# History settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# Powerlevel10k
zinit ice depth=1;
zinit light romkatv/powerlevel10k

# To customize prompt, run `\` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Kubectl
source <(kubectl completion zsh)
alias k=kubectl
#complete -F __start_kubectl k

# FZF
#zinit ice wait'!0'
zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh


# Editor
VISUAL='subl --wait'
EDITOR=editor
export VISUAL EDITOR

# Aliases
#alias la='ls -A'
alias ls='exa'
alias l='ls -CF'
alias la="ls -la"
alias xopen='xdg-open'
alias please='sudo'
alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
#alias kc='kubectl'
alias nvipe='vipe > /dev/null'
alias cd='cd -P'
alias mux='tmuxinator'

alias pacinstall="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias yayinstall="yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S"

# Functions
docker_logs_jq() {
    docker logs -f $@ | jq --unbuffered -R 'fromjson? | select(type == "object")'
}

# Auto pushd
setopt auto_pushd

# keybindings
bindkey "^?" backward-delete-char

## Sdkman
#export SDKMAN_DIR="/home/sandim/.sdkman"
#[[ -s "/home/sandim/.sdkman/bin/sdkman-init.sh" ]] && source "/home/sandim/.sdkman/bin/sdkman-init.sh"

# asdf-vm
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

export PATH="$HOME/.dynamic-colors/bin:$PATH"
source $HOME/.dynamic-colors/completions/dynamic-colors.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/mnt/storage/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/mnt/storage/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/mnt/storage/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/mnt/storage/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

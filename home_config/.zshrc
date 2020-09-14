autoload -Uz compinit promptinit
compinit
promptinit

autoload select-word-style
select-word-style bash
WORDCHARS="*?_-/.[]~=&;!#$%^(){}<>"

# load my functions and extra completions
fpath=(
    ~/.zshfunc
    /usr/local/share/zsh-completions
    $fpath
)

# run fortune!
fortune -e

# avoid the need to manually reset a terminal
ttyctl -f

# set keybinds to emacs
bindkey -e

# add reverse tab
bindkey '^[[Z' reverse-menu-complete

# history search filtered by what is already written
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# history setup
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zhistory
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don\'t record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don\'t record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don\'t write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don\'t execute immediately upon history expansion.
setopt MENU_COMPLETE             # Autocomplete options

bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# setup prompt
autoload -Uz colors && colors
unalias run-help || true
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# Autocd helps get you into your must usual paths very fast!
setopt auto_cd
cdpath=($HOME/Work/OneReceipt)

# load my functions
autoload -Uz tomas_smaller_cmds
tomas_smaller_cmds

function precmd() {
    autoload -Uz tomas_prompt
    tomas_prompt
    virtual_env_prompt
    docker_prompt
    git_prompt
    kube_prompt
    PS1="${env}${docker_name}${kctx}${git_prompt}%{$reset_color%}%{$fg[blue]%}$%{$reset_color%} "
    RPROMPT="%{$fg[blue]%}[%{$reset_color%}%~%{$fg[blue]%}]%{$reset_color%}"
}

setopt promptsubst

# remember most recent folders used
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection

# alisases
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv -p /usr/local/bin/python2.7'
alias v.mk3='mkvirtualenv -p /usr/local/bin/python3.7'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'
alias docker-wizzy='docker exec -it wizzy bash -l'
alias or="cd ~/Work/ORE/projects/OneReceipt/onereceipt"
alias em="cd ~/Work/EmailMeter/docker-env/src/emailmeter && clear"
alias cb="cd ~/Work/EmailMeter/docker-env/src/emailmeter/enterprise/client-backend && clear"
alias hsk="cd ~/Websites/hassek.github.io"
alias cc="cd ~/Work/ORE/projects/CC-DevOps && clear"
alias hp="cd ~/Work/ORE/projects/Helpify && clear"
alias ddp="cd ~/Work/DevOps-Deployment && clear"
alias cce="cd ~/Work/capture_proxy/ && clear"
alias ms="cd ~/Websites/MSeeker/ && clear"
alias mr="cd ~/Websites/MapRoute/ && clear"
alias sk="cd ~/Websites/SokobanSolver/ && clear"
alias icb="cd ~/Work/ICB-common/ && clear"
alias bgu="cd ~/Work/BlackGull/ && clear"
alias ge="cd ~/Work/ORE/projects/GEngine && clear"
alias ep="cd ~/Work/EmailPreference && clear"
alias gsize="du -cmh -d 1 | sort -n"
alias dm="/usr/local/bin/docker-machine"
alias dcc="/usr/bin/dc"
alias dc="/usr/local/bin/docker-compose"
# alias grep="echo '$fg[red]Use rg sapo teton$fg[red]' && /usr/local/bin/rg"
alias ll='ls -alF'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias k='kubectl'
alias cc-awsokta='eval "$(aws-okta-rakuten env commerce-capture-qa --session-ttl=8h0m0s)"'
alias ss-awsokta='eval "$(aws-okta-rakuten env support-nonprod --session-ttl=1h0m0s)"'
alias ss-prod-awsokta='eval "$(aws-okta-rakuten env support-prod --session-ttl=1h0m0s)"'
alias eb-awsokta='eval "$(aws-okta-rakuten env ebates-nonprod --session-ttl=8h0m0s)"'
alias rrssh='sshpass -e ssh '
alias ssb='sshpass -f ~/.sshpassbastion ssh engbastion01.support.rr.local'
alias kubectx='kubectl config use-context $(kubectl config get-contexts -o=name | sort -n | fzf)'
alias kubens='kubectl config set-context $(kubectl config current-context) --namespace=$(kubectl get namespaces -o=jsonpath='"'"'{range .items[*].metadata.name}{@}{"\n"}{end}'"'"' | fzf)'

# keybinds
fuzzy_git_branch_widget() fuzzy_git_branch
zle -N fuzzy_git_branch_widget
bindkey '\eg' fuzzy_git_branch_widget

# Attach to remote tmux session automatically
# if [[ -n "$SSH_CONNECTION" ]]; then
#     tmux attach || tmux new -s tomtom-playground
# fi

# Always set at end of file
# syntax highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/opt/chruby/share/chruby/chruby.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins

eval "$(direnv hook zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
if [ /usr/local/bin/kompose ]; then source <(kompose completion zsh); fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

export CLOUDSDK_PYTHON=python3

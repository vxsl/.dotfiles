# PLUGINS --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# things that conflict with zsh-vi-mode
function zvm_after_init() {
    # allow ctrl space autosuggest accept with zsh-vi-mode
    zvm_bindkey viins '^@' autosuggest-accept
    
    # FZF
    # git clone https://github.com/junegunn/fzf/ ~/.zsh/fzf
    export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -f -g \"\""
    source ~/.zsh/fzf/shell/key-bindings.zsh
    source ~/.zsh/fzf/shell/completion.zsh
}

# NOTE: install autojump-zsh from system pkg manager
# NOTE: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k


# use antigen
source ~/.zsh/antigen.zsh

# p10k
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

ZSH_SYSTEM_CLIPBOARD_METHOD=tmux

# wakatime
antigen bundle unixorn/fzf-zsh-plugin@main
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle kutsan/zsh-system-clipboard
antigen apply

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt INC_APPEND_HISTORY

# INITIAL SETUP --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Custom Variables
EDITOR=nvim

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept

# Load aliases and shortcuts if existent.
[ -f "$HOME/zsh/aliasrc" ] && source "$HOME/zsh/aliasrc"


# typical ctrl-arrow behaviour
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# 10ms for key sequences
KEYTIMEOUT=1

# ALIASES --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

unsetopt nomatch

function nvgcm() {
    local msg="$*"
    git commit --message="$msg" --no-verify
}
function gcm() {
    local msg="$*"
    git commit --message="$msg"
}

source $HOME/bin/personal/dr.zsh

alias ls="lsd --icon never"
alias copy="xclip -selection clipboard"
alias dnf="sudo dnf"
alias pacman="sudo pacman"
alias mv="mv -vn"
alias remobar="killall -9 xmobar; xmobar-top &; xmobar-main &"
alias ls='ls --color=auto'
alias lsr="ls -ltr"
alias lsar="ls -latr"
alias fn="sudo find . -name"
alias itig="dof"
alias ir="dof r"
alias r="dof r"
alias ita="dof a"
alias ta="dof a"
alias it="dof"
alias t="dof"
alias s="dof s"
alias y="dof y"
alias m="dof"
alias gca="git commit --amend"
alias grc="git rebase --con"
alias gsp="git stash pop"
alias gsk="git stash -uk"
alias gs="git stash"
alias gr="git reset --hard @{u}"
alias gds="git-branch-status"
alias reword="git commit --amend --no-verify"
# alias l="lazygit"
alias gfpa="git fetch --prune; git fetch --all"
alias gfmm="git fetch origin master:master"
alias gfpamm="git fetch --prune; git fetch --all; gfmm"
alias grmm="gfpa; gfmm; git rebase master"
alias soft="git reset --soft HEAD~1; git reset;"
alias swip="git add -A; wip;"
alias pull="git pull"
alias push="git push"
alias gcb="git checkout -b"
alias gra="git rebase --abort"
alias gcpc="git cherry-pick --continue"
alias gcpa="git cherry-pick --abort"
alias wip="git commit -m \"wip --no-verify\" --no-verify"

alias LOWER="setxkbmap -option ctrl:nocaps && xcape -e '#66=Escape"
alias lower="setxkbmap -option ctrl:nocaps && xcape -e '#66=Escape"

alias lzd="lazydocker"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if [ -d "$HOME/.zsh/powerlevel10k" && ! -f "$HOME/.zsh/powerlevel10k/.env" ]; then
    cat <<EOF > $HOME/.zsh/powerlevel10k/.env
P10K_WIZARD_CHOICE_STYLE=4
P10K_WIZARD_CHOICE_COLOR_SCHEME=2
P10K_WIZARD_CHOICE_NON_PERMANENT_CONTENT_LOCATION=2
P10K_WIZARD_CHOICE_TIME=2
P10K_WIZARD_CHOICE_HEIGHT=1
P10K_WIZARD_CHOICE_SPACING=1
P10K_WIZARD_CHOICE_TRANSIENT=y
P10K_WIZARD_CHOICE_INSTANT_PROMPT_MODE=1
EOF
fi

source $HOME/.zsh/autojump/bin/autojump.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -f "$HOME/.p10k.zsh" ]; then
    source "$HOME/.p10k.zsh"
else
    p10k configure
fi


# Load Angular CLI autocompletion.
# source <(ng completion script)

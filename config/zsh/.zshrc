export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="dst" # set by `omz`

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

clipimg() {
  if [[ -f "$1" ]]; then
    xclip -selection clipboard -t image/png -i "$1"
    echo "Image copied to clipboard: $1"
  else
    echo "File not found: $1"
  fi
}

updatesystem() {
  echo -e "\nUpdating the system..."
  sudo pacman -Syu --noconfirm
}

alias ls="eza --hyperlink --group-directories-first"
alias ll="eza --long --all --hyperlink --group-directories-first --bytes --git --time-style='+%d %B %Y, %I:%M %p'"
alias ld="ls --only-dirs"
alias lf="ls --only-files"
alias lt="ls --tree --git-ignore"
alias cat="bat --paging=never --style=plain --theme=ansi"
alias more="bat --paging=always --theme=ansi"
alias grep="rg"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vim="nvim"
alias neofetch="clear;~/Documents/scripts/fetch"
alias cleanram="clear;~/Documents/scripts/cache-clean"

# fnm
FNM_PATH="/home/soiderino/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/soiderino/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

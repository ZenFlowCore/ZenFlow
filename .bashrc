#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
alias rofi='rofi -show drun &'
alias hy='nvim ~/.dotfiles/.config/hypr/hyprland.conf'
alias brc='nvim ~/.dotfiles/.bashrc'
alias ky='nvim ~/.config/kitty/kitty.conf'
alias nmce='nm-connection-editor'
alias pm='sudo pacman -S'
alias obby='OBSIDIAN_USE_WAYLAND=1 obsidian -enable-features=UseOzonePlatform -ozone-platform=wayland'
alias c='clear'
alias v='nvim'
alias kill_all='pkill -f tmux'
alias ks='tmux kill-session'

PS1='[\u@\h \W]\$ '

#Exports
export starship_config="$home/.dotfiles/.config/starship/starship.toml"
export obsidian_use_wayland=1
export path=$home/.local/bin:$path

#TMUX
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

#keep_prompt_at_bottom() { 
#  echo -ne "\033[999;1H"
#}

#PROMPT_COMMAND='keep_prompt_at_bottom'
#PS1='\u@\h \W \$'

#Evaluations

eval "$(zoxide init bash)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH=$PATH:/home/zen/.spicetify

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

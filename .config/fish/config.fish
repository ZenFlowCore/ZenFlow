if status is-interactive
    # Commands to run in interactive sessions can go here
    # fastfetch, arise to nothing.
end
oh-my-posh init fish --config /home/zenflow/ZenFlow/.config/ompsh/theme.toml | source
  # starship init fish | source
zoxide init fish | source
/home/linuxbrew/.linuxbrew/bin/brew shellenv | source

set -x QS_NO_RELOAD_POPUP 1
export obsidian_use_wayland=1
export PATH="$PATH:/home/zenflow/.spicetify"
export PATH="$PATH:/usr/lib/qt6/bin"
export PATH="$PATH:/home/zenflow/.local/bin"
function fish_greeting                                          
    # arise, to nothing.
end

abbr --add c clear
abbr --add clr clear
abbr --add ff fastfetch
abbr --add vf nvim ~/dotfiles/.config/fish/config.fish
abbr --add v nvim
abbr --add pac sudo pacman -S 
abbr --add matuconf nvim ~/dotfiles/.config/Ax-Shell/config/matugen/config.toml
abbr --add ky nvim ~/dotfiles/.config/kitty/kitty.conf
abbr --add hy nvim ~/dotfiles/.config/hypr/hyprland.conf
abbr --add ls exa --oneline --reverse --sort=type
abbr --add zenb flatpak run app.zen_browser.zen

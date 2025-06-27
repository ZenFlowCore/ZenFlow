# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu


$env.EDITOR = 'nvim'
$env.config.show_banner = false

let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}
source ~/.zoxide.nu
# source ~/.oh-my-posh.nu

source ~/starship.nu

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}
let multiple_completers = {|spans|
    match $spans.0 {
	__zoxide_z => $zoxide_completer
    __zoxide_zi => $zoxide_completer
    } | do $in $spans
}

# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

let abbreviations = {
    "cd..": 'cd ..'
    syu: 'sudo pacman -Syu'
    ls: 'ls -a | sort-by type size'
    v: 'nvim'
    hy: 'nvim /home/zen/dotfiles/.config/hypr/hyprland.conf'
    ky: 'nvim /home/zen/dotfiles/.config/kitty/kitty.conf'
    vifish: 'nvim /home/zen/dotfiles/.config/fish/config.fish'
    cn: 'config nu'
    

}

$env.config = {
    keybindings: [
      {
            name: delete_one_word_backward
            modifier: control
            keycode: backspace
            mode: [emacs, vi_normal, vi_insert]
            event: {edit: backspaceword}
      }

      {
        name: abbr_menu
        modifier: none
        keycode: enter
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { send: menu name: abbr_menu }
            { send: enter }
        ]
      }
      {
        name: abbr_menu
        modifier: none
        keycode: space
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { send: menu name: abbr_menu }
            { edit: insertchar value: ' '}
        ]
      }
    ]

    menus: [
        {
            name: abbr_menu
            only_buffer_difference: false
            marker: none
            type: {
                layout: columnar
                columns: 1
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
            source: { |buffer, position|
                let match = $abbreviations | columns | where $it == $buffer
                if ($match | is-empty) {
                    { value: $buffer }
                } else {
                    { value: ($abbreviations | get $match.0) }
                }
            }
        }
    ]
}

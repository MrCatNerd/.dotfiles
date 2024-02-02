# ' will not expand, " will expand
# vi is already vim for some reason

# jokes:
alias dog='cat'
alias meow='echo meow # $*'

alias explorer='xdg-open'
alias vim='nvim'
alias gitree='git log --graph --pretty=oneline --abbrev-commit'
alias gits='git status'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias say='spd-say -p 10 -r -10 -R 50 $*'
alias show_screenkeys="screenkey -s large --scr 1 -p bottom --geometry 510x300+1412+850"
alias tls='tmux ls'
alias vg='valgrind --leak-check=full --show-reachable=yes --track-origins=yes'

f() { # ik its not an alias
    # Define the directory to search in
    local search_dir=${1:-$HOME}

    # Use find and fzf to select a directory
    local selected_dir=$(find "$search_dir" -type d 2>/dev/null | fzf)

    # Change directory if a selection was made
    if [ -n "$selected_dir" ]; then
        cd "$selected_dir"
    fi
}



# setup brew
eval $(/opt/homebrew/bin/brew shellenv)

# colors
RED="\[\033[1;31m\]"
GRE="\[\033[1;32m\]"
YEL="\[\033[1;33m\]"
BLU="\[\033[1;34m\]"
MAG="\[\033[1;35m\]"
CYA="\[\033[1;36m\]"
WHI="\[\033[1;37m\]"
GRE="\[\033[1;38m\]"
DEF="\[\033[22;39m\]"

# prompts
PS1="${MAG}\u${CYA}@\h:\w$DEF $ "
PS2="> "

# settings
shopt -s extglob
export BASH_SILENCE_DEPRECATION_WARNING=1

# bindings
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete on'
bind 'TAB:menu-complete'

# aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -G'
alias grep='grep --color=auto'

# functions
calc() {
    echo "scale=3;$@" | bc -l
}

extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz|zst)))))
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *.zst) c=(unzstd);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e"
}

# startup
neofetch

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

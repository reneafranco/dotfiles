
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$PATH:/usr/bin/"
if [ -z "${DISPLAY}" ] && [ "$(tty)" = /dev/tty1 ]; then
    exec startx
fi

[[ -s "$home/.dotfiles/sdkman/bin/sdkman-init.sh" ]] && source "/home/datedmedusa/.dotfiles/sdkman/bin/sdkman-init.sh"



# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$PATH:/usr/bin/"
if [ -z "${DISPLAY}" ] && [ "$(tty)" = /dev/tty1 ]; then
    exec startx
fi

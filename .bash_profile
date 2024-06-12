
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ -z "${XDG_SESSION_DESKTOP}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$PATH:/usr/bin:/usr/sbin
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
PROMPT='%n@%m:%~%# '


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias setup_dotfiles="$HOME/.dotfiles/setup_dotfiles.sh"
alias generate_installed_programs="$HOME/.dotfiles/generate_installed_programs.sh"

[[ -s "$HOME/.config/sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.config/sdkman/bin/sdkman-init.sh"


#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

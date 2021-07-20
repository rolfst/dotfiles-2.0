# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTSIZE=1000
SAVEHIST=1000

# Start configuration by Zim install {{{

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# prompt for spelling correction of commands.
setopt CORRECT
# customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# remove path separator from WORDCHARS.
WORDCHARS=${WORDDCHARS//[\/]}

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rolfst/.zshrc'


###################
# Completions
###################
source $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)




####
# Zinit
####
#if [[ ! -f $XDG_CONFIG_HOME/zinit/bin/zinit.sh ]]; then
#	print -p "%F{33} %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)...%f"
#	command mkdir -p $XDG_CONFIG_HOME/zinit
#	command git clone https://github.com/zdharma/zinit $XDG_CONFIG_HOME/zinit/bin && \
#		print -P "%F{33}   %F{34} Instalation Successful. %F" || \
#		print -P "%G{160}  The cloning has failed.%F"
#fi
source "$XDG_CONFIG_HOME/zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

####
# Theme
####
zinit ice depth -1; zinit light romkatv/powerlevel10k

#####
# Plugins
#####
# SSH-agent
zinit light bobsoppe/zsh-ssh-agent
# Autosuggestions
ZSH_ATOSUGGEST_BUFFER_MAX_SIZE=20
zinit ice wait"0a" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
# Enhancd
zinit ice wait"0b" lucid
zinit light b4b4r07/enhancd
# History searching
zinit ice wwait"0b" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# Tab completions
zinit ice wair"0b" lucid blockf
zinit light zsh-users/zsh-completions
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling activ: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:complete:*:options' sort false
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# FZF
zinit ice from"gh-r" as"command"
zinit light junegunn/fzf
# Bind multiple widgets using  FZF
zinit ice lucid wait'0c' multiscr"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf
# FZF-tab
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab
# Syntax Highlighting
zinit ice wait"0c" lucid atinit"zpcompinit;zpcdreplay"
zinit light zdharma/fast-syntax-highlighting
# EXA
zinit ice wait"2" lucid from"gh-r" as"program" mv"bin/exa* -> exa"
zinit light ogham/exa
zinit ice wait blockf atpull'zinit creinstall -q .'
# Bat
zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
zinit light sharkdp/bat
# Bat-extras
zinit ice wait"1" as"program" pick"src/batgrep.sh" lucid
zinit ice wait"1" as"program" pick"src/batdiff.sh" lucid
zinit light eth-p/bat-extras
alias rg=batgrep.sh
alias bd=batdiff.sh
alias man=batman.sh
# Ripgrep
zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep
# Forgit
#zinit ice wait lucid
#zinit load 'wfxr/forgit'
# LazyGit
#zinit ice lucid wait"0" as"program" from"gh-r" mv"lazygit* -> lazygit" atload"alias lg='lazygit'"
#zinit light 'jesseduffield/lazygit'
# LazyDocker
#zinit ice lucid wait"0" as"program" from"gh-r" mv"lazydocker* -> lazydocker" atload"alias lg='lazydocker'"
#zinit light 'jesseduffield/lazydocker'
# TMUXINATOR
#zinit ice as"completion"; zinit snippet ~/.nubem_dot_files/extras/tmuxinator/tmuxinator.zsh


##########################
# SETOPT
##########################
setopt extended_history		# record timestamp of command in histfile
setopt hist_expire_dups_first	# delete duplicates first when HISTFILE size ecxeeds HISTSIZE
setopt hist_ignore_all_dups	# ignore duplicated commands history list
setopt hist_ignore_space	# ignore commands that start with a space
setopt hist_verify		# show command with history expansion to user before running it
setopt inc_append_history	# add commands hto histfile in order of execution
setopt share_history		# share command history data
setopt always_to_end		# cursor moved to the end in full completion
setopt hash_list_all		# has everything before completion
#setopt completealiases		# complete aliases
setopt complete_in_word		# allow completion from with a word/phrase
setopt nocorrect		# spelling correction for commands
setopt list_ambiguous		#complete as much of a completion until it gets ambiguous
setopt nolisttypes
setopt listpacked
setopt automenu
unsetopt BEEP
setopt vi

chpwd() exa --git --icons --classify -group-directories-first --time-style=long-iso --group --color-scale

######################
# ENV VARIABLES
######################

export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export SHELL='/bin/zsh'


######################
# ALIASED
######################

source $XDG_CONFIG_HOME/aliases

######################
# FANCY CTRL-Z
######################
function fg-fzf() {
	job="$(jobs | fzf -0 -1 | sed -E 's/\[(.+)\].*/\1/')" && echo '' && fg %$job
}

function fancy-ctrl-z() {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER=" gf-fzf"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

######################
# FZF settings
######################
export FZF_DEFAULT_OPTS="
 --ansi
 --layout=default
 --info=inline
 --height=50%
 --multi
 --preview-window=right:50%
 --preview-window=sharp
 --preview-window=cycle
 --preview '([[ -f {} ]] && (bat --style=numbers --color=always --theme=gruvbox-dark --line-range :500 {} || cat {})) ||([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
 --prompt='@ -> '
 --pointer='|>'
 --marker='v'
 --bind 'ctrl-e:execute(nvim {} < /dev/tty > /dev/tty 2>&1)' > selected
 --bind 'ctrl-v: execute(code {+})'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

######################
# PATH
######################
export PATH=$PATH:/$HOME/.local/bin:$HOME/bin


######################
# P10K Settings
######################

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

autoload -Uz compinit
compinit
# End of lines added by compinstall

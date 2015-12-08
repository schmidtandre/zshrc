export PROMPT=$'%{\e[0;32m%}%n@%m(%!):%(4c,./%1~,%~)%?%{\e[0;0m%}$ '
export HISTFILE=~/.zsh_history
export HISTSIZE=5000
export SAVEHIST=5000
alias irb='irb1.8 --readline -r irb/completion'
alias ls='ls --color'
alias ll='ls -laF --color'
alias l='ls -ltraF --color'
alias x='xinit -- /usr/bin/X -nolisten tcp & logout'
alias xn='xinit -- /usr/bin/X -nolisten tcp'
alias xg='xinit ~/.xinitrc_games -- /usr/bin/X -nolisten tcp'
alias ..='cd ..'
alias ...='cd ..;cd ..'
alias dt='dmesg|tail'
alias spdf='sudo -u xpdf -H xpdf'
alias n9='ssh root@10.0.0.1'
alias n900='ssh root@10.0.0.1'

setopt  brace_ccl inc_append_history hist_ignore_space \
	hist_no_functions hist_ignore_all_dups hist_expire_dups_first \
	no_hup no_check_jobs autocd  autolist autopushd autoresume \
	cdablevars extendedglob globdots longlistjobs notify \
	pushdminus pushdsilent pushdtohome rcquotes recexact \
	sunkeyboardhack

unsetopt bgnice autoparamslash cdablevars

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored #_approximate

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose no #yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host
# completion
zstyle ':completion:*:processes' command 'ps x -o pid,nice,pcpu,tt,args'

# Hosts to use for completion (see later zstyle)
zstyle '*' hosts \
    haddock bereboot marsupilami xs4all \
    jochem surrounder blokkie localhost

# Filename suffixes to ignore during completion (except after rm
# command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
    '*?.o' '*~' '*?.orig'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

case $TERM in
	screen*)
		preexec() {
			print -Pn "\033k$(echo $1|cut -d" " -f1)\033\134"
			}
		precmd() {
			print -Pn "\033k$(basename $SHELL)\033\134"
			}
	;;
	xterm*)
	         precmd(){
		 	print -Pn "\033]0;${USER}@${HOST}: ${PWD}\007"
			}
         ;;
esac
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

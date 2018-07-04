source ~/.keys/keys.sh

# aliases
alias ls="exa --group-directories-first"
alias ll="ls -l"
alias hs='history | grep'
alias track="while true; do thyme track -o thyme.json; sleep 10s; done;"
alias gitlog="git log --graph --abbrev-commit --color --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias cdback="cd $OLDPWD"

# directories
alias quoine="cd $HOME/src/quoine/ && cd"
alias ml="cd $HOME/src/machine-learning/ && cd"

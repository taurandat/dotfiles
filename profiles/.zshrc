export ZSH=/Users/dat/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/frameworks/anaconda/bin:$PATH"

source ~/.scripts/competitive-programming.sh
source ~/.scripts/utils.sh
source ~/.scripts/crypto.sh

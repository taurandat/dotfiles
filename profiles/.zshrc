export ZSH=/Users/dat/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git)

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

source $ZSH/oh-my-zsh.sh

source ~/.keys/keys.sh

source ~/.scripts/aliases.sh
source ~/.scripts/competitive-programming.sh
source ~/.scripts/crypto.sh
source ~/.scripts/gits.sh
source ~/.scripts/utils.sh
source ~/.scripts/paths.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/dat/.sdkman"
[[ -s "/Users/dat/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/dat/.sdkman/bin/sdkman-init.sh"

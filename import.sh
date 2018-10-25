mkdir -p profiles
cp $HOME/.zshrc            profiles
cp -r $HOME/.scripts       profiles
cp -r $HOME/.keys          profiles
cp $HOME/.gitconfig        profiles
cp $HOME/.gitignore_global profiles

mkdir -p ssh
cp -a $HOME/.ssh/. ssh

mkdir -p emacs
cp $HOME/.spacemacs ./emacs/

mkdir -p karabiner
cp -r $HOME/.config/karabiner ./karabiner

mkdir -p whitefox
cp HOME/whitefox/*.json whitefox

gpg --export-secret-key -a $GPG_UID > gpg/gpg.key

mkdir -p profiles
cp $HOME/.zshrc      profiles
cp -r $HOME/.scripts profiles
cp -r $HOME/.keys    profiles
cp -r $HOME/.ssh     ssh

mkdir -p emacs
cp $HOME/.spacemacs ./emacs/

mkdir -p karabiner
cp -r $HOME/.config/karabiner ./karabiner

gpg --export-secret-key -a $GPG_UID > gpg/gpg.key

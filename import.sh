if (( $# < 1 )); then
    echo "Usage: ./update.sh commit_message"
fi

mkdir -p profiles
cp $HOME/.zshrc      ./profiles
cp $HOME/.zshenv     ./profiles
cp -r $HOME/.scripts ./profiles

mkdir -p emacs
cp $HOME/.spacemacs ./emacs/

mkdir -p karabiner
cp -r $HOME/.config/karabiner ./karabiner

git add -A
git commit -m "$1"

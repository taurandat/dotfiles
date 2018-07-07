export BETTER_EXCEPTIONS=1

bold=$(tput bold)
normal=$(tput sgr0)

red='\033[0;31m'
no_color='\033[0m'

long_separator() {
    python -c "print('_' * 40)"
    python -c "print(' ' * 40)"
}

all2pdf() {
    find . -type f -name "*.ps" -execdir ps2pdf {} \; -execdir rm {} \;
    find . -type f -name "*.djvu" -execdir djvu2pdf {} \; -execdir rm {} \;
}

pdf2text() {
    python ~/.scripts/pdf2text.py "$@"
}

zsh_reload() {
    source ~/.zshrc
}

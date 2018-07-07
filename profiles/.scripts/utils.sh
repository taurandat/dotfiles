export BETTER_EXCEPTIONS=1

all2pdf() {
    find . -type f -name "*.ps" -execdir ps2pdf {} \; -execdir rm {} \;
    find . -type f -name "*.djvu" -execdir djvu2pdf {} \; -execdir rm {} \;
}

pdf2text() {
    python ~/.scripts/pdf2text.py "$@"
}

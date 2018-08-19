function git-absolute-path() {
    fullpath=$([[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}")
    gitroot="$(git rev-parse --show-toplevel)" || return 1
    [[ "$fullpath" =~ "$gitroot" ]] && echo "${fullpath/$gitroot\//}"
}

function git-commit() {
    if (( $# != 1 )); then
        echo "git-commit requires a value"
    fi

    git commit -m .
    git commit -m "${$(git-absolute-path)[1,-2]}: ${1}"
}

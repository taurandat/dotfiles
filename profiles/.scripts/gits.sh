function git-absolute-path() {
    fullpath=$([[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}")
    gitroot="$(git rev-parse --show-toplevel)" || return 1
    [[ "$fullpath" =~ "$gitroot" ]] && echo "${fullpath/$gitroot\//}"
}

function git-commit() {
    if (( $# != 1 )); then
        echo "git-commit requires a value!"
        exit 1
    fi

    git_path="${$(git-absolute-path)[1,-2]}"
    if [ "${git_path}" = "" ]; then
        git_path="general"
    fi

    commit_message="${git_path}: ${1}"
    echo $commit_message
    git commit -m "${commit_message}"
}

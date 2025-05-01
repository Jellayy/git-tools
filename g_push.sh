#!/bin/bash

# acp (add+commit+push)
g_acp() {
    local message=$1

    git add .
    if [[ -z "$message" ]]; then
        git commit
    else
        git commit -m "$message"
    fi
    git push origin "$(git rev-parse --abbrev-ref HEAD)"
}

# acpa (add+commit+push (all))
g_acpa() {
    local message=$1

    # Get project root dir
    local project_root=$(git rev-parse --show-toplevel 2>/dev/null)

    cd "$project_root" || return 1
    git add .
    if [[ -z "$message" ]]; then
        git commit
    else
        git commit -m "$message"
    fi
    git push origin "$(git rev-parse --abbrev-ref HEAD)"
}

export g_acp
export g_acpa
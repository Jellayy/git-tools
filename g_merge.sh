#!/bin/bash

# m (create merge request in browser)
g_m() {
    local target_branch=$1
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    local remote_url=$(git remote get-url origin)

    # Target default branch if none specified
    if [[ -z "$target_branch" ]]; then
        target_branch=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
        if [[ -z "$target_branch" ]]; then
            echo "Error: Could not determine default branch"
            return 1
        fi
    fi

    # Convert SSH URLs to HTTPS & remove .git suffix
    if [[ "$remote_url" =~ ^git@ ]]; then
        remote_url=$(echo "$remote_url" | sed 's/^git@\(.*\):/https:\/\/\1\//' | sed 's/\.git$//')
    elif [[ "$remote_url" =~ ^https:// ]] then
        remote_url=$(echo "$remote_url" | sed 's/\.git$//')
    else
        echo "Error: Unsupported remote URL format"
        return 1
    fi

    # Generate a browser merge URL based on different git server syntax
    # Currently only supports Github & Gitlab
    # Additionally, selfhosted servers are assumed to be running Gitlab
    local mr_url
    if [[ "$remote_url" =~ ^https://github\.com ]]; then
        # GitHub Format
        mr_url="${remote_url}/compare/${target_branch}...${current_branch}"
    else
        # GitLab Format
        mr_url="${remote_url}/-/merge_requests/new?merge_request[source_branch]=${current_branch}&merge_request[target_branch]=${target_branch}"
    fi

    # Different OS calls for opening a url in a browser
    case "$(uname -s)" in
        Linux*)         xdg-open "$mr_url" ;;
        Darwin*)        open "$mr_url" ;;
        MINGW*|CYGWIN*) start "$mr_url" ;;
        *)              echo "Error: Unsupported OS" && return 1 ;;
    esac
}

export g_m
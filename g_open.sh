#!/bin/bash

# o (open repo url in browser)
g_o() {
    local remote_url=$(git remote get-url origin)
    if [[ -z "$remote_url" ]]; then
        echo "Error: No remote URL found"
        return 1
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

    # Different OS calls for opening a url in a browser
    case "$(uname -s)" in
        Linux*)         xdg-open "$remote_url" ;;
        Darwin*)        open "$remote_url" ;;
        MINGW*|CYGWIN*) start "$remote_url" ;;
        *)              echo "Error: Unsupported OS" && return 1 ;;
    esac
}

export g_o
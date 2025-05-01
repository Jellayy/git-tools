#!/bin/bash

# Base directory for storing all repos
BASE_DIR=~/git

# c (clone/navigate)
g_c() {
    local repo_url=$1

    if [[ -z "$repo_url" ]]; then
        echo "Usage: g c <repository-url>"
        return 1
    fi

    local repo_path=$(echo "$repo_url" | sed -E 's/^(https:\/\/|git@)//; s/:/\//; s/\.git$//')
    local dest_dir="$BASE_DIR/$repo_path"

    # If we've already cloned this repo, navigate instead
    if [[ -d "$dest_dir" ]]; then
        echo "Repo exists, navigating to: $dest_dir"
        cd "$dest_dir" || return 1
    else
        # New repo, clone to correct path & navigate
        mkdir -p "$(dirname "$dest_dir")"
        git clone "$repo_url" "$dest_dir"
        echo "Navigating to: $dest_dir"
        cd "$dest_dir" || return 1
    fi
}

export g_c
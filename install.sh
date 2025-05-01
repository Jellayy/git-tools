#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

detect_shell_config() {
    if [[ "$SHELL" == *"bash"* ]]; then
        echo "$HOME/.bashrc"
    elif [[ "$SHELL" == *"zsh"* ]]; then
        echo "$HOME/.zshrc"
    else
        echo ""
    fi
}

# Detect shell & get shell config file
CONFIG_FILE=$(detect_shell_config)
if [[ -z "$CONFIG_FILE" ]]; then
    echo "Unsupported shell. Please manually add the following lines to your shell configuration file:"
    echo "source $SCRIPT_DIR/*.sh"
    exit 1
fi

# Source all scripts (install)
echo "Sourcing Git Tools scripts..."
for script in "$SCRIPT_DIR"/*.sh; do
    if [[ "$script" != "$SCRIPT_DIR/install.sh" ]]; then
        source "$script"
    fi
done

# Persist configuration by writing to shell config file
if ! grep -q "source \"\$script\"" "$CONFIG_FILE"; then
    echo "Making configuration consistent by adding Git Tools to your shell config ($CONFIG_FILE)..."

    echo -e "\n# Init Git Tools" >> "$CONFIG_FILE"
    echo "for script in $SCRIPT_DIR/*.sh; do" >> "$CONFIG_FILE"
    echo "    if [[ \"\$script\" != \"$SCRIPT_DIR/install.sh\" ]]; then" >> "$CONFIG_FILE"
    echo "        source \"\$script\"" >> "$CONFIG_FILE"
    echo "    fi" >> "$CONFIG_FILE"
    echo "done" >> "$CONFIG_FILE"

    echo "Git Tools initialization successfully added to $CONFIG_FILE."
else
    echo "Git Tools initialization already present in $CONFIG_FILE."
fi

echo -e "Installation complete! Get started with: 'g c'"
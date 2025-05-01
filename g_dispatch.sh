#!/bin/bash

# Base ingress command 'g'
#
# We can't use aliases with spaces so we have a single
# 'dispatch' command that will use your second argument
# to route you to the proper function
g() {
    local subcommand=$1
    shift

    case $subcommand in
        c)
            g_c "$@"
            ;;
        acp)
            g_acp "$@"
            ;;
        acpa)
            g_acpa "$@"
            ;;
        o)
            g_o "$@"
            ;;
        m)
            g_m "$@"
            ;;
        h|help)
            echo "Available Commands:"
            echo "   g c    (clone)"
            echo "   g acp  (add+commit+push)"
            echo "   g acpa (add+commit+push (all))"
            echo "   g o    (open in browser)"
            echo "   g m    (merge in browser)"
            ;;
        *)
            echo "Unknown command: $subcommand"
            return 1
            ;;
    esac
}

export g
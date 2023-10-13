function __fish_reload_key_bindings --description 'Reload key bindings when binding variable change' --on-variable fish_key_bindings
        # Make sure some key bindings are set
        __init_uvar fish_key_bindings fish_default_key_bindings

        # Do nothing if the key bindings didn't actually change.
        # This could be because the variable was set to the existing value
        # or because it was a local variable.
        # If fish_key_bindings is empty on the first run, we still need to set the defaults.
        if test "$fish_key_bindings" = "$__fish_active_key_bindings" -a -n "$fish_key_bindings"
            return
        end
        # Check if fish_key_bindings is a valid function.
        # If not, either keep the previous bindings (if any) or revert to default.
        # Also print an error so the user knows.
        if not functions -q "$fish_key_bindings"
            echo "There is no fish_key_bindings function called: '$fish_key_bindings'" >&2
            # We need to see if this is a defined function, otherwise we'd be in an endless loop.
            if functions -q $__fish_active_key_bindings
                echo "Keeping $__fish_active_key_bindings" >&2
                # Set the variable to the old value so this error doesn't happen again.
                set fish_key_bindings $__fish_active_key_bindings
                return 1
            else if functions -q fish_default_key_bindings
                echo "Reverting to default bindings" >&2
                set fish_key_bindings fish_default_key_bindings
                # Return because we are called again
                return 0
            else
                # If we can't even find the default bindings, something is broken.
                # Without it, we would eventually run into the stack size limit, but that'd print hundreds of duplicate lines
                # so we should give up earlier.
                echo "Cannot find fish_default_key_bindings, falling back to very simple bindings." >&2
                echo "Most likely something is wrong with your installation." >&2
                return 0
            end
        end
        set -g __fish_active_key_bindings "$fish_key_bindings"
        set -g fish_bind_mode default
        if test "$fish_key_bindings" = fish_default_key_bindings
            # Redirect stderr per #1155
            fish_default_key_bindings 2>/dev/null
        else
            $fish_key_bindings 2>/dev/null
        end
        # Load user key bindings if they are defined
        if functions --query fish_user_key_bindings >/dev/null
            fish_user_key_bindings 2>/dev/null
        end
    
end

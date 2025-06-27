#!/usr/bin/env fish

# Remove all symlinks in the current directory
function remove_symlinks
    set -l symlinks_found 0
    set -l symlinks_removed 0
    
    # Find all symlinks in current directory (not recursive)
    for item in *
        if test -L "$item"
            set symlinks_found (math $symlinks_found + 1)
            echo "Found symlink: $item -> "(readlink "$item")
            
            if rm "$item"
                set symlinks_removed (math $symlinks_removed + 1)
                echo "Removed: $item"
            else
                echo "Failed to remove: $item" >&2
            end
        end
    end
    
    if test $symlinks_found -eq 0
        echo "No symlinks found in current directory"
    else
        echo "Summary: $symlinks_removed of $symlinks_found symlinks removed"
    end
end

# Run the function
remove_symlinks

#!/usr/bin/env fish

# Script to backup and remove conflicting directories for stow
# Only handles directories, ignores individual files

function main
    echo "🔄 Starting stow conflict cleanup..."
    
    # Create backup directory with timestamp
    set backup_dir "dotfiles_backup_"(date +%Y%m%d_%H%M%S)
    echo "📁 Creating backup directory: $backup_dir"
    mkdir -p $backup_dir
    
    # List of directories to backup and remove (extracted from stow conflicts)
    set directories_to_clean \
        ".config/BeatPrints" \
        ".config/fastfetch" \
        ".config/fish" \
        ".config/hypr" \
        ".config/kitty" \
        ".config/neofetch" \
        ".config/nushell" \
        ".config/ompsh" \
        ".config/projects" \
        ".config/spicetify" \
        ".config/spotify" \
        ".config/starship" \
        ".config/zed"
    
    set backed_up 0
    set removed 0
    set errors 0
    
    # Process each directory
    for dir in $directories_to_clean
        if test -d $dir
            echo "🔍 Processing directory: $dir"
            
            # Create backup
            set backup_path "$backup_dir/$dir"
            echo "  💾 Backing up to: $backup_path"
            
            # Create parent directories in backup if needed
            mkdir -p (dirname $backup_path)
            
            # Copy directory to backup
            if cp -r $dir $backup_path
                echo "  ✅ Backup successful"
                set backed_up (math $backed_up + 1)
                
                # Remove original directory
                echo "  🗑️  Removing original directory"
                if rm -rf $dir
                    echo "  ✅ Removal successful"
                    set removed (math $removed + 1)
                else
                    echo "  ❌ Failed to remove $dir"
                    set errors (math $errors + 1)
                end
            else
                echo "  ❌ Failed to backup $dir"
                set errors (math $errors + 1)
            end
            echo ""
        else
            echo "⚠️  Directory not found: $dir (skipping)"
        end
    end
    
    # Summary
    echo "📊 Summary:"
    echo "  • Directories backed up: $backed_up"
    echo "  • Directories removed: $removed"
    echo "  • Errors encountered: $errors"
    echo "  • Backup location: $backup_dir"
    echo ""
    
    if test $errors -eq 0
        echo "🎉 Cleanup completed successfully!"
        echo "💡 You can now run 'stow dotfiles' to create the symlinks"
        echo "🔙 To restore, run: cp -r $backup_dir/.config/* .config/"
    else
        echo "⚠️  Some errors occurred. Please check the output above."
    end
end

# Run the main function
main

function random_wallpaper
    set -l image_dir "/home/zenflow/ZenFlow/Wallpapers/"  # CHANGE THIS to your wallpaper directory
    set -l images (ls $image_dir/*.jpg 2>/dev/null)

    if test (count $images) -eq 0
        echo "No images found in $image_dir"
        return 1
    end

    set -l count (count $images)
    set -l i (math (random) % $count)
    set -l index (math "$i + 1")
    set -l selected_image $images[$index]

    echo "Selected wallpaper: $selected_image"
    matugen image "$selected_image"
end

random_wallpaper

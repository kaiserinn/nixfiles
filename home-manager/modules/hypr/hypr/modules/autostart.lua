hl.on("hyprland.start", function()
    hl.exec_cmd("dunst & hyprpaper & waybar & nm-applet & fcitx5")
    hl.exec_cmd("systemctl --user start plasma-polkit-agent")

    -- Clipboard manager
    -- Stores only text data
    hl.exec_cmd("wl-paste --type text --watch cliphist store ")
    -- Stores only image data
    hl.exec_cmd("wl-paste --type image --watch cliphist store ")
end)

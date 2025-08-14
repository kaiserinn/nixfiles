{pkgs, ...}: {
  home.pointerCursor = {
    name = "capitaine-cursors";

    package = pkgs.capitaine-cursors;

    gtk.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 32;
  };
}

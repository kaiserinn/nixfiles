{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
  ];

  dconf.settings = {
    # "/org/gnome/desktop/wm/preferences/focus-mode" = "mouse";
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "paperwm@paperwm.github.com"
      ];
    };
  };
}

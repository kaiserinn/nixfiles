{pkgs, ...}: {
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Minimal Gnome
  services.gnome = {
    core-apps.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
  };
  environment.systemPackages = with pkgs; [
    gnome-console
    gnomeExtensions.paperwm
  ];
  environment.gnome.excludePackages = with pkgs; [gnome-tour gnome-user-docs];
}

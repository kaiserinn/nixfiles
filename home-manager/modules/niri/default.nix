{pkgs, config, ...}: let
  homeDir = config.home.homeDirectory;
  niriConfig = "${homeDir}/.config/nix/home-manager/modules/niri";
in {
  home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${niriConfig}/niri";

  home.packages = with pkgs; [
    # See https://wiki.nixos.org/wiki/Niri/en#XWayland_apps_not_working
    xwayland-satellite

    wireplumber
    ironbar
  ];

  # Wallpaper
  services.awww.enable = true;

  imports = [
    ../ironbar
  ];
}

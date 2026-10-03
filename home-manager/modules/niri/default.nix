{pkgs, config, ...}: let
  homeDir = config.home.homeDirectory;
  niriConfig = "${homeDir}/.config/nix/home-manager/modules/niri";
in {
  home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${niriConfig}/niri";

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}

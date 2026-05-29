{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  waybar = inputs.waybar.packages.${system}.default;
in {
  programs.waybar = {
    enable = true;
    package = waybar;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}

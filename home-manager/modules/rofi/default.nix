{config, ...}: let
  homeDir = config.home.homeDirectory;
  rofiConfig = "${homeDir}/.config/nix/home-manager/modules/rofi";
in {
  home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${rofiConfig}/rofi";
}

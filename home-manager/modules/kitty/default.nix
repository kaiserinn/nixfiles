{config, ...}: let
  homeDir = config.home.homeDirectory;
  kittyConfig = "${homeDir}/.config/nix/home-manager/modules/kitty";
in {
  home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${kittyConfig}/kitty";
}

{config, ...}: let
  homeDir = config.home.homeDirectory;
  ironbarConfig = "${homeDir}/.config/nix/home-manager/modules/ironbar";
in {
  home.file.".config/ironbar".source = config.lib.file.mkOutOfStoreSymlink "${ironbarConfig}/ironbar";
}

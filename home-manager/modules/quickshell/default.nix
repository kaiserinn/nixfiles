{
  pkgs,
  config,
  ...
}: let
  homeDir = config.home.homeDirectory;
  quickshellConfig = "${homeDir}/.config/nix/home-manager/modules/quickshell";
in {
  home.file.".config/quickshell".source = config.lib.file.mkOutOfStoreSymlink "${quickshellConfig}/quickshell";

  programs.quickshell = {
    enable = true;
    # systemd.enable = true;
  };
}

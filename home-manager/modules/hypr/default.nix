{
  pkgs,
  config,
  ...
}: let
  luarc = {
    workspace = {
      library = [
        "${pkgs.hyprland}/share/hypr/stubs"
      ];
    };
    diagnostics = {
      globals = ["hl"];
    };
  };

  homeDir = config.home.homeDirectory;
  nixHypr = "${homeDir}/.config/nix/home-manager/modules/hypr/hypr";
in {
  home.file.".config/hypr/modules" = {
    source = config.lib.file.mkOutOfStoreSymlink "${nixHypr}/modules";
  };

  home.file.".config/hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
  home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;

  home.file.".config/hypr/hyprland.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${nixHypr}/hyprland.lua";

  home.file.".config/hypr/.luarc.json".text = builtins.toJSON luarc;
  home.file."${nixHypr}/.luarc.json".text = builtins.toJSON luarc;
}

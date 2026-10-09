{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    cursor = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 20;
    };
    icons = {
      enable = true;
      dark = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    targets = {
      qt.enable = true;
      gtk.enable = true;
      kitty.enable = false;
      neovim.enable = false;
      fish.enable = false;
      rofi.enable = false;
      dunst.enable = false;
      starship.enable = false;
      waybar.enable = false;
      zen-browser.enable = false;
    };
  };
}


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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    targets = {
      kitty.enable = false;
      neovim.enable = false;
      fish.enable = false;
      rofi.enable = false;
      dunst.enable = false;
      starship.enable = false;
      waybar.enable = false;
    };
  };
}


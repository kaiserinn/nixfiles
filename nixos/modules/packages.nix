{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    libnotify
    brightnessctl
    pavucontrol
    networkmanagerapplet
    pamixer
    blueman
    unzip
    zip
    unrar
    xdg-desktop-portal-gtk
    home-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}

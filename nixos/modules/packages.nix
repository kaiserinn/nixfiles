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
    mesa-demos

    gcc
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    newcomputermodern
    iosevka
    texlivePackages.stix2-otf
  ];
}

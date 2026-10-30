{ pkgs, osConfig, ... }: {
  programs.lutris = {
    enable = true;

    extraPackages = with pkgs; [
      winetricks
      protontricks
      umu-launcher
      gamemode
    ];

    steamPackage = osConfig.programs.steam.package or pkgs.steam;
    winePackages = [ pkgs.wineWow64Packages.stagingFull ];
    protonPackages = [ pkgs.proton-ge-bin ];
    defaultWinePackage = pkgs.proton-ge-bin;
  };
  #
  # xdg.dataFile."lutris/runners/wine/${pkgs.proton-ge-bin.name}" = {
  #   source = pkgs.proton-ge-bin.steamcompattool;
  # };
}

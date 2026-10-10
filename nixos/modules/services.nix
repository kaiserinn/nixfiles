{pkgs, ...}: {
  services.mysql = {
    enable = false;
    package = pkgs.mariadb;
  };

  services.upower.enable = true;

  systemd.services = {
    # Hogging boot time
    NetworkManager-wait-online.enable = false;
  };
}

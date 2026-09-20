{pkgs, ...}: {
  services.mysql = {
    enable = false;
    package = pkgs.mariadb;
  };

  systemd.services = {
    # Hogging boot time
    NetworkManager-wait-online.enable = false;
  };
}

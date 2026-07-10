{pkgs, ...}: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  systemd.services = {
    # Hogging boot time
    NetworkManager-wait-online.enable = false;
  };
}

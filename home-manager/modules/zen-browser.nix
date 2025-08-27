{inputs, ...}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser.enable = true;

  # xdg = {
  #   desktopEntries = {
  #     zen-browser = {
  #       name = "Zen Browser";
  #       genericName = "Web Browser";
  #       exec = "zen %U";
  #
  #       noDisplay = true;
  #       terminal = false;
  #       type = "Application";
  #
  #       categories = [
  #         "Network"
  #         "WebBrowser"
  #       ];
  #       mimeType = [
  #         "text/html"
  #         "application/pdf"
  #         "application/xhtml+xml"
  #         "application/xml"
  #       ];
  #     };
  #   };
  # };
}

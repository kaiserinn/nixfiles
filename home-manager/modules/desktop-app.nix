{
  xdg.desktopEntries = {
    tomat = {
      name = "Tomat";
      type = "Application";
      exec = "tomat";
    };

    hytale-launcher-nvidia = {
      name = "Hytale Launcher (NVIDIA)";
      comment = "Official launcher for Hytale";
      exec = "nvidia-offload hytale-launcher";
      icon = "com.hypixel.HytaleLauncher";
      terminal = false;
      type = "Application";
      categories = ["Game"];
      settings = {
        Keywords = "hytale;game;launcher;hypixel;";
        StartupWMClass = "com.hypixel.HytaleLauncher";
      };
    };

    openchamber = {
      type = "Application";
      name = "OpenChamber";
      comment = "Desktop runtime for OpenChamber";
      exec = "appimage-run \"/home/azhar/Downloads/OpenChamber-2.5.3-linux-x86_64.AppImage\" %U";
      icon = "/home/azhar/.local/share/icons/hicolor/512x512/apps/openchamber.png";
      terminal = false;
      startupNotify = true;
      categories = ["Development"];
      settings = {
        "X-OpenChamber-Managed" = "true";
      };
    };
  };
}

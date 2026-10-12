{
  xdg.desktopEntries.hytale-launcher-nvidia = {
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
}

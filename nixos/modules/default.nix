{
  imports = [
    # ./nvidia.nix
    ./disable-nvidia.nix
    ./packages.nix
    ./ssh.nix
    ./services.nix
    ./tlp.nix
    # ./docker.nix
    # ./steam.nix
    ./hyprland.nix
    ./nix.nix
    # ./gnome.nix
    ./cosmic.nix
  ];
}

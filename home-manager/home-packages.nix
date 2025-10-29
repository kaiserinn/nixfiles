{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # cli tools
    jjui
    ripgrep
    fd
    eza
    bat
    fzf
    tldr
    btop
    nh
    fastfetch
    zellij
    yadm
    yazi
    ffmpeg
    xh
    typst

    # desktop environment
    waybar
    dunst
    rofi
    hyprpaper
    grim
    slurp
    satty
    wl-clipboard
    cliphist

    # apps
    kitty
    discord
    vlc
    mpv
    obs-studio
    obsidian
    anki
    youtube-music
    kdePackages.okular
    zed-editor

    # misc
    git
    gcc
    jq
    wget
    scrcpy

    inputs.kintsugi.packages.${pkgs.system}.default

    # dev
    bun
    zig
    mycli
    cargo
    rustc
    go
    nodejs_24
    devenv
    uv
    python314

    (pkgs.php.buildEnv {
      extensions = {
        enabled,
        all,
      }:
        enabled
        ++ (with all; [
          xdebug
        ]);
      extraConfig = ''
        xdebug.mode=debug,coverage
      '';
    })
    php84Packages.composer
  ];
}

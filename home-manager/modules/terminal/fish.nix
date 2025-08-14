{
  programs.fish = {
    enable = true;

    generateCompletions = true; 

    shellAliases = {
      nconfig = "cd ~/.config/nix";
      ls = "eza --group-directories-first --icons";
      la = "eza -a --icons";
      cat = "bat";
      cd = "z";
      zz = "z -";
    };

    functions = {
      fish_greeting = ''
        echo (set_color yellow; date '+%A, %d %B %Y'; set_color normal)
        echo -s 'Currently logged in as ' (set_color green; whoami; set_color normal) ' at ' (set_color green) $hostname (set_color normal)
        echo
      '';

      ya = ''
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
  };
}

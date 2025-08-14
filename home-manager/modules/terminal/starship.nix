{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = ''
        $username[❯](#02D0A9) $directory$git_branch$nix_shell
        $character
      '';

      add_newline = false;

      character = {
        success_symbol = "❯";
        error_symbol = "[❯](red)";
      };

      directory = {
        # truncation_length = 1;
        fish_style_pwd_dir_length = 1;
        style = "#02D0A9";
      };

      git_branch = {
        format = "*[$branch(:$remote_branch)]($style) ";
        style = "#606060";
      };

      username = {
        format = "[$user]($style) ";
        show_always = true;
        style_user = "#606060";
      };
    };
  };
}

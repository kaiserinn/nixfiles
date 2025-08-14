{
  pkgs,
  ...
}: {
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Tools
      nodejs_24
      cargo

      # Language servers
      nil
      lua-language-server
      zls
      phpactor
      intelephense
      vtsls
      tailwindcss-language-server
      vscode-langservers-extracted # css, eslint, html, json, md
      emmet-language-server
      gopls
      rust-analyzer

      # Formatters/linters
      alejandra
      prettierd
      eslint_d
      rustfmt
      clippy
    ];
  };
}

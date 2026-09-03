{
  pkgs,
  config,
  unstable,
  inputs,
  ...
}: let
  homeDir = config.home.homeDirectory;
  nvim = "${homeDir}/.config/nix/home-manager/modules/neovim";
in {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${nvim}/nvim";

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
    defaultEditor = true;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      # Tools
      nodejs_24
      cargo
      # lua55Packages.tree-sitter-cli
      tree-sitter

      # Language servers
      nixd
      nixfmt
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
      tinymist
      ty
      pyright
      # unstable.svelte-language-server
      clang-tools
      wgsl-analyzer

      # Formatters/linters
      alejandra
      prettierd
      eslint_d
      rustfmt
      clippy

      # For typst-preview
      websocat
    ];
  };
}

{ lib, pkgs, ... }:
{
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/bin"
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = lib.mkOrder 500 ''
      # Prefer system-managed Nix tools over Homebrew when both exist.
      path=(/run/current-system/sw/bin $path)
    '';

    plugins = [
      {
        name = "history-search-multi-word";
        src = pkgs.zsh-history-search-multi-word;
        file = "share/zsh/zsh-history-search-multi-word/history-search-multi-word.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];
    };
  };

  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "TokyoNight";
      "font-family" = "JetBrainsMono Nerd Font";
      "font-size" = 14;
      "window-padding-x" = 10;
      "window-padding-y" = 10;
      "confirm-close-surface" = false;
      "copy-on-select" = true;
    };
  };
}

{ ... }:
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

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

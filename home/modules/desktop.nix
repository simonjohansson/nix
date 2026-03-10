{ pkgs, ... }:
{
  home.file."bin/zed" = {
    executable = true;
    text = ''
      #!/bin/sh
      exec /Applications/Zed.app/Contents/MacOS/cli "$@"
    '';
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry_mac;
    enableZshIntegration = true;
    defaultCacheTtl = 1800;
    maxCacheTtl = 7200;
  };

  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "TokyoNight";
      "font-family" = "JetBrainsMono Nerd Font";
      "font-size" = 18;
      "window-padding-x" = 20;
      "window-padding-y" = 20;
      "confirm-close-surface" = false;
      "clipboard-paste-protection" = false;
      "copy-on-select" = true;
      "macos-option-as-alt" = true;
    };
  };

  programs.zed-editor = {
    enable = true;
    package = null;
    extensions = [ "catppuccin" "nix" ];
    userSettings = {
      base_keymap = "Emacs";
      theme = "Catppuccin Frappé";
      terminal = {
        option_as_meta = true;
      };
    };
  };
}

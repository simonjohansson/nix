{ lib, username, system, ... }:
let
  userHome = "/Users/${username}";
in
{
  # Determinate manages the Nix installation/daemon.
  nix.enable = false;

  users.users.${username}.home = userHome;
  system.primaryUser = username;

  programs.zsh.enable = true;

  documentation.enable = false;
  # The packaged uninstaller evaluates its own default system, which pulls in darwin-manual-html.
  system.tools.darwin-uninstaller.enable = false;

  system.defaults.NSGlobalDomain = {
    "com.apple.sound.beep.volume" = 0.0;
    "com.apple.sound.beep.feedback" = 0;
    NSAutomaticSpellingCorrectionEnabled = false;
  };

  system.defaults.dock = {
    orientation = "left";
    autohide = true;
    tilesize = 36;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  nixpkgs.hostPlatform = system;
  nixpkgs.config.allowUnfreePredicate = package: lib.getName package == "claude-code";

  system.stateVersion = 5;
}

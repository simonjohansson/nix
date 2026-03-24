{ lib, username, userHome, darwinRebuild, sudoFlakeRef, ... }:
{
  # Determinate manages the Nix installation/daemon.
  nix.enable = false;

  users.users.${username}.home = userHome;
  system.primaryUser = username;

  programs.zsh.enable = true;

  security.sudo.extraConfig = ''
    # Escape '#' in flake refs, otherwise sudoers treats it as a comment.
    Cmnd_Alias DARWIN_REBUILD = ${darwinRebuild} switch --flake ${sudoFlakeRef}
    ${username} ALL = (root) NOPASSWD: DARWIN_REBUILD
  '';

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

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

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.overlays = [
    (final: prev: {
      direnv = prev.direnv.overrideAttrs (old: {
        # direnv's Darwin makefile forces external linking; keep cgo enabled so
        # upstream packaging changes do not break local rebuilds.
        env = (old.env or { }) // lib.optionalAttrs final.stdenv.hostPlatform.isDarwin {
          CGO_ENABLED = 1;
        };
      });
    })
  ];

  system.stateVersion = 5;
}

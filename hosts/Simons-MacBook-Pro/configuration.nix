{ pkgs, username, ... }:
{
  # Determinate manages the Nix installation/daemon.
  nix.enable = false;

  users.users.${username}.home = "/Users/${username}";
  system.primaryUser = username;

  programs.zsh.enable = true;

  environment.systemPackages = [
    pkgs.ghostty-bin
    pkgs.vim
    pkgs.git
    (pkgs.writeShellScriptBin "qwe" ''
      set -euo pipefail

      previous_dir="$(pwd)"
      cd /Users/simonjohansson/src/nix

      if sudo -H /run/current-system/sw/bin/darwin-rebuild switch --flake /Users/simonjohansson/src/nix#Simons-MacBook-Pro; then
        cd "$previous_dir"
        # Start a fresh login shell so PATH/env updates are available immediately.
        exec "$SHELL" -l
      else
        status=$?
        cd "$previous_dir"
        exit "$status"
      fi
    '')
  ];

  security.sudo.extraConfig = ''
    # Escape '#' in flake refs, otherwise sudoers treats it as a comment.
    Cmnd_Alias DARWIN_REBUILD = /run/current-system/sw/bin/darwin-rebuild switch --flake /Users/simonjohansson/src/nix\#Simons-MacBook-Pro
    ${username} ALL = (root) NOPASSWD: DARWIN_REBUILD
  '';

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
}

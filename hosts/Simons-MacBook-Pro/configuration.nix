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
    (pkgs.writeShellScriptBin "rebuild" ''
      set -euo pipefail

      previous_dir="$(pwd)"
      trap 'cd "$previous_dir"' EXIT

      cd /Users/simonjohansson/src/nix
      sudo -H /run/current-system/sw/bin/darwin-rebuild switch --flake /Users/simonjohansson/src/nix#Simons-MacBook-Pro
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

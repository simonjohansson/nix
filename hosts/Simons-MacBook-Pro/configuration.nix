{ pkgs, username, ... }:
{
  # Determinate manages the Nix installation/daemon.
  nix.enable = false;

  users.users.${username}.home = "/Users/${username}";
  system.primaryUser = username;

  environment.systemPackages = [
    pkgs.ghostty-bin
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
}

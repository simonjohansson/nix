{ lib, pkgs, username, hostname, repoRoot, ... }:
let
  darwinRebuild = "/run/current-system/sw/bin/darwin-rebuild";
  flakeRef = "${repoRoot}#${hostname}";
  sudoFlakeRef = builtins.replaceStrings [ "#" ] [ "\\#" ] flakeRef;
in
{
  # The flake is user-writable, so this intentionally trusts the primary user
  # to run this exact nix-darwin switch command as root without a password.
  security.sudo.extraConfig = ''
    Cmnd_Alias NIX_DARWIN_SWITCH = ${darwinRebuild} switch --flake ${sudoFlakeRef}
    ${username} ALL = (root) NOPASSWD: NIX_DARWIN_SWITCH
  '';

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "qwe" ''
      set -euo pipefail

      cd ${lib.escapeShellArg repoRoot}
      exec sudo -H ${darwinRebuild} switch --flake ${lib.escapeShellArg flakeRef}
    '')
  ];
}

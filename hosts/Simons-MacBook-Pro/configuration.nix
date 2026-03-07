{ username, hostname, repoRoot, ... }:
let
  userHome = "/Users/${username}";
  darwinRebuild = "/run/current-system/sw/bin/darwin-rebuild";
  flakeRef = "${repoRoot}#${hostname}";
  sudoFlakeRef = builtins.replaceStrings [ "#" ] [ "\\#" ] flakeRef;
in
{
  imports = [
    ./modules/system.nix
    ./modules/packages.nix
    ./modules/homebrew.nix
  ];

  _module.args = {
    inherit userHome darwinRebuild flakeRef sudoFlakeRef;
  };
}

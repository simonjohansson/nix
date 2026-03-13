{ lib, pkgs, darwinRebuild, flakeRef, repoRoot, ... }:
{
  environment.systemPackages = [
    pkgs.vim
    pkgs.gnupg
    pkgs.jq
    pkgs.ripgrep
    pkgs.curl
    pkgs.duti
    pkgs.go
    pkgs.uv
    pkgs.gh
    pkgs.htop
    (pkgs.mactop.overrideAttrs (_: {
      doCheck = false;
    }))
    pkgs."silver-searcher"
    pkgs.tmux
    pkgs.yq
    (pkgs.writeShellScriptBin "qwe" ''
      set -euo pipefail

      previous_dir="$(pwd)"
      cd ${lib.escapeShellArg repoRoot}

      if sudo -H ${darwinRebuild} switch --flake ${lib.escapeShellArg flakeRef}; then
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
}

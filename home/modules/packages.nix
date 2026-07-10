{ pkgs, ... }:
let
  defuddle = pkgs.callPackage ../../pkgs/defuddle.nix { };
in
{
  home.packages = [
    pkgs.vim
    defuddle
    pkgs.jq
    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.pandoc
    pkgs.uv
    pkgs.gh
    pkgs.htop
    pkgs.duckdb
    pkgs.mactop
    pkgs.tmux
    pkgs.yq
  ];
}

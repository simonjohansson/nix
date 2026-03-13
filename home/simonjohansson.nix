{ ... }:
{
  imports = [
    ./modules/shell.nix
    ./modules/ssh.nix
    ./modules/git.nix
    ./modules/desktop.nix
    ./modules/llms.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/bin"
  ];

  home.file.".nvm/.keep".text = "";
}

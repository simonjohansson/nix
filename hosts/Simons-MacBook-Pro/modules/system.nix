{ username, userHome, darwinRebuild, sudoFlakeRef, ... }:
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

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
}

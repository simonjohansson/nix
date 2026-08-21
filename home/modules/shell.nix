{ lib, pkgs, ... }:
let
  direnv = pkgs.direnv.overrideAttrs (old: {
    # direnv's Darwin makefile forces external linking; keep cgo enabled so
    # upstream packaging changes do not break local rebuilds.
    env = (old.env or { }) // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      CGO_ENABLED = 1;
    };
  });
in
{
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    setOptions = [ "NO_BEEP" ];

    initContent = lib.mkOrder 500 ''
      # Prefer system-managed Nix tools over Homebrew when both exist.
      path=(/run/current-system/sw/bin $path)
    '';

    plugins = [
      {
        name = "history-search-multi-word";
        src = pkgs.zsh-history-search-multi-word;
        file = "share/zsh/zsh-history-search-multi-word/history-search-multi-word.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "direnv" "git" "sudo" ];
    };
  };

  programs.readline = {
    enable = true;
    variables.bell-style = "none";
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig.tools.go = "latest";
  };

  programs.direnv = {
    enable = true;
    package = direnv;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

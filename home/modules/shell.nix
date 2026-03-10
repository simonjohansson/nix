{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    setOptions = [ "NO_BEEP" ];

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        # Prefer system-managed Nix tools over Homebrew when both exist.
        path=(/run/current-system/sw/bin $path)
      '')

      (lib.mkOrder 550 ''
        export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
      '')
    ];

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
      plugins = [ "git" "sudo" ];
    };
  };

  programs.readline = {
    enable = true;
    variables.bell-style = "none";
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

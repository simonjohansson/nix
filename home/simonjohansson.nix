{ lib, pkgs, ... }:
{
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/bin"
  ];

  home.file.".nvm/.keep".text = "";

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.orbstack/ssh/config" ];
    matchBlocks."*" = {
      identityFile = [ "~/.ssh/id_ed25519" ];
      extraOptions = {
        UseKeychain = "yes";
      };
    };
  };

  programs.git = {
    enable = true;
    package = null;
    lfs.enable = true;
    settings = {
      alias = {
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      };
      color = {
        branch = "auto";
        diff = "auto";
        interactive = "auto";
        status = "auto";
      };
      user = {
        email = "simon@simonjohansson.com";
        name = "Simon Johansson";
        signingkey = "63F236A41D9A79AC";
      };
      init.defaultBranch = "main";
      pull = {
        ff = "only";
        rebase = true;
      };
      commit.gpgsign = true;
      gpg.program = "gpg";
      "diff \"sqlite3\"" = {
        binary = true;
        textconv = "echo .dump | sqlite3";
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry_mac;
    enableZshIntegration = true;
    defaultCacheTtl = 1800;
    maxCacheTtl = 7200;
  };

  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "TokyoNight";
      "font-family" = "JetBrainsMono Nerd Font";
      "font-size" = 18;
      "window-padding-x" = 20;
      "window-padding-y" = 20;
      "confirm-close-surface" = false;
      "copy-on-select" = true;
      "macos-option-as-alt" = true;
    };
  };
}

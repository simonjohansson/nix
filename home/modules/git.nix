{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
  };

  programs.git = {
    enable = true;
    package = pkgs.git;
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
}

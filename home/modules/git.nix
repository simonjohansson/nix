{ ... }:
{
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
}

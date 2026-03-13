{ pkgs, ... }:
let
  agentRules = ''
    ## Git
    - Write commit messages that conform to Tim Pope's standards.
    - Include the prompt in the commit message.
    - Don't add emojis to commit messages.
    - NEVER use `git -C <path>`. Always run git commands without `-C`. You are already in the correct directory. Using `-C` is redundant and wrong.
    - When working on a feature branch, use `git worktree add` instead of `git checkout -b`.

    ## Environment
    - Prefer `rg` over `grep`
    - Prefer `fd` over `find`

    ## Languages
    - Always manage language runtimes with `mise`

    ## Configuration
    - Before placing config files manually, first check whether Home Manager or the package already exposes a declarative option for it, and prefer that over ad hoc file placement.
    - When Home Manager configures a Nix-installed tool, prefer to keep installation and configuration in the same Home Manager module; use `package = null` only when relying on a Homebrew or other externally managed app.
  '';
in {
  programs.codex = {
    enable = true;
    package = pkgs.codex;
    custom-instructions = agentRules;
  };

  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    rules = agentRules;
  };
}

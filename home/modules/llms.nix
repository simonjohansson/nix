{ ... }:
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

    ## Working Preferences
    - When asked to follow an existing pattern, inspect that pattern first and mirror its boundaries closely.
    - Keep changes strictly scoped to the explicit request; do not expand into adjacent systems, public contracts, generated artifacts, or secondary workflows without confirmation.
    - If instructions are ambiguous or appear to conflict, stop and ask before implementing.
    - Treat established public/stable boundaries as off-limits unless explicitly asked to change them.
    - When corrected, pause, reassess, and reduce the diff instead of immediately trying a new design.
    - Before changing generated files, schemas, APIs, persisted formats, or other broad-impact artifacts, explain why it is necessary and wait for confirmation.
  '';
in {
  home.file."bin/claude" = {
    executable = true;
    text = ''
      #!/bin/sh
      exec nix run github:sadjow/claude-code-nix -- "$@"
    '';
  };

  home.file.".config/opencode/AGENTS.md".text = agentRules;

  programs.claude-code = {
    enable = true;
    package = null;
    context = agentRules;
  };

  programs.codex = {
    enable = true;
    package = null;
    context = agentRules;
  };
}

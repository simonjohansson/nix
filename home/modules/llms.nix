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

    ## cmux Skills
    - If `CMUX_WORKSPACE_ID` is set and non-empty, assume the session is inside a cmux workspace and use cmux skills automatically when they fit the task.
    - Use the `cmux` skill for topology-aware terminal work such as discovering the current workspace, creating panes, moving surfaces, focusing panes, or routing commands to a specific surface.
    - Use the `cmux-browser` skill for browser automation inside cmux webviews, including opening pages, waiting for state changes, taking interactive snapshots, and acting on element refs.
    - Use the `cmux-markdown` skill when a plan, notes, or documentation would benefit from a live markdown panel beside the terminal.
    - When `CMUX_WORKSPACE_ID` is unset or empty, do not assume cmux is available and do not require cmux for routine work.
    - Prefer ordinary shell commands when they are simpler than cmux, even when `CMUX_WORKSPACE_ID` is available.
    - When using cmux, start by identifying context with `cmux identify --json` or another context-discovery command before creating or moving panes or surfaces.
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

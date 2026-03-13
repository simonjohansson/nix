# AGENTS.md

## Purpose

- This repo defines a single macOS system configuration with `nix-darwin` and `home-manager`.
- The main flake output is `darwinConfigurations.Simons-MacBook-Pro`.
- Host-specific Darwin config lives in `hosts/Simons-MacBook-Pro/`.
- User-specific Home Manager config lives in `home/`.
- Shared Darwin modules live in `hosts/Simons-MacBook-Pro/modules/`.
- Shared Home Manager modules live in `home/modules/`.
- There is currently no repo-local `.cursorrules`, no `.cursor/rules/`, and no `.github/copilot-instructions.md`.

## Repository Map

- `flake.nix`: top-level inputs and outputs.
- `hosts/Simons-MacBook-Pro/configuration.nix`: host entrypoint.
- `hosts/Simons-MacBook-Pro/modules/system.nix`: system defaults, sudo, platform settings.
- `hosts/Simons-MacBook-Pro/modules/packages.nix`: CLI packages and the `qwe` helper.
- `hosts/Simons-MacBook-Pro/modules/homebrew.nix`: Homebrew taps, brews, and casks.
- `home/simonjohansson.nix`: Home Manager entrypoint.
- `home/modules/shell.nix`: shell, `mise`, and `direnv` setup.
- `home/modules/git.nix`: Git identity and defaults.
- `home/modules/desktop.nix`: desktop apps, editor settings, file associations, GPG agent.
- `home/modules/opencode.nix`: agent rules mirrored into the local `opencode` config.

## Core Commands

- Run commands from the repo root: `/Users/simonjohansson/src/nix`.
- Inspect flake outputs: `nix flake show`.
- Evaluate the full flake: `nix flake check`.
- Build the Darwin config without switching: `darwin-rebuild build --flake .#Simons-MacBook-Pro`.
- Build the system derivation directly: `nix build .#darwinConfigurations.Simons-MacBook-Pro.system`.
- Apply the local machine config with the repo helper: `qwe`.
- Apply explicitly without the helper: `sudo -H /run/current-system/sw/bin/darwin-rebuild switch --flake .#Simons-MacBook-Pro`.
- Update all flake inputs: `nix flake update`.
- Update only `nixpkgs`: `nix flake lock --update-input nixpkgs`.

## Lint, Format, and Test Reality

- There is no dedicated linter configured in `flake.nix`.
- There is no repo-wired formatter exposed through `nix fmt` in `flake.nix`.
- There is no unit test or integration test suite checked into this repo.
- `nix flake check` is the broadest built-in validation command currently available.
- `darwin-rebuild build --flake .#Simons-MacBook-Pro` is the safest full-build verification before a real switch.
- `qwe` performs an actual `switch`; do not use it for casual validation.

## Single-Test / Targeted Validation Guidance

- Because there is no single-test runner, use targeted evaluation for the specific option you changed.
- Pattern: `nix eval .#darwinConfigurations.Simons-MacBook-Pro.config.<attrpath> --json`.
- Verified example: `nix eval .#darwinConfigurations.Simons-MacBook-Pro.config.system.stateVersion --json`.
- If you changed a Home Manager option, evaluate the affected Home Manager attrpath inside the Darwin config.
- If you changed package composition or activation scripts, prefer `darwin-rebuild build --flake .#Simons-MacBook-Pro`.
- If you changed only flake wiring, start with `nix flake check` before any build.
- If you changed a shell script embedded in Nix, inspect quoting and then run the broader build.

## Recommended Validation Strategy

- Small option change: run `nix eval` on the touched attrpath.
- Module-level change: run `nix flake check`.
- System or activation change: run `darwin-rebuild build --flake .#Simons-MacBook-Pro`.
- Input update: run `nix flake check`, then `darwin-rebuild build --flake .#Simons-MacBook-Pro`.
- Real machine rollout: run `qwe` only after the build passes.

## Structure Conventions

- Nix files are written as module functions returning attrsets: `{ ... }:` followed by `{ ... }`.
- Keep module argument lists explicit, narrow, and ordered by use.
- Keep `...` in the argument list when the module accepts additional attrs.
- Use `let ... in` for shared derived values such as paths, bundle IDs, and flake refs.
- Put entrypoint files at the top of the composition tree and leaf behavior in `modules/`.
- Add shared user behavior under `home/modules/`.
- Add shared host behavior under `hosts/Simons-MacBook-Pro/modules/`.
- Keep host and user entrypoints mostly declarative and light on logic.

## Formatting Style

- Use two-space indentation.
- Terminate every attribute assignment with `;`.
- Keep opening and closing braces aligned vertically.
- Prefer one list item per line for non-trivial lists.
- Leave a blank line between logical blocks.
- Use double quotes for ordinary strings.
- Use indented strings `'' ... ''` for multiline shell or generated text.
- Keep files compact; most modules in this repo are short and focused.

## Imports and Namespacing

- Use explicit relative imports like `./modules/system.nix`.
- Keep `imports = [ ... ];` near the top of entrypoint modules.
- Prefer explicit qualification such as `pkgs.git` and `lib.mkMerge`.
- Do not introduce `with pkgs;` or `with lib;` for convenience.
- Use `inherit` when forwarding an unchanged local name into another attrset.
- Reuse derived values instead of repeating interpolated strings.

## Naming Conventions

- Use `camelCase` for local variables and derived names such as `repoRoot`, `userHome`, and `darwinRebuild`.
- Match upstream option names exactly when configuring external programs.
- Use quoted keys when an option name contains punctuation, for example `"font-family"`.
- Name helper functions by intent, for example `mkDutiLine`.
- Keep helper names short but descriptive.
- Prefer stable, literal host and username names only where the system actually requires them.

## Package and Tooling Conventions

- Prefer Nix-managed packages for CLI tools and declarative system behavior.
- Keep GUI/macOS app installs in the existing Homebrew module unless there is a clear reason to move them.
- Follow the current split: `environment.systemPackages` for CLI tools, `homebrew.casks` for GUI apps, `homebrew.brews` for Homebrew CLI exceptions.
- Do not enable `nix.enable`; this repo intentionally leaves Nix installation management to Determinate.
- Keep `programs.<name>.package = null` when the repo intentionally relies on an externally installed app.

## Shell and Script Guidelines

- Shell snippets in this repo are POSIX-style unless a feature clearly requires Bash-specific behavior.
- Start non-trivial scripts with `set -euo pipefail`.
- Quote every interpolated shell value.
- Use `lib.escapeShellArg` when injecting dynamic values into shell strings.
- Preserve and restore working directory when a helper temporarily changes it.
- Return the original failure status when a command fails.
- Add comments only when the shell logic is non-obvious or platform-specific.

## Error Handling and Safety

- Prefer declarative configuration over imperative fixes.
- Fail fast instead of swallowing command errors.
- When a workaround is required, explain it briefly with a focused comment.
- Keep ordering constraints explicit with `lib.mkOrder` or Home Manager DAG helpers.
- When disabling checks or overriding package behavior, document why, as in the `mactop` override.
- Preserve escape handling around flake refs that contain `#`.
- Be cautious with `security.sudo.extraConfig`; small quoting mistakes can break sudo rules.

## Option Design Patterns Seen Here

- Use `lib.mkMerge` for layered shell init content.
- Use `lib.mkOrder` when shell fragments require deterministic precedence.
- Use `lib.hm.dag.entryAfter` for Home Manager activation ordering.
- Build generated text with `lib.concatMapStringsSep` or `lib.concatStringsSep`.
- Prefer mapping from a data list into generated config instead of duplicating near-identical blocks.
- Keep derived data in a `let` block close to where it is consumed.

## Comments and Documentation

- Keep comments sparse.
- Use comments to explain why, not what.
- Preserve existing explanatory comments around platform behavior, PATH precedence, and sudo escaping.
- If a block is obvious from the option name, do not add a comment.

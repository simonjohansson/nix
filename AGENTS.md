# AGENTS.md

- Repo: macOS config with `nix-darwin` + `home-manager`; main output `darwinConfigurations.Simons-MacBook-Pro`.
- Entrypoints: `hosts/Simons-MacBook-Pro/configuration.nix` and `home/simonjohansson.nix`.
- Shared modules: `hosts/Simons-MacBook-Pro/modules/` and `home/modules/`.

## Commands
- Run from `/Users/simonjohansson/src/nix`.
- Inspect: `nix flake show`.
- Broad validation: `nix flake check`.
- Safe full build: `darwin-rebuild build --flake .#Simons-MacBook-Pro`.
- Direct build: `nix build .#darwinConfigurations.Simons-MacBook-Pro.system`.
- Apply locally: `qwe >qwe.log 2>&1 || cat qwe.log`; it performs a real `switch`. **Always redirect output — never run bare `qwe`.**

When running `darwin-rebuild` or `nix` commands, redirect output to a file (`cmd >cmd.log 2>&1 || cat cmd.log`); only read the log if you actually need the output (e.g. `nix eval`).

## Configuration
- Before placing config files manually, first check whether Home Manager or the package exposes a declarative option and prefer that over ad hoc file placement.
- When Home Manager configures a Nix-installed tool, keep installation and configuration in the same Home Manager module; use `package = null` only for Homebrew or other externally managed apps.

## Validation
- Small option change: `nix eval .#darwinConfigurations.Simons-MacBook-Pro.config.<attrpath> --json`.
- Home Manager option: evaluate the affected attrpath through the Darwin config.
- Package, activation, or shell-script change: prefer `darwin-rebuild build --flake .#Simons-MacBook-Pro`.

## Conventions
- Use explicit module arguments and imports, qualified names like `pkgs.git` and `lib.mkMerge`, and `let ... in` for shared derived values.
- Keep Nix files compact with two-space indentation, semicolons on every assignment, double-quoted strings, and indented strings for multiline shell text.
- Prefer declarative fixes, preserve ordering with `lib.mkOrder` or Home Manager DAG helpers, and comment only to explain why.

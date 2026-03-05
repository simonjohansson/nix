# Nix macOS Configuration

This repository manages the `Simons-MacBook-Pro` nix-darwin + Home Manager setup.

## Update Nix packages

From this repo:

```bash
cd /Users/simonjohansson/src/nix
nix flake update
qwe
```

What this does:

1. Updates pinned inputs in `flake.lock`.
2. Applies the updated configuration by running `darwin-rebuild switch` via `qwe`.

## Useful variants

Update only `nixpkgs`:

```bash
nix flake lock --update-input nixpkgs
qwe
```

Review lockfile changes before switching:

```bash
git diff flake.lock
```

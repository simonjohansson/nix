{ lib, pkgs, ... }:
let
  zedBundleId = "dev.zed.Zed";
  zedExtensions = [
    ".nix"
    ".md"
    ".txt"
    ".json"
    ".jsonc"
    ".yaml"
    ".yml"
    ".toml"
    ".ini"
    ".cfg"
    ".conf"
    ".env"
    ".sh"
    ".bash"
    ".zsh"
    ".fish"
    ".py"
    ".js"
    ".jsx"
    ".mjs"
    ".cjs"
    ".ts"
    ".tsx"
    ".css"
    ".scss"
    ".html"
    ".xml"
    ".sql"
    ".go"
    ".rs"
    ".lua"
    ".tf"
    ".tfvars"
  ];
  dutiAssociations = map (target: {
    bundleId = zedBundleId;
    inherit target;
    role = "all";
  }) zedExtensions;

  mkDutiLine =
    {
      bundleId,
      target,
      role ? null,
    }:
    lib.concatStringsSep "\t" (lib.filter (value: value != null) [ bundleId target role ]);
in
{
  home.file."bin/zed" = {
    executable = true;
    text = ''
      #!/bin/sh
      exec /Applications/Zed.app/Contents/MacOS/cli "$@"
    '';
  };

  home.file.".duti".text = lib.concatMapStringsSep "\n" mkDutiLine dutiAssociations + "\n";

  home.activation.applyDutiAssociations = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ -s "$HOME/.duti" ]; then
      run --silence ${lib.getExe pkgs.duti} "$HOME/.duti"
    fi
  '';

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry_mac;
    enableZshIntegration = true;
    defaultCacheTtl = 1800;
    maxCacheTtl = 7200;
  };

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "TokyoNight";
      "font-family" = "JetBrainsMono Nerd Font";
      "font-size" = 18;
      "window-padding-x" = 20;
      "window-padding-y" = 20;
      "confirm-close-surface" = false;
      "clipboard-paste-protection" = false;
      "copy-on-select" = true;
      "macos-option-as-alt" = true;
    };
  };

  programs.zed-editor = {
    enable = true;
    package = null;
    extensions = [ "catppuccin" "nix" ];
    userSettings = {
      base_keymap = "Emacs";
      theme = "Catppuccin Frappé";
      terminal = {
        option_as_meta = true;
      };
    };
  };
}

{ lib, pkgs, ... }:
let
  safariBundleId = "com.apple.Safari";
  vscodeBundleId = "com.microsoft.VSCode";
  editorExtensions = [
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
    ".xml"
    ".sql"
    ".go"
    ".rs"
    ".lua"
    ".tf"
    ".tfvars"
  ];
  dutiAssociations =
    map (target: {
      bundleId = vscodeBundleId;
      inherit target;
      role = "all";
    }) editorExtensions
    ++ map (target: {
      bundleId = safariBundleId;
      inherit target;
      role = "all";
    }) [
      "http"
      "https"
      "public.html"
    ];

  mkDutiLine =
    {
      bundleId,
      target,
      role ? null,
    }:
    lib.concatStringsSep "\t" (lib.filter (value: value != null) [ bundleId target role ]);
in
{
  home.packages = [ pkgs.duti ];

  home.file."bin/code" = {
    executable = true;
    text = ''
      #!/bin/sh
      exec "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "$@"
    '';
  };

  home.file.".duti".text = lib.concatMapStringsSep "\n" mkDutiLine dutiAssociations + "\n";

  home.activation.applyDutiAssociations = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ -s "$HOME/.duti" ]; then
      run --silence ${lib.getExe pkgs.duti} "$HOME/.duti"
    fi
  '';

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

  programs.vscode = {
    enable = true;
    package = null;
    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.catppuccin.catppuccin-vsc
        pkgs.vscode-extensions.jnoortheen.nix-ide
      ];
      userSettings = {
        "terminal.integrated.macOptionIsMeta" = true;
        "workbench.colorTheme" = "Catppuccin Frappé";
      };
    };
  };
}

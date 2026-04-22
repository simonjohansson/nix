{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [
      "manaflow-ai/cmux"
    ];
    brews = [
      "nvm"
    ];
    casks = [
      "cmux"
      "codex"
      "firefox"
      "lm-studio"
      "obsidian"
      "opencode-desktop"
      "superset"
      "tailscale-app"
      "signal"
      "slack"
      "spotify"
      "discord"
      "telegram"
      "whatsapp"
      "zed"
      "vlc"
    ];
  };
}

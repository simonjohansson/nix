{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [ ];
    brews = [
      "nvm"
      "opencode"
    ];
    casks = [
      "codex"
      "firefox"
      "lm-studio"
      "obsidian"
      "opencode-desktop"
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

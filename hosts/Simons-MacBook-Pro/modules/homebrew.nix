{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "uninstall";
    };
    taps = [ ];
    brews = [
      "opencode"
    ];
    casks = [
      "codex"
      "discord"
      "firefox"
      "lm-studio"
      "obsidian"
      "opencode-desktop"
      "signal"
      "slack"
      "spotify"
      "tailscale-app"
      "telegram"
      "visual-studio-code"
      "vlc"
      "whatsapp"
    ];
  };
}

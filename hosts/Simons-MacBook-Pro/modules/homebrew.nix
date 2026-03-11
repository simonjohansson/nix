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
      "firefox"
      "ghostty"
      "lm-studio"
      "obsidian"
      "opencode-desktop"
      "signal"
      "slack"
      "spotify"
      "telegram"
      "zed"
      "vlc"
    ];
  };
}

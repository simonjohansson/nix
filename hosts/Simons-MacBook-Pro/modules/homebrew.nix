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
      "mactop"
      "nvm"
    ];
    casks = [
      "cmux"
      "firefox"
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

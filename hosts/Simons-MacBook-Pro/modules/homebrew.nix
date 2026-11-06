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
      "gettext"
      "glib"
      "json-glib"
      "kotlin"
      "libsamplerate"
      "libsndfile"
      "libzip"
      "m68k-elf-binutils"
      "m68k-elf-gcc"
      "opencode"
      "rtaudio"
      "rtmidi"
      "rubberband"
      "zlib"
      "btop"
      "pstree"
    ];
    casks = [
      "codex"
      "discord"
      "firefox"
      "lm-studio"
      "mactex"
      "obsidian"
      "opencode-desktop"
      "orbstack"
      "signal"
      "slack"
      "soulseek"
      "spotify"
      "tailscale-app"
      "telegram"
      "visual-studio-code"
      "vlc"
      "whatsapp"
    ];
  };
}

# Homebrew package configuration
{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    taps = [
    ];
    brews = [
      "mas"
      "tailscale"
    ];
    casks = [
      "zed"
      "visual-studio-code"
      "raycast"
      "antigravity"
      "ghostty"
      "karabiner-elements"
      # "spotify"
      "notion"
      "cleanshot"
      "discord"
      "sozercan/repo/kaset"
      "steipete/tap/codexbar"
      "google-chrome"
      "docker"
      "tailscale"
    ];
    masApps = {
    };
  };
}

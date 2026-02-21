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
      "theboredteam/boring-notch"
    ];
    brews = [
      "mas"
    ];
    casks = [
      "zed"
      "visual-studio-code"
      "raycast"
      "antigravity"
      "TheBoredTeam/boring-notch/boring-notch"
      "ghostty"
      "karabiner-elements"
      "spotify"
      "notion"
      "cleanshot"
      "discord"
      "sozercan/repo/kaset"
      "steipete/tap/codexbar"
      "google-chrome"
      "docker"
    ];
    masApps = {
      "Klack" = 6446206067;
    };
  };
}

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
      # --- System & Networking ---
      "mas"
      "tailscale"
    ];
    casks = [
      # --- Browsers & Communication ---
      "google-chrome"
      # "arc"
      "discord"

      # --- Development & Editors ---
      "visual-studio-code"
      "zed"
      "ghostty"
      "orbstack"
      # "docker"

      # --- AI & Productivity ---
      "claude"
      # "raycast"
      "swama"
      "lm-studio"
      "notion"
      "antigravity"
      "sozercan/repo/kaset"
      # "steipete/tap/codexbar"

      # --- System Utilities ---
      "karabiner-elements"
      "cleanshot"
      "tailscale-app"

      # --- Media & Entertainment ---
      # "spotify"
    ];
    masApps = {
    };
  };
}

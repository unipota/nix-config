# Macbook-specific Homebrew packages
{ ... }:

{
  homebrew = {
    taps = [
      "theboredteam/boring-notch"
    ];
    casks = [
      # --- System Customization ---
      "TheBoredTeam/boring-notch/boring-notch"
    ];
    masApps = {
      # --- Productivity & Utilities ---
      "Klack" = 6446206067;
    };
  };
}

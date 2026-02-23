# Macbook-specific Homebrew packages
{ ... }:

{
  homebrew = {
    taps = [
      "theboredteam/boring-notch"
    ];
    casks = [
      "TheBoredTeam/boring-notch/boring-notch"
    ];
    masApps = {
      "Klack" = 6446206067;
    };
  };
}

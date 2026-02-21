# Nix packages installed system-wide
{ pkgs, ... }:

{
  # These packages are available to all users.
  environment.systemPackages = with pkgs; [
    git
    nh
    nixfmt
    nix-output-monitor
    kanata-with-cmd
  ];
}

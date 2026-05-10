# Nix packages installed system-wide
{ pkgs, ... }:

{
  # These packages are available to all users.
  environment.systemPackages = with pkgs; [
    git
    nh
    nixfmt
    nix-output-monitor
    ollama
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (_: prev: {
      direnv = prev.direnv.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];
}

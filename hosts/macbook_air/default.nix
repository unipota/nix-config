{ ... }:

{
  imports = [
    ./system.nix
    ./homebrew.nix
    ./packages.nix
    ./services.nix
    ../../home
  ];
}

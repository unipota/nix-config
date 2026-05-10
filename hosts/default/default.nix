{ ... }:

{
  imports = [
    ../../modules/darwin/homebrew.nix
    ./system.nix
    ./homebrew.nix
    ./packages.nix
    ./services.nix
    ../../home
  ];
}
